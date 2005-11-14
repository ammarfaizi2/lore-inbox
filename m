Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbVKNPdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbVKNPdr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 10:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVKNPdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 10:33:47 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26857 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751155AbVKNPdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 10:33:46 -0500
Date: Mon, 14 Nov 2005 13:08:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Todd Poynor <tpoynor@mvista.com>
Cc: Ian Campbell <ijc@hellion.org.uk>, linux-mtd@lists.infradead.org,
       David Woodhouse <dwmw2@infradead.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: latest mtd changes broke collie
Message-ID: <20051114120807.GA1570@elf.ucw.cz>
References: <20051110103823.GB2401@elf.ucw.cz> <1131619903.27347.177.camel@baythorne.infradead.org> <20051110105954.GE2401@elf.ucw.cz> <1131621090.27347.184.camel@baythorne.infradead.org> <20051110224158.GC9905@elf.ucw.cz> <4373DEB4.5070406@mvista.com> <20051111001617.GD9905@elf.ucw.cz> <1131692514.3525.41.camel@localhost.localdomain> <20051112213355.GA4676@elf.ucw.cz> <437796B7.9070800@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437796B7.9070800@mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >[Plus I get a warning from jffs2 that flashsize is not aligned to
> >erasesize. Then I get lot of messages that empty flash at XXX ends at
> >XXX.]
> 
> The datasheet ref'ed earlier says the chips have a 64KB erase block 
> size, and the sharp driver multiplies that value by an interleave of 4 
> chips to set the erase size.  What erase size is set under the new 

I'm currently using:

        {
                .mfr_id         = 0x00b0,
                .dev_id         = 0x00b0,
                .name           = "Collie hack",
                .uaddr          = {
                        [0] = MTD_UADDR_UNNECESSARY,    /* x8 */
                },
                .DevSize        = SIZE_4MiB,
                .CmdSet         = P_ID_INTEL_STD,
                .NumEraseRegions= 1,
                .regions        = {
                        ERASEINFO(0x10000,64),
                }
        },

...so I should use ERASEINFO(0x40000,16)?

> setup?  cat /proc/mtd or set loglevel for KERN_DEBUG at chip probe time. 
>  The new code is setting it based on what was read from the CFI query 
> info reported by the chip times the interleave factor (which apparently 
> should be set as 4 after detecting 4 chips if CONFIG_MTD_CFI_I4=y).

I do not have collie with me right now.
								Pavel
-- 
Thanks, Sharp!
