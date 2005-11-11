Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbVKKMDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVKKMDw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 07:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbVKKMDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 07:03:52 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20682 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750705AbVKKMDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 07:03:52 -0500
Date: Fri, 11 Nov 2005 13:03:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, kernel list <linux-kernel@vger.kernel.org>
Subject: sharpsl_pm: using milivolts instead of custom units?
Message-ID: <20051111120300.GA29251@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It seems to me that sharpsl.c is using some very custom units:

#define SHARPSL_CHARGE_ON_VOLT         0x99  /* 2.9V */
#define SHARPSL_CHARGE_ON_TEMP         0xe0  /* 2.9V */
#define SHARPSL_CHARGE_ON_ACIN_HIGH   0x9b  /* 6V */
#define SHARPSL_CHARGE_ON_ACIN_LOW    0x34  /* 2V */
#define SHARPSL_FATAL_ACIN_VOLT        182   /* 3.45V */
#define SHARPSL_FATAL_NOACIN_VOLT      170   /* 3.40V */

...what are they? Unfortunately collie uses very different units:

#ifdef CONFIG_SA1100_COLLIE
struct battery_thresh spitz_battery_levels_noac[] = {
        { 368, 100},
        { 358,  25},
        { 356,   5},
        {   0,   0},
...

...so it could get very confusing. Would it be feasible to convert to
mV as soon as possible and have all constants in milivolts? I realize
they may be slightly different for different models, but they should
at least be comparable.
								Pavel
-- 
Thanks, Sharp!
