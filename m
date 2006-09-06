Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbWIFXuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbWIFXuc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWIFXuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:50:32 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59908 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030251AbWIFXub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:50:31 -0400
Date: Thu, 7 Sep 2006 01:50:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] re-add -ffreestanding
Message-ID: <20060906235029.GC25473@stusta.de>
References: <20060830175727.GI18276@stusta.de> <200608302013.58122.ak@suse.de> <20060830183905.GB31594@flint.arm.linux.org.uk> <20060906223748.GC12157@stusta.de> <Pine.LNX.4.64.0609070115270.6761@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609070115270.6761@scrub.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 01:38:01AM +0200, Roman Zippel wrote:
> Hi,

Hi Roman,

> On Thu, 7 Sep 2006, Adrian Bunk wrote:
> 
> > We are talking about reverting the patch that removed -ffreestanding, 
> > and that broke at least two architectures although it wrongly claimed 
> > it would have been a safe patch.
> 
> Your patch is nevertheless the wrong fix for one of these archs.

it's correct, since with -ffreestanding gcc no longer has the right to 
assume it had a full libc available.

Yes, -ffreestanding disables gcc builtins, but the correct fix for this 
issue is not to remove -ffreestanding, but to check where we want to use 
gcc builtins and enable them explicitely.

This takes more time than the quick'n'dirty patch that removed 
-ffreestanding, but it does it right (and we might perhaps get rid of 
things like include/asm-i386/string.h).

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

