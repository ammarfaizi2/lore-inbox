Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268817AbRG3OkQ>; Mon, 30 Jul 2001 10:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268800AbRG3OkG>; Mon, 30 Jul 2001 10:40:06 -0400
Received: from pak208.pakuni.net ([207.91.34.208]:55292 "EHLO
	smp.paktronix.com") by vger.kernel.org with ESMTP
	id <S268817AbRG3Ojw>; Mon, 30 Jul 2001 10:39:52 -0400
Date: Mon, 30 Jul 2001 09:46:30 -0500 (CDT)
From: "Matthew G. Marsh" <mgm@paktronix.com>
X-X-Sender: <mgm@netmonster.pakint.net>
To: "William M. Shubert" <wms@igoweb.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Leak in network memory?
In-Reply-To: <3B64D418.3000608@igoweb.org>
Message-ID: <Pine.LNX.4.31.0107300939420.14419-100000@netmonster.pakint.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, 29 Jul 2001, William M. Shubert wrote:

> Hi. I have an application that does a lot of nonblocking networking I/O
> and is fairly sensitive to how much data can be held in the output
> buffers of sockets. All sockets are set to have 64KB (the default) of
> output buffering. This application had been running well with very long
> uptimes for over a year in the 2.2 kernels.

Yes. Same here only using an application that receives data over the
network.

> A couple months ago I upgraded my server to RH 7.1 (with the 2.4.2-2 red
> hat kernel). At first it ran fine, but now after an uptime of 67 days
> I'm starting to see strange problems. It seems as if only a very small
> amount of memory can be held in the output buffer of each socket, even
> though they are still set to 64KB! There isn't a tremendous amount of
> network traffic going on (about 30-100 sockets open at a time, but
> rather low total bandwidth). The fact that each write to a socket only
> writes a few (<8) kbytes is really messing with my performance. I did
> not see this problem until the past week. I tried to trace through the
> kernel code to see why the kernel would be refusing to give me the
> buffering that I ask for, and it looks like if the network code thinks
> that it is using too much memory, then it will behave this way. I'm not
> 100% sure of this, though...which is why I'm posting this message.

Worse here - the app keeps adding memory and the size of the memory is
almost exactly equal to the amount of data transferred in (plus a few
bytes of overhead). This memory is permanently cached and never released.
We have an open case with RH ....

> Does anybody have any hints on how I can track down exactly why my
> output buffers aren't working? I see lots of /proc info related to
> network parameters, but there is little documentation on them. Is there
> a known bug like this in the RH 2.4.2-2 kernel? Would a newer kernel
> help me? (I know, I could just try upgrading and waiting another 60
> days, but 24x7 reliability is very important to my users so I'd rather
> not reboot unless I know that it will help). I searched the archives of
> this mailing list, and found a few interesting references network memory
> consumption in the changelog of the Alan Cox series, but nothing that
> explicitly described a problem like this. Thanks to anybody who can help
> me out here.

We were using the 2.4.5 kernel and were told to go back to the original
kernel and it got worse. ?? When I find out more - looks like a memory
leak in the glibc right now but... - I will let you know.

> Bill Shubert (wms@igoweb.org) <mailto:wms@igoweb.org>
> http://www.igoweb.org/~wms/ <http://igoweb.org/%7Ewms/>

--------------------------------------------------
Matthew G. Marsh,  President
Paktronix Systems LLC
1506 North 59th Street
Omaha  NE  68104
Phone: (402) 932-7250 x101
Email: mgm@paktronix.com
WWW:  http://www.paktronix.com
--------------------------------------------------

