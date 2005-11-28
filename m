Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbVK1VvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbVK1VvG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 16:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVK1VvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 16:51:06 -0500
Received: from tim.rpsys.net ([194.106.48.114]:5775 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751324AbVK1VvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 16:51:05 -0500
Subject: Re: [PATCH] Sharp power management: split into sharpsl-dependend
	and generic parts
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20051121224706.GA12906@elf.ucw.cz>
References: <20051121224706.GA12906@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 21:50:23 +0000
Message-Id: <1133214624.8673.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 23:47 +0100, Pavel Machek wrote:
> Hi!
> 
> This splits sharpsl_pm.c into sharpsl_pm.c and
> sharp_pm.c. sharpsl_pm.c contains stuff that is shared between spitz
> and corgi, sharp_pm.c contains more widely usable code. I'd like
> something like this to be eventually merged... [Of course, I'll
> cleanup #ifdef COLLIE's, I did not realize some were still pending.]

As discussed, I've made a version of this available as:

http://www.rpsys.net/openzaurus/patches/sharpsl_pm_move-r0.patch

This:

* moves the common code into arm/common
* adds a sharpsl_pm.h header file (in asm/hardware)
* adds appropriate Kconfig entries for this
* removes all the "nasty" macros
* refactors temperature measurement slightly
* removes most of the led code. I have some led patches which apply
after the patch above to implement that differently
* combined the status and measurement code into a single machine
dependent function.

I know that the pxa_pm_prepare/enter/finish functions are going to be a
problem on collie but will await the rest of Pavel's findings before
trying to work out the best way to handle it.

I've asked the person working on tosa (SL-C6000) to investigate what
changes he needs to the code to enable tosa to work within this
framework as well.

Richard


