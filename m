Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751889AbWCCF6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbWCCF6z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 00:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWCCF6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 00:58:55 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:12799 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751697AbWCCF6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 00:58:54 -0500
To: "Yu, Luming" <luming.yu@intel.com>
cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       jgarzik@pobox.com, linux-ide@vger.kernel.org,
       "Duncan" <1i5t5.duncan@cox.net>, "Pavlik Vojtech" <vojtech@suse.cz>,
       linux-input@atrey.karlin.mff.cuni.cz, "Meelis Roos" <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions [600X S3 sleep]
In-Reply-To: Your message of "Fri, 03 Mar 2006 12:46:06 +0800."
             <3ACA40606221794F80A5670F0AF15F840B172CC2@pdsmsx403> 
Date: Fri, 03 Mar 2006 05:58:50 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FF3JS-0003qn-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Subject    : S3 sleep hangs the second time - 600X
>>>> References : http://bugzilla.kernel.org/show_bug.cgi?id=5989

>>From: "Yu, Luming" <luming.yu@intel.com>
>>> According to bug report, the BIOS DSDT is modified.  I don't know
>>> how these changes affect the results of suspend/resume. But, it is
>>> clear this is NOT right approach to fix problem. Hence, I need the
>>> testing report with un-modified DSDT on TP 600X, bios 1.11.

>>I'll try it, although I don't think I'll get any data on the problem.
>>The unmodified DSDT (bios 1.11) lacks an S3 sleep object, so I had to
>>modify the DSDT even to get S3 to sleep at all.  See
>><http://bugzilla.kernel.org/show_bug.cgi?id=3534> for that discussion.

I just tried the first failing commit
(02b28a33aae93a3b53068e0858d62f8bcaef60a3):

Author: Len Brown <len.brown@intel.com>
Date:   Mon Dec 5 16:46:36 2005 -0500

    [ACPI] Enable Embedded Controller (EC) interrupt mode by default
    
    "ec_intr=0" reverts to polling
    "ec_burst=" no longer exists.
    
    Signed-off-by: Len Brown <len.brown@intel.com>
    Acked-by: Luming Yu <luming.yu@intel.com>

but with the vanilla (BIOS 1.11) DSDT.  And not only did S3 sleep
happen, but the thermal+processor bug didn't show up: i.e. it did two
(actually) many S3 sleep-wake cycles.  So the problem is due to
something in the modified DSDT, which is either a problem itself or it
exposes another problem.

[Picture of me hanging head in shame for putting people to the trouble.]

My only excuse is that long ago (2.6.11), the machine wouldn't S3
sleep at all with the vanilla DSDT, and I patched it as recommended by
the ACPI experts.  However, the current ACPI interpreter seems to
handle the 600X's mangy DSDT.

Now I agree 100% with Len Brown that it's best to have ACPI handle
marginal DSDT's, not hack the DSDT.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
