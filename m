Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129447AbRBMNtZ>; Tue, 13 Feb 2001 08:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129798AbRBMNtP>; Tue, 13 Feb 2001 08:49:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33028 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129447AbRBMNtC>;
	Tue, 13 Feb 2001 08:49:02 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200102131255.f1DCt6p02149@flint.arm.linux.org.uk>
Subject: Re: LILO and serial speeds over 9600
To: jas88@cam.ac.uk (James Sutherland)
Date: Tue, 13 Feb 2001 12:55:06 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hpa@transmeta.com (H. Peter Anvin),
        timw@splhi.com, Werner.Almesberger@epfl.ch (Werner Almesberger),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.21.0102131056180.15957-100000@yellow.csi.cam.ac.uk> from "James Sutherland" at Feb 13, 2001 10:57:17 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Sutherland writes:
> If the kernel starts spewing data faster than you can send it to the far
> end, either the data gets dropped, or you block the kernel. Having the
> kernel hang waiting to send a printk to the far end seems like a bad
> situation...

It can actually be useful.  Why?  Lets take a real life example: the
recent IDE multi-sector write bug.

In that specific case, I was logging through one 115200 baud serial port
the swapin activity (in do_swap_page), the swap out activity (in
try_to_swap_out), as well as every IDE request down to individual buffers
as they were written to/read from the drive.  This produces a rather a
lot of data, far faster than a 115200 baud serial port can send it.

The ability then to run scripts which can interpret the data and
pick out errors (eg, we swap in data that is different from the data
that was swapped out) was invaluable for tracking down the problem.

Had messages been dropped, this would not have been possible or would
have indicated false errors.  Blocking the kernel while debug stuff
was sent was far more preferable to loosing messages in this case.
I would imagine that that is also true for the majority of cases as
well.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

