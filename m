Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbTHYHKV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 03:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbTHYHKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 03:10:21 -0400
Received: from poup.poupinou.org ([195.101.94.96]:27953 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S261482AbTHYHKR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 03:10:17 -0400
Date: Mon, 25 Aug 2003 09:10:09 +0200
To: davej@codemonkey.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cpufreq@www.linux.org.uk
Subject: Re: Athlon XP-M and cpufreq freezing Asus laptop to death
Message-ID: <20030825071009.GH19292@poupinou.org>
References: <20030824164828.GA922@renditai.milesteg.arr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030824164828.GA922@renditai.milesteg.arr>
User-Agent: Mutt/1.5.4i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 24, 2003 at 06:48:29PM +0200, Daniele Venzano wrote:
> I don't know if I'm hunting a bug or I have to add support for my
> hardware somewhere.
> I succeded in making C2 work adjusting the DSDT table, I'm uploading the 
> new one on acpi.sf.net under Asus/L3100D
> 
> Now for cpufreq: I'm using the powernow-k7 driver, since the acpi 
> P-state is not supported.
> Whenever I try to change the governor by echoing "powersave" in
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor everything stops
> and a hard reset is required. It seemes to fall in some tight loop since
> after a few seconds the fan goes on as if there is heavy processor
> usage.
> 
> With some printk I have verified that it halts inside wrmsrl() at line
> 199, file powernow-k7.c (2.6.0-test4).
> The call trace is:
> powernow_target/change_speed/change_FID/wrmsrl
> 
> For what is my knowledge (very, very little) the frequency passed to
> powernow_target is right, but I can't say nothing on all other
> parameters...
> 

This is a known issue (at least for me :).  When the difference
between 2 vid and/or 2 fid are too big, that hang.

For now, as a quick (and mostly dirty though) solution is to go
with the userspace governor only and to go to the lowest frequency with
one or two step in-between.

I'm also wondering if those athlons have the same kind of stuff than
the opteron (Dave)?

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
