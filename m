Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbVKJX6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVKJX6E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 18:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVKJX6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 18:58:04 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:62447 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932224AbVKJX6D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 18:58:03 -0500
Message-ID: <4373DEB4.5070406@mvista.com>
Date: Thu, 10 Nov 2005 15:58:44 -0800
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: latest mtd changes broke collie
References: <20051109221712.GA28385@elf.ucw.cz> <4372B7A8.5060904@mvista.com>	<20051110095050.GC2021@elf.ucw.cz>	<1131616948.27347.174.camel@baythorne.infradead.org>	<20051110103823.GB2401@elf.ucw.cz>	<1131619903.27347.177.camel@baythorne.infradead.org>	<20051110105954.GE2401@elf.ucw.cz>	<1131621090.27347.184.camel@baythorne.infradead.org> <20051110224158.GC9905@elf.ucw.cz>
In-Reply-To: <20051110224158.GC9905@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> With these hacks, I'm able to mount flash at least read-only. On
> attempt to remount read-write, I get 
> 
> "Write error in obliterating obsoleted node at 0x00bc0000: -30
> ...
> Erase at 0x00c00000 failed immediately: -EROFS. Is the sector locked?"
> 
> Is it good news?

I see the old sharp driver has a normally-not-defined AUTOUNLOCK symbol 
that would enable some code to unlock blocks before writing/erasing 
(which isn't recommended since the code doesn't know the policy on 
whether the block is supposed to be locked).  The tree previously in use 
may have had something similar setup.  It seems these flashes have all 
blocks locked by default at power up.

Try flash_unlock /dev/mtdX before remounting.  More automatic means of 
handling this are still under debate, I need to try another stab at 
resolving that soon.

Looks like you're close to obsoleting the pre-CFI Sharp flash driver, 
it's good news...

-- 
Todd
