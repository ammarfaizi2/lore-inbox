Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbVHHHSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbVHHHSf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 03:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVHHHSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 03:18:35 -0400
Received: from cantor2.suse.de ([195.135.220.15]:30594 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750743AbVHHHSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 03:18:34 -0400
Message-ID: <42F6F0E9.1050606@suse.de>
Date: Mon, 08 Aug 2005 07:43:05 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050715 Thunderbird/1.0.6 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: tony@atomide.com, ck@vds.kolivas.org, tuukka.tikkanen@elektrobit.com,
       linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Re: [patch] i386 dynamic ticks 2.6.13-rc4 (code reordered)
References: <200508021443.55429.kernel@kolivas.org>	<20050806145418.GA16523@thunk.org> <200508070100.55319.kernel@kolivas.org>
In-Reply-To: <200508070100.55319.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

>> When I enabled dynamic tick using:
>>
>> 	echo 1 > /sys/devices/system/timer/timer0/dyn_tick_state
>>
>> The number of ticks dropped down to 60-70 HZ, bus mastering activity
>> jumpped up to being almost always active,
> 
> Anyone know why this would happen?

This is just a guess, without any actual code-reading:
Maybe the C-state decision process just relies on being called every
tick, so "after X ticks with no BM activity, go to next deeper C state".
As long as 1000 ticks per second are coming in, everything is fine and
we enter C[n+1] after X miliseconds without BM activity. Now if there
are only 60-70 ticks per second, you never get X ticks without BM
activity so you never go deeper than C2.

Just a guess.
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen

