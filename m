Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265794AbUGDUwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265794AbUGDUwy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 16:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265799AbUGDUwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 16:52:54 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:33910 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S265794AbUGDUwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 16:52:51 -0400
X-Ironport-AV: i="3.81R,146,1083560400"; 
   d="scan'208"; a="52507701:sNHT25000856"
Date: Sun, 4 Jul 2004 15:52:51 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Pavel Machek <pavel@suse.cz>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       David Balazic <david.balazic@hermes.si>
Subject: Re: Weird:  30 sec delay during early boot
In-Reply-To: <40E83F53.3050006@pobox.com>
Message-ID: <Pine.LNX.4.44.0407041536040.19105-100000@humbolt.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This 30-second pause only appeared recently on my x86-64 box (VIA-based 
> Athlon64), so I'll bsearch changesets when I get a free moment (sometime 
> this week).

It's definitely the EDD code that causes the delay, though I believe
it's a BIOS problem.

I've got one report
http://marc.theaimsgroup.com/?l=linux-kernel&m=108797825504429&w=2
from David Balazic with his  Gigabyte GA-7 VAXP Ultra motherboard.
 BIOS version is F6.
 Disks :
  - Quantum lct20 20 GB
  - IBM Deskstar 120GXP 60 GB
 Both on the Promise PDC 20276 on-board controller, each on its own
 channel(cable).

where there was a delay, which was variable based on stuff he put on
the kernel command line. Likewise, downgrading to BIOS F4 did not
exhibit any delay.

I've got another report with this board with a different BIOS 
where this BIOS version on that board:
Motherboard:  Gigabyte GA-7IXE4
BIOS version: FAd  (that's a beta version)
Kernel:       2.6.2-mm1

worked without the delay.

Yours is the first x86-64 BIOS I've heard with a problem.  Please
provide the disk controller type and BIOS version.

> I wonder, even, if it is related to the bootsetup.h fix from Matt that I 
> forwarded recently.

Only that it's now probing more than just the first disk, but the
first 16 possible BIOS disks.  If the BIOS behaves badly to an int13
READ_SECTORS command, that'd be good to know...

I'm open to suggestions on how to know, from real mode, if a BIOS will
misbehave...

FWIW, I'm on vacation this week, with limited email access, but will
respond when I can.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

