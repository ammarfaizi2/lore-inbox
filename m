Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131877AbRBKEIl>; Sat, 10 Feb 2001 23:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131934AbRBKEIc>; Sat, 10 Feb 2001 23:08:32 -0500
Received: from msp-65-25-214-194.mn.rr.com ([65.25.214.194]:59789 "EHLO
	msp-65-25-214-194.mn.rr.com") by vger.kernel.org with ESMTP
	id <S130041AbRBKEIO>; Sat, 10 Feb 2001 23:08:14 -0500
Date: Sat, 10 Feb 2001 22:08:08 -0600
From: Rick Richardson <rickr@mn.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Whats the rvmalloc() story?
Message-ID: <20010210220808.A18488@mn.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I note that at least 5 device drivers have similar implementations
of rvmalloc()/rvfree() et al:

	ieee1394/video1394.c
	usb/ibmcam.c
	usb/ov511.c
	media/video/bttv-driver.c
	media/video/cpia.c

rvmalloc()/rvfree() are functions that are used to allocate large
amounts of physically non-contiguous kernel virtual memory that will
then be mmap()'ed into a user process.

I just got done writing a driver that needed rvmalloc() in order to do
chip level simulation.  Yank and put to the rescue.

Whats the story behind rvmalloc() et al?  From what I could tell,
about a year ago there were some patches to move rvmalloc() into
vmalloc() as a blessed feature of the kernel.  But it looks to
me like these patches didn't "take".

Is there some other way of doing this now?  If so, does somebody
need to go into these drivers and patch them for the blessed way?
If not, is there some plan in place to bless these functions and
remvoe the code duplication?

-Rick

-- 
Rick Richardson  rickr@mn.rr.com      http://home.mn.rr.com/richardsons/
Twins Cities traffic animations are at http://members.nbci.com/tctraffic/#1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
