Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280966AbRKLUJ0>; Mon, 12 Nov 2001 15:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280964AbRKLUJH>; Mon, 12 Nov 2001 15:09:07 -0500
Received: from zok.SGI.COM ([204.94.215.101]:25774 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S280966AbRKLUIz>;
	Mon, 12 Nov 2001 15:08:55 -0500
Message-ID: <3BF028D4.C131A42D@sgi.com>
Date: Mon, 12 Nov 2001 11:53:56 -0800
From: L A Walsh <law@sgi.com>
Organization: Trust Technology, Core Linux, SGI
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: Linux-kernel@vger.kernel.org
Subject: mysterious power off problem 2.4.10-2.4.14 on laptop
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't had time to track this down since I found it.  I'm throwing
it out in case anyone has seen anything that might figure in to this.

Machine: Dell Inspiron 8000.  
Problem: using same options, (starting with 249.config, and using make oldconfig
for new kernel version), I get a kernel that has a bad habit of turning
itself off after some period of time -- not shutting down, just turning off.
This started in 2.4.10 and, and not having the time to debug it, I just
went back to using 2.4.9 which didn't exhibit the problem.

Things tried that haven't worked (not necessarily in any particular order)
1) 2.4.14 kernel
2) disabling power management from the KDE desktop.
3) renaming the apm binary would allow apm control.
4) Turning off apm support in the kernel.
5) Turning off BIOS apm management completely.
	a) BIOS PM on AC-power was set to
		i) turn off inactive video in 10 minutes
		ii) turn off inactive hard disk in 30 minutes
		iii) Suspend: disabled.
		iv) S2D Timeout: disabled

	b) BIOS PM on battery still _is_ set to
		i) turn off inactive video in 3 minutes
		ii) turn off in hard disks in 5 minutes
		iii) Suspend: disabled
		iv) S2D Timeout: 1 hour

	common options:
		v) Smart CPU: enabled
		vi) Display lid closed: <don't shut down, remain active>
		vii) all auto 'wake'/'resume' (on lan, alarm, ring, at time)
			disabled
		viii) CPU Mode: Battery Optimized
----
Other details:
1) I noticed when the machine was on battery -- it turned off in about
   3 minutes -- it might have been 5, but seemed closer to 3.  I note this
   coincides with the Video timeout.  Previously when the timeout
   would occur on AC power -- it seemed that the inactivity timeout was
   about 10 minutes.  My estimations may be wrong, but part of the problem 
   could be related to the video timeout.  
2) testing this problem is a pain, since my disks are still the 
   primitive 'ext2' file system and the multi-gig, laptop-speed disks
   are slow to check.

So am just wondering if someone has seen this, or its a known 'feature change'
with the workaround or solution being 'X'.

I note in the changelog that ACPI changes went into 2.4.10.  I am still using
APM, not ACPI, but it it possible there is common code to both that got
changed?

Thanks for any help.  

-linda
