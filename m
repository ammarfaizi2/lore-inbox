Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131025AbRBMOAZ>; Tue, 13 Feb 2001 09:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131618AbRBMOAP>; Tue, 13 Feb 2001 09:00:15 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:43703 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131025AbRBMN76>; Tue, 13 Feb 2001 08:59:58 -0500
Date: Tue, 13 Feb 2001 13:56:37 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Russell King <rmk@arm.linux.org.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@transmeta.com>,
        timw@splhi.com, Werner Almesberger <Werner.Almesberger@epfl.ch>,
        linux-kernel@vger.kernel.org
Subject: Re: LILO and serial speeds over 9600
In-Reply-To: <200102131255.f1DCt6p02149@flint.arm.linux.org.uk>
Message-ID: <Pine.SOL.4.21.0102131353420.15407-100000@green.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001, Russell King wrote:

> James Sutherland writes:
> > If the kernel starts spewing data faster than you can send it to the far
> > end, either the data gets dropped, or you block the kernel. Having the
> > kernel hang waiting to send a printk to the far end seems like a bad
> > situation...
> 
> It can actually be useful.  Why?  Lets take a real life example: the
> recent IDE multi-sector write bug.
> 
> In that specific case, I was logging through one 115200 baud serial port
> the swapin activity (in do_swap_page), the swap out activity (in
> try_to_swap_out), as well as every IDE request down to individual buffers
> as they were written to/read from the drive.  This produces a rather a
> lot of data, far faster than a 115200 baud serial port can send it.
> 
> The ability then to run scripts which can interpret the data and
> pick out errors (eg, we swap in data that is different from the data
> that was swapped out) was invaluable for tracking down the problem.
> 
> Had messages been dropped, this would not have been possible or would
> have indicated false errors.  Blocking the kernel while debug stuff
> was sent was far more preferable to loosing messages in this case.
> I would imagine that that is also true for the majority of cases as
> well.

OK, in this particular case you need to log EVERYTHING for diagnostic
purposes. In most cases, though, I'd rather have some messages dropped
than have the machine slow to a crawl...

Would you be OK with a "blocking netconsole" option, to provide this
behavious where needed? If it's the default, I bet the next Mindcraft
tests will be run with verbose logging on a 9600bps link :-)

Most people wouldn't need/want this, but I can see it would be
useful: giving the user this choice seems a better option. Also, losses on
a 10 or 100 Mbit/sec Ethernet connection will be rather less likely than
they could on a serial link!


James.

