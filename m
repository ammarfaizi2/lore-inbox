Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317537AbSGZKbp>; Fri, 26 Jul 2002 06:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317577AbSGZKbp>; Fri, 26 Jul 2002 06:31:45 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:48268 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S317537AbSGZKbo>; Fri, 26 Jul 2002 06:31:44 -0400
Date: Fri, 26 Jul 2002 03:31:53 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix compile warnings in suspend.c, 2.5.28
In-Reply-To: <20020726095721.GA220@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0207260317190.18875-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 26 Jul 2002, Pavel Machek wrote:

> Actually, I get two reboots. One expected after suspend and one
> unexpected after resume.

I see.  I'm only getting the single, expected, reboot.  I have found that 
if I mess with the contents of /proc/acpi after resuming, the system 
freezes solid within a few seconds.  I see a patch in Linus' BK tree that 
looks like a possible fix for ACPI.  I'll test that in 2.5.29.  In the 
meantime, I can suspend to disk just fine however.

> TEST_SWSUSP is one so I can test it properly. I want to be Linus's
> swsusp same as mine for 2.5. TEST_SWSUSP is going to be 0 at 2.6.

Sounds fair.  At least I can change it for my own use. :)

> Can you do multiple S4 enters/leaves? Good test is to make bzImage
> while doing while true; do echo 4 > /proc/acpi/sleep; sleep 30; done.

Yes.  Once memory fills up, I can't get enough free pages, but running a
userspace "eatmem" program in the script before suspending fixes that just
fine.  That also speeds up the suspnd/resume time.  The calls to
try_to_free_pages() don't go nearly far enough since the rmap VM stops
freeing memory once *it thinks* there are enough free pages. Being able to
tell it to ignore it's internal watermarks would fix this.

> Throttling the CPU should be pretty easy [see
> /proc/acpi/processor/0/*], and it should already enter sleep modes for
> you.

Neat, thanks! 

Regards,

Craig Kulesa
Steward Obs.
Univ. of Arizona

