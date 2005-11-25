Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161109AbVKYQJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbVKYQJA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 11:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbVKYQJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 11:09:00 -0500
Received: from bsamwel.xs4all.nl ([82.92.179.183]:25273 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S1161109AbVKYQI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 11:08:59 -0500
Message-ID: <43873681.6030609@samwel.tk>
Date: Fri, 25 Nov 2005 17:06:25 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Thunderbird 1.5 (Windows/20051025)
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 16/19] readahead: laptop mode support
References: <20051125151210.993109000@localhost.localdomain> <20051125151723.001129000@localhost.localdomain>
In-Reply-To: <20051125151723.001129000@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang wrote:
> When the laptop drive is spinned down, defer look-ahead to spin up time.

Just a n00b question: isn't readahead something that happens at read 
time at the block device level? And doesn't the fact that you're reading 
something imply that the drive is spun up? Or can readahead be triggered 
by reading from cache?

> For crazy laptop users who prefer aggressive read-ahead, here is the way:
> 
> # echo 1000 > /proc/sys/vm/readahead_ratio
> # blockdev --setra 524280 /dev/hda      # this is the max possible value

These amounts of readahead are absolutely useless though. I've done 
measurements about a year ago, that show that at a spindown time of two 
minutes you've basically achieved all the power savings you can get. 
More than 10 minutes of spindown is absolutely useless unless you have a 
desktop drive, because those don't normally support more than 50,000 
spinup cycles. The only apps I can think of that work on this amount of 
data in such a short period of time are all apps where you shouldn't be 
concerned about power drawn by the hard drive. :)

--Bart
