Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268217AbUHKU3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268217AbUHKU3h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 16:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268219AbUHKU3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 16:29:25 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57785 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268217AbUHKU3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 16:29:19 -0400
Date: Wed, 11 Aug 2004 22:19:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nathan Bryant <nbryant@optonline.net>
Cc: Pavel Machek <pavel@ucw.cz>,
       "'James Bottomley'" <James.Bottomley@steeleye.com>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: [PATCH] SCSI midlayer power management
Message-ID: <20040811201944.GA1550@openzaurus.ucw.cz>
References: <4119611D.60401@optonline.net> <20040811080935.GA26098@elf.ucw.cz> <411A1B72.1010302@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411A1B72.1010302@optonline.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >swsusp will then resume disk and write the image, that should not be 
> >a
> >problem. Is it guaranteed that after generic_scsi_suspend() no DMA is
> >going on?
> > 
> >
> No. Remember that DMA works differently under SCSI than it does under 
> IDE. SCSI DMA is a host controller feature, whereas under IDE it is 
> enabled/disabled at the drive level and the drives have special 
> knowledge of DMA. Since generic_scsi_suspend() is the device level 
> suspend routine, it is called before the host controller's suspend 
> routine, (due to depth first traversal of device tree), which is 
> responsible for disabling the PCI slot. Only after the host 
> controller is suspended will there be no DMA, but if your real 
> question is "can I generically control a SCSI disk with PIO for 
> software suspend" then the answer is NO. For purposes of not 

No, I do not need PIO. I'll probably need host
controller support, too, but even w/o it it should
work acceptably. Thanks for the answers.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

