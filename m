Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVCLSGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVCLSGu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 13:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbVCLSGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 13:06:50 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:20156 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261992AbVCLSG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 13:06:27 -0500
Message-ID: <42332F9C.7090703@g-house.de>
Date: Sat, 12 Mar 2005 19:06:20 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050212)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oom with 2.6.11
References: <422DC2F1.7020802@g-house.de> <2cd57c9005031102595dfe78e6@mail.gmail.com> <4231B4E9.3080005@g-house.de>
In-Reply-To: <4231B4E9.3080005@g-house.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi again,

i had to wait for my pppoe session to be terminated by the remote peer
[1], and now it happened again with 2.6.11-rc5-bk2:

http://nerdbynature.de/bits/sheep/2.6.11/oom/oom_2.6.11-rc5-bk2_2.txt
http://nerdbynature.de/bits/sheep/2.6.11/oom/lsmod_2.6.11-rc5-bk2
http://nerdbynature.de/bits/sheep/2.6.11/oom/config-2.6.11-rc5-bk2.gz

i wanted to see the application chewing up the most RAM so i was running
"ps aux --sort=-vsz,-rss | head -n1" every 5sec and wrote it's output to a
file:

http://nerdbynature.de/bits/sheep/2.6.11/oom/daily_stats-2.6.11-rc5-bk2.log.gz

but even when almost all swap is used up, mysqld ist still no#1 with
131928 KB VSZ, as always. still suspecting something wrong with pppd, the
binary istself does *not* show up on the top-ten-memory-pigs.

real memory is almost always used up, but that's ok.
i stripped it down to show only the timestamp and the "Swap: .. used" numbers:

http://nerdbynature.de/bits/sheep/2.6.11/oom/daily_stats-2.6.11-rc5-bk2_stripped.log.gz

as you can see, until "Sat Mar 12 01:05:51" 122MB swap was used, from then
on swap-usage goes up until "Sat Mar 12 01:49:45", when all swap is in
use. the system is unable to keep up with writing memory usage every 5
seconds, the next entry is from 12 "01:56:24" - 6 minutes after the first
OOM message (i'm sure someone could feed this to gnuplot and make nice
bars out of it - i can't)

where else could i look to actually *see* where the memory goes to?

somehow lost in kernel versions,
Christian.

[1] "remote peer" aka "ISP". is there a way to "simulate" a "LCP
terminated by peer" locally? otherwise i really have to wait 24h to
trigger the bug.
-- 
BOFH excuse #373:

Suspicious pointer corrupted virtual machine
