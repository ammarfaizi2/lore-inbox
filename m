Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVECR2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVECR2x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 13:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVECR2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 13:28:53 -0400
Received: from diadema.skane.tbv.se ([193.13.139.13]:33182 "EHLO
	diadema.skane.tbv.se") by vger.kernel.org with ESMTP
	id S261441AbVECR2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 13:28:48 -0400
From: "Oskar Liljeblad" <oskar@osk.mine.nu>
Date: Tue, 3 May 2005 19:28:46 +0200
To: Drew Winstel <DWinstel@Miltope.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: clock drift with two Promise Ultra133 TX2 (PDC 20269) cards
Message-ID: <20050503172845.GA12944@oskar>
References: <66F9227F7417874C8DB3CEB05772741704514D@MILEX0.Miltope.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66F9227F7417874C8DB3CEB05772741704514D@MILEX0.Miltope.local>
User-Agent: Mutt/1.5.6+20040907i
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam detection software, running on the system "diadema.skane.tbv.se", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Tuesday, May 03, 2005 at 11:53, Drew Winstel wrote:
	> I think I know what the problem is. > > In include/linux/libata.h,
	make sure the preprocessor declarations are as > follows. I think the
	defaults have ATA_ENABLE_PATA undefined. > > #define ATA_ENABLE_ATAPI
	/* undefine to disable ATAPI support */ > #define ATA_ENABLE_PATA /*
	define to enable PATA support in some > * low-level drivers */ [...] 
	Content analysis details:   (0.0 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 03, 2005 at 11:53, Drew Winstel wrote:
> I think I know what the problem is.
> 
> In include/linux/libata.h, make sure the preprocessor declarations are as 
> follows.  I think the defaults have ATA_ENABLE_PATA undefined.
> 
> #define ATA_ENABLE_ATAPI        /* undefine to disable ATAPI support */
> #define ATA_ENABLE_PATA          /* define to enable PATA support in some
>                                  * low-level drivers */

Thanks, now it loads correctly. Unfortunately the clock drift still occurs
with pata_pdc2027x. I'm guessing here, but can clock drift have anything
to do with IRQs? Also, is it normal to see errors in /proc/interrupt?

# cat /proc/interrupts 
           CPU0       
  0:     954189          XT-PIC  timer
  2:          0          XT-PIC  cascade
  8:         16          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:       1630          XT-PIC  eth1
 11:     103147          XT-PIC  libata
 12:       9990          XT-PIC  eth0
 14:       5993          XT-PIC  ide0
 15:     145866          XT-PIC  libata
NMI:          0 
LOC:          0 
ERR:      23672
MIS:          0

Regards,

Oskar Liljeblad (oskar@osk.mine.nu)
