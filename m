Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWILD3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWILD3b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 23:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWILD3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 23:29:30 -0400
Received: from mta7.srv.hcvlny.cv.net ([167.206.4.202]:39632 "EHLO
	mta7.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S964838AbWILD3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 23:29:30 -0400
Date: Mon, 11 Sep 2006 23:29:24 -0400
From: Nick Orlov <bugfixer@list.ru>
Subject: [PATCH 2.6.18-rc6-mm1 0/2] cpufreq: make it harder for cpu to leave
 "hot" mode
To: linux-kernel <linux-kernel@vger.kernel.org>, cpufreq@lists.linux.org.uk
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@codemonkey.org.uk>
Mail-followup-to: linux-kernel <linux-kernel@vger.kernel.org>,
 cpufreq@lists.linux.org.uk, Andrew Morton <akpm@osdl.org>,
 Dave Jones <davej@codemonkey.org.uk>
Message-id: <20060912032924.GA3677@nickolas.homeunix.com>
MIME-version: 1.0
Content-type: text/plain; charset=koi8-r
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I was playing with ondemand cpufreq governor (gotta save on electricity
bills one day :) ) and I've noticed that gameplay become somewhat sluggish.
Especially noticeble in something cpu-power demanding, like quake4.
Quick look at stats/trans_table confirmed that CPU goes out of "hot" mode
way too often.

To make long story short - reverting -mm changes for cpufreq_ondemand.c
helps a _LOT_.  I'm not sure if it is something powersave_bias related or
(most probably) due to alignment of "next do_dbs_timer() fire time" which
could make "collect stats" window too short and introduce significant errors.
Have not specifically checked ...

After thinking about the issue for a while I come up with the following tweaks:
First of all I made hysteresis little bit wider (20% instead of 10).
Another idea was to increase "sampling period" once cpu is in "hot" mode.

Second part also have benefits of reducing the load on already overloaded cpu.
Plus it's damn trivial. To simplify further testing I have exposed
"sampling_rate_hot" parameter through sysfs. Setting it to sampling_rate * 10
works for me very well. Now I do not have to switch governor to "performance"
during game sessions.

Tested on AMD64x2 (32 bit mode).

Could you please consider the following patch for inclusion in -mm?
Should be applied after reverting -mm cpufreq_ondemand.c changes.

Thank you,
	Nick Orlov

P.S. These are the first patches I'm sending to LKML: please, be patient :)

-- 
With best wishes,
	Nick Orlov.

