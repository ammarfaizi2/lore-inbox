Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129877AbRBUWLq>; Wed, 21 Feb 2001 17:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130059AbRBUWL0>; Wed, 21 Feb 2001 17:11:26 -0500
Received: from curtis.curtisfong.org ([206.111.86.96]:7429 "EHLO
	curtis.curtisfong.org") by vger.kernel.org with ESMTP
	id <S129877AbRBUWLT>; Wed, 21 Feb 2001 17:11:19 -0500
Date: Wed, 21 Feb 2001 14:11:57 -0800
From: Nye Liu <nyet@curtis.curtisfong.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Very high bandwith packet based interface and performance problems
Message-ID: <20010221141157.A8457@curtis.curtisfong.org>
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
> 
> > With udp, we can get the full 300MBit throughput, but only if we shape
> > the load to 300Mbit. If we increase the load past 300 MBit, the received
> > frames (at the user space udp app) drops to 10-20MBit, again due to
> > user-space application scheduling problems.
> 
> How is your incoming traffic handled architecturally - irq per packet or
> some kind of ring buffer with irq mitigation.  Do you know where the cpu
> load is - is it mostly the irq servicing or mostly network stack ?
> 
> 

Alan: thanks again for your prompt response!

bus mastered DMA ring buffer. As to the load, I'm not quite sure... we
were using a fairly large ring buffer, but increasing/decreasing the size
didn't seem to affect the number of packets per interrrupt. I added a
little watermarking code, and it seems that we do (at peak) about 30-35
packets per interrupt. That is STILL a heck of a lot of interrupts! I
can't quite figure out why the driver refuses to go deeper.

I can think of a couple possible solutions. our interface has a HUGE
amount of hardware buffers, so I can easily simply stop reading for
a small time if we detect conjestion... can you suggest a nice clean
mechanism for this?

any other ideas?
