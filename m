Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130846AbRBVBYe>; Wed, 21 Feb 2001 20:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130503AbRBVBYY>; Wed, 21 Feb 2001 20:24:24 -0500
Received: from curtis.curtisfong.org ([206.111.86.96]:14086 "EHLO
	curtis.curtisfong.org") by vger.kernel.org with ESMTP
	id <S129892AbRBVBYO>; Wed, 21 Feb 2001 20:24:14 -0500
Date: Wed, 21 Feb 2001 17:24:31 -0800
From: Nye Liu <nyet@curtis.curtisfong.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Very high bandwith packet based interface and performance problems
Message-ID: <20010221172431.A10657@curtis.curtisfong.org>
In-Reply-To: <20010221140055.A8113@curtis.curtisfong.org> <E14VhQ7-0002s0-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.11i
In-Reply-To: <E14VhQ7-0002s0-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Feb 21, 2001 at 10:07:32PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2001 at 10:07:32PM +0000, Alan Cox wrote:
> > that because the kernel was getting 99% of the cpu, the application was
> > getting very little, and thus the read wasn't happening fast enough, and
> 
> Seems reasonable
> 
> > This is NOT what I'm seeing at all.. the kernel load appears to be
> > pegged at 100% (or very close to it), the user space app is getting
> > enough cpu time to read out about 10-20Mbit, and FURTHERMORE the kernel
> > appears to be ACKING ALL the traffic, which I don't understand at all
> > (e.g. the transmitter is simply blasting 300MBit of tcp unrestricted)
> 
> TCP _requires_ the remote end ack every 2nd frame regardless of progress.

YIPES. I didn't realize this was the case.. how is end-to-end application
flow control handled when the bottle neck is user space bound and not b/w
bound? e.g. if i write a test app that does a

while(1) {
    sleep (5);
    read(sock, buf, 1);
}

and the transmitter is unrestricted, what happens?

Does it have to do with TCP_FORMAL_WINDOW (eg. automatically reduce window
size to zero when queue backs up?)

or is it only a cpu loading problem? (ie. is there a difference in queuing
behavior between 1) the user process doesnt get cycles 2) the user process
simply fails to read ?)

Also, I have been reading up on CONFIG_HW_FLOWCONTROL.. what is the
recommended way for the driver to stop receiving? In the sample tulip
code i see you can register a xon callback, but i can't tell if there
is a way to see the backlog from the driver.

-nye
