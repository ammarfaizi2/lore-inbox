Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbVCJPMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbVCJPMi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 10:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVCJPMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 10:12:38 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:14725 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262631AbVCJPMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 10:12:33 -0500
Message-ID: <423063DB.40905@g-house.de>
Date: Thu, 10 Mar 2005 16:12:27 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050212)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: elenstev@mesatop.com, Mauricio Lin <mauriciolin@gmail.com>
Subject: Re: oom with 2.6.11
References: <422DC2F1.7020802@g-house.de>	 <3f250c710503090518526d8b90@mail.gmail.com> <3f250c7105030905415cab5192@mail.gmail.com> <422F016A.2090107@g-house.de>
In-Reply-To: <422F016A.2090107@g-house.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok,

as "promised", it the OOM happened again with the same plain 2.6.11,
details here.

http://nerdbynature.de/bits/sheep/2.6.11/oom/oom_2.6.11_2.txt

the following is a quite long, but please read on
(if anyone is reading at all :))

this time it happened at 08:01, and i could image some heavy cron jobs
were going on. but as i said: "it did not happen before". there are also
output of SYSRQ-T/M/P. i did SYSRQ-E to recover the machine, but then
decided to reboot back to 2.6.11-rc5-bk2.

i had a look at the changelogs too and noticed that ChangeLog-2.6.11
contains 7 occurrences of "OOM" in the patch desctiption:

[PATCH] mm: overcommit updates, 2005-01-03
[PATCH] vmscan: count writeback pages in nr_scanned, 2005-01-08
[PATCH] possible rq starvation on oom, 2005-01-13
[PATCH] mm: adjust dirty threshold for lowmem-only mappings, 2005-01-25
[PATCH] mm: oom-killer tunable, 2005-02-02
[PATCH] mm: fix several oom killer bugs, 2005-02-02
[PATCH] Fix oops in alloc_zeroed_user_highpage() when [...],2005-02-09

release dates:
2.6.11-rc5-bk1  26-Feb-2005
2.6.11-rc5-bk2  27-Feb-2005  <
2.6.11-rc5-bk3  28-Feb-2005
2.6.11-rc5-bk4  01-Mar-2005
2.6.11          02-Mar-2005

so i really don't see any patches that *could* have something to do with
the issue here.

now comes the weird part:

i was going to compile 2.6.11-rc5-bk4, to sort out the "bad" kernel.
compiling went fine. ok, finished some email, ok, suddenly my swap was
used up again, and no memory left - uh oh! OOM again, with 2.6.11-rc5-bk2!

to summarize it:
i've run 2.6.11-rc2-bk10 during whole february, then switched to
2.6.11-rc5-bk2 on 28.02.2005, then to 2.6.11 on 05.03.2005 - and only
noticed with 2.6.11 first, now with 2.6.11-rc5-bk2 too.

there is an interesting part in the logfiles:

http://nerdbynature.de/bits/sheep/2.6.11/oom/oom_2.6.11.txt
http://nerdbynature.de/bits/sheep/2.6.11/oom/oom_2.6.11_2.txt
http://nerdbynature.de/bits/sheep/2.6.11/oom/oom_2.6.11-rc5-bk2.txt

every last message before the "OOM" messages is something with pppd:

Mar 10 13:45:55 sheep pppd[1567]: Starting link
Mar 10 14:12:29 sheep kernel: oom-killer: gfp_mask=0x1d2

Mar  8 00:59:58 sheep pppd[418]: Starting link
Mar  8 01:27:33 sheep kernel: oom-killer: gfp_mask=0xd0

Mar  9 07:33:49 sheep pppd[30937]: Starting link
Mar  9 08:01:35 sheep kernel: oom-killer: gfp_mask=0x1d2

and 30min later OOM kicks in. normally, pppd (pppoe) gives messages like this:

Mar 10 14:23:38 sheep pppd[26365]: Starting link
Mar 10 14:23:38 sheep pppd[26365]: Serial connection established.
Mar 10 14:23:38 sheep pppd[26365]: Connect: ppp0 <--> /dev/pts/0
Mar 10 14:23:38 sheep pppoe[26383]: PADS: Service-Name: ''
Mar 10 14:23:38 sheep pppoe[26383]: PPP session is 6804
Mar 10 14:23:39 sheep pppd[26365]: CHAP authentication succeeded
Mar 10 14:23:40 sheep pppd[26365]: Local IP address changed to
[...]

is this strange? or not?

i hope someone has a hint for me, because "going back to the stable
kernel" would mean "being bound to 2.6.11-rc2-bk10" :(

thank you for any hints,
Christian.

PS: Steven, i've cc'ed you because you have trouble with new 2.6.11
kernels and pppd too. maybe unrelated, maybe not.
-- 
BOFH excuse #185:

system consumed all the paper for paging
