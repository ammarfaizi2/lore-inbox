Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267532AbUG2Wr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267532AbUG2Wr1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267510AbUG2WoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:44:18 -0400
Received: from gprs214-254.eurotel.cz ([160.218.214.254]:52355 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267518AbUG2WnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:43:24 -0400
Date: Fri, 30 Jul 2004 00:39:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: David Brownell <david-b@pacbell.net>,
       Alexander Gran <alex@zodiac.dnsalias.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fixing usb suspend/resuming
Message-ID: <20040729223959.GF18623@elf.ucw.cz>
References: <200405281406.10447@zodiac.zodiac.dnsalias.org> <40F962B6.3000501@pacbell.net> <200407190927.38734@zodiac.zodiac.dnsalias.org> <200407202205.37763.david-b@pacbell.net> <20040729083543.GG21889@openzaurus.ucw.cz> <1091103438.2703.13.camel@desktop.cunninghams> <20040729210256.GC18623@elf.ucw.cz> <1091140000.2703.27.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091140000.2703.27.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, its more complicated, I believe. You can't just leave those
> > devices running, because they could DMA and damage the image... So you
> 
> I'm assuming (and believe I have achieved) that the only process doing
> anything significant is suspend, in which case the image isn't going to
> get damaged.

Well, only suspend is doing something significant, but driver might
take arbitrary time to do its DMA... Like

Freeing some memory... [write starts]
Suspending devices... [but you did not suspend disk!]
Atomic copy... [oops, that disk was *still* doing DMA]

> > need something like
> > 
> > suspend_fast_ill_resume_you_soon().
> 
> Don't understand what you're saying here, sorry.

Well, I believe we really need to suspend *all* devices. We just do
not need to spin the disks down and make screens blank; we still need
drivers to be stopped so that no activity happens during atomic copy.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
