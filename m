Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286377AbRLJUoA>; Mon, 10 Dec 2001 15:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286376AbRLJUnu>; Mon, 10 Dec 2001 15:43:50 -0500
Received: from chaos.analogic.com ([204.178.40.224]:6016 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S286377AbRLJUnj>; Mon, 10 Dec 2001 15:43:39 -0500
Date: Mon, 10 Dec 2001 15:43:35 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ben Greear <greearb@candelatech.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: min-write-size for a UDP socket to be POLLOUT cannot be set. (proposed fixes)
In-Reply-To: <3C1516DC.5010500@candelatech.com>
Message-ID: <Pine.LNX.3.95.1011210153555.742A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2001, Ben Greear wrote:

> 
> 
> Richard B. Johnson wrote:
> 
> > On Mon, 10 Dec 2001, Ben Greear wrote:
> > 
> > 
> >>This relates to my earlier question about setting the threshold
> >>at which select returns that a (UDP) socket is writable.
> >>
> >>It appears that UDP sockets are hardwired at 2048 bytes...
> >>
> >> From linux/include/net/sock.h:
> >>
> > 
> >     int len = 0x8000;
> > 
> >     setsockopt(s, SOL_SOCKET, SO_SNDBUF, &len, sizeof(len));
> >     setsockopt(s, SOL_SOCKET, SO_RCVBUF, &len, sizeof(len));
> > 
> > 
> > Doesn't this work?
> 
> 
> That sets the queue sizes bigger, but suppose this:
> 
> I have 4M queue size.  I have 4M-2k bytes already in the
> queue (2k free).  I have a 4k UDP buffer to write.  I call
> select and it says the socket is writable.  However, in this
> case I cannot actually write to the socket because I have only
> 2 of the 4k that I need...  Now, I can detect the failure to send
> and re-transmit, but that basically gets me into a tight loop because
> select keeps saying I can write, and I keep trying.  The tight loop
> is doubly bad because the machine is already highly stressed or it's
> buffers would never be so full....
> 
> I want select to only say I can write when I'm at XX (say, 64k) bytes of
> free buffer-queue space...
> 
> Ben
> 

If you have a 4M queue size, it appears as though you are trying to
use UDP where TCP should have been used. Normally, what you call the
queue size, is set to contain you largest packet you will ever want to
send. With this in mind, you don't even know if a fragmented packet
can be routed if it's more than 64k in length so you would never try
to send something larger than that under UDP.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


