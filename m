Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267997AbRHBBrr>; Wed, 1 Aug 2001 21:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268578AbRHBBrh>; Wed, 1 Aug 2001 21:47:37 -0400
Received: from itvu-63-210-168-13.intervu.net ([63.210.168.13]:11143 "EHLO
	pga.intervu.net") by vger.kernel.org with ESMTP id <S267997AbRHBBrY>;
	Wed, 1 Aug 2001 21:47:24 -0400
Message-ID: <3B68B309.220CFDF0@randomlogic.com>
Date: Wed, 01 Aug 2001 18:55:21 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: SMP possible with AMD CPUs?
In-Reply-To: <E15S6NY-00086O-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Tyan K7 Thunder running dual 1.4GHz Thunderbird CPUs (Straight Athlon CPU, *NOT* Athlon MP). I installed Red Hat 7.1 out of the box (2.4.2-2 kernel).
It works fine, but here are some issues you might want to be aware of:

1. The AMD-760 MP chipset is NOT a drop-in replacment for the AMD-760 chipset. Both the Northbridge and Southbridge have been changed. The Northbrige has a new
ID as does the Southbridge. This means that none of the onboard devices EXCEPT for the NICs and SCSI will work to full capability without some
kernel/configuration tweaking. So far this seems to be true with newer kernels. This is what I've found so far (info. dues to change as I progress):
	a. The IDE is no longer a 7409 PCI ID but 7411 so it operates as a generic IDE (slow as hell).
	b. The AGP is now ID 700C and is not detected unless the agpgart driver is loaded with agp_try_unsupported=1.
	c. The ISA bridge ID is now 7410 (I think, not sure on this one and can't look righ now) and operates in a generic mode.
		1) This makes the Winbond hardware monitor undetectable due to the fact that the SMBus can't be detected, even though lm_sensors does support the Winbond
chip.
	d. The PCI bridge ID is different and (again) operates in a generic mode
	e. The Host bridge ID is now 700C and operates in a generic mode.

2. The Athlon uses PPro APIC and is detected properly, no probelms here.
3. The BIOS (apparently) doesn't setup the MTRR properly on both CPUs making mtrr bitch about a mismatch.
4. To get the better performance from the kernel (over the "stock" RH 7.1 SMP kernel), re-compile using the Athlon SMP configuration from
/usr/src/linuc/configs.
5. The Southbridge is the same AMD-766 that is used in the AMD-760 chipset, but is a newer rev with a different ID.
6. The Northbridge is similar to the AMD-761 but has some new registers that were previously reserved. The new chip is an AMD-762 and has a few new IDs, the
newest one being 700C rev 11. Note that rev 11 is the only one (as per the most recent rev document I've been able to get) with full AGP support. Previous revs
had broken AGP.

Hmmm, that's all that comes to mind so far.

The system is stable, extremely fast (it's helping my SETI@Home count and average times nicely ;-), and I'm very happy I bought it. Now I'll be even happier
once I get full support for the chipset going (If I didn't have to do my UNIX admin gig here at work, maybe I'd have it by now ;-).

PGA

-- 
Paul G. Allen
UNIX Admin II/Programmer
Akamai Technologies, Inc.
www.akamai.com
Work: (858)909-3630
Cell: (858)395-5043
