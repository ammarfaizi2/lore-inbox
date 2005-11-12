Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbVKLX1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbVKLX1B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 18:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbVKLX1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 18:27:00 -0500
Received: from tim.rpsys.net ([194.106.48.114]:49301 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S964858AbVKLX07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 18:26:59 -0500
Subject: Re: More cleanups for sharpsl_pm.c
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20051110235614.GA21337@elf.ucw.cz>
References: <20051110235614.GA21337@elf.ucw.cz>
Content-Type: text/plain
Date: Sat, 12 Nov 2005 23:26:43 +0000
Message-Id: <1131838003.7597.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-11 at 00:56 +0100, Pavel Machek wrote:
> sharpsl.c uses macros to hide method calls, in quite a confusing
> way. This just inlines the macros, so it is easy to see what is going
> on.

I'm not totally convinced this makes it easier to read. To me,
CHARGE_ON(); is more readable than sharpsl_pm.machinfo->charge(1);. Yes,
you need to look up what the macro does but the names give a fairly good
idea.

ALso, keeping the macros means when I implement the LED trigger for
charging, I don't have to edit every function in sharpsl_pm but can just
tweak the header and add an extra level of LED functions. Given that,
I'd prefer to leave these as they are for now.

> +/* FIXME:
> +   why not simply get_percentage, and base it off that?
> +*/
>  	if (sharpsl_pm.charge_mode == CHRG_ON) {
>  		high_thresh = sharpsl_pm.machinfo->status_high_acin;
>  		low_thresh = sharpsl_pm.machinfo->status_low_acin;

The percentage curves is likely to change in the future and I doubt
anyone would remember to update these values. I'd therefore prefer for
them to be independent of the lookup table.

(The table will change once I get more discharge profiles from users and
can work out a more accurate discharge curve).


Richard

