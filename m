Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161340AbWALWAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161340AbWALWAu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161341AbWALWAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:00:49 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:41616 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1161340AbWALWAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:00:48 -0500
Date: Thu, 12 Jan 2006 23:00:32 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
cc: Chase Venters <chase.venters@clientec.com>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org
Subject: Re: [ck] Bad page state at free_hot_cold_page
In-Reply-To: <20060112092406.GA2587@rhlx01.fht-esslingen.de>
Message-ID: <Pine.LNX.4.61.0601122257500.30373@yvahk01.tjqt.qr>
References: <200601120301.00361.chase.venters@clientec.com>
 <20060112092406.GA2587@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Greetings,
>> 	(I'm posting this to LKML and CK because I'm not sure if any of 2.6.15-ck1's 
>> changes might cause this scenario)
>> 	Recently I've noticed that after my desktop has been up for a while, my music 
>> playback / mouse cursor movement will on occasion pause briefly. I got 
>> frustrated with it a minute ago and decided to kill artsd, wondering if there 
>> could be issues with both arts and amarok's backend holding the audio device 
>> open at once.
>> 	When running killall artsd, I locked up for a second and found this in dmesg:
>> 
>> Bad page state at free_hot_cold_page (in process 'artsd', page b1761620)
>> flags:0x80000404 mapping:00000000 mapcount:0 count:0
>> Backtrace:
>>  [<b0148e9a>] bad_page+0x84/0xbc
>>  [<b0149699>] free_hot_cold_page+0x65/0x13a
>>  [<b05b6901>] _spin_unlock_irqrestore+0xf/0x23
>>  [<b0153bf1>] zap_pte_range+0x1d1/0x28f
>>  [<b0153d70>] unmap_page_range+0xc1/0x122
>>  [<b0153ebe>] unmap_vmas+0xed/0x242
>>  [<b0158099>] unmap_region+0xb4/0x156
>>  [<b01583e2>] do_munmap+0x108/0x144
>>  [<b015846f>] sys_munmap+0x51/0x76
>>  [<b0102eff>] sysenter_past_esp+0x54/0x75
>> Trying to fix it up, but a reboot is needed

Ftr, I get the same stackdump when shutting down X. But look no 
further: I use an ancient nvidia and 2.6.15 (vanilla). No bad ram here,
even tested last week before install. :)


Jan Engelhardt
-- 
