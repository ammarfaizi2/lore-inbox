Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262939AbVCQB1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbVCQB1r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 20:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbVCQB1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 20:27:47 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:24740 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262939AbVCQB1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 20:27:31 -0500
Message-ID: <4238DD01.9060500@g-house.de>
Date: Thu, 17 Mar 2005 02:27:29 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050212)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: Re: oom with 2.6.11
References: <422DC2F1.7020802@g-house.de> <2cd57c9005031102595dfe78e6@mail.gmail.com> <4231B4E9.3080005@g-house.de> <42332F9C.7090703@g-house.de>
In-Reply-To: <42332F9C.7090703@g-house.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello again,

unfortunately i've hit OOM again, this time with "#define DEBUG" enabled
in mm/oom_kill.c:

http://nerdbynature.de/bits/sheep/2.6.11/oom/oom_2.6.11.3.txt

by "Mar 16 18:32" pppd died again and OOM kicked in 30min later.
(there are a *lot* messages of a shell script named "check-route.sh". it's
a little script which runs every minute or so to check if my default route
is still ok and if ping to the outside world are possible. definitely not
a memory hog, but noisy)

since tracking the "most memory consuming applications" did not reveal any
hints [1], i have monitored /proc/slabinfo and /proc/meminfo this time:

http://nerdbynature.de/bits/sheep/2.6.11/oom/daily_stats-2.6.11.3.gz

as stated before, i was suspecting pppd to be the bad guy here, and yes: i
downgraded pppd to an earlier version and pppd (and the system) survived 2
terminations of my dial-up ISP. yesterday i've upgraded back again to
current pppd (debian/unstable) and the OOM problem returned. yes, i'll bug
the debian people now (hello!), but grepping for "ppp" in
daily_stats-2.6.11.3.gz gives no hits. so "pppd" does not get *any* points
from mm/oom_kill.c and thus no attempts are made to kill it (it is always
only kill'able with "-9"). furthermore, i thought /proc/slabinfo coud give
me some hints about *where* all the memory went in. scrolling down this
file to the bottom, where "SwapFree" shows "0 kB" i don't see any alarming
numbers in the "slabinfo" right above "meminfo".

could someone give me a hint, please?

thanks,
Christian.

[1] http://lkml.org/lkml/2005/3/12/88

more info for this recent OOM issue:
http://nerdbynature.de/bits/sheep/2.6.11/oom/dmesg.2.6.11.3
http://nerdbynature.de/bits/sheep/2.6.11/oom/lsmod_2.6.11.3
http://nerdbynature.de/bits/sheep/2.6.11/oom/config-2.6.11.3.gz
-- 
BOFH excuse #62:

need to wrap system in aluminum foil to fix problem
