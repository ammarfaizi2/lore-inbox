Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268848AbTGJDN3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 23:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268851AbTGJDN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 23:13:29 -0400
Received: from dyn-ctb-210-9-246-50.webone.com.au ([210.9.246.50]:56324 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S268848AbTGJDNW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 23:13:22 -0400
Message-ID: <3F0CDD3B.4080408@cyberone.com.au>
Date: Thu, 10 Jul 2003 13:27:55 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Diego_Calleja_Garc=EDa?= <diegocg@teleline.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: benchmark: 2.5 io test regression?
References: <20030710013600.1483e80a.diegocg@teleline.es>
In-Reply-To: <20030710013600.1483e80a.diegocg@teleline.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Diego Calleja García wrote:

>Hi. I just went to my 2.5 kernel source tree and i did
>
>#time grep foo * -r
>
>in both 2.4 & 2.5
>
>doing this in 2.4 takes:
>real    0m50.614s
>user    0m1.150s
>sys     0m2.560s
>
>2.5.74-mm3 AS:
>real    0m46.207s
>user    0m1.156s
>sys     0m3.161s
>
>2.5.74-mm3 deadline:
>real    0m57.418s
>user    0m1.160s
>sys     0m3.107s
>
>I repeated the tests and they show very similar numbers. One time 2.4 was faster
>than 2.5 with AS.
>Hardware is p3 2x800 UDMA 100 7200 rpm 2 MB ide disk, filesystem ext3 (default
>mount options). DMA was activated in both 2.4 and 2.5.
>
>
>Should 2.5 be faster here, or it's the expected behaviour? I'd
>have expected a bit more of AS, but perhaps AS it isn't good for
>this benchmark?
>

This test won't exercise the IO scheduler at all - in any kernel.
It only gets 1 read request at a time. Any differences you see
might be due to something happening in the background or just
random variations. If you want to see AS really work, do something
like this in the background, then time your grep.

while true;
do dd if=/dev/zero of=./temp bs=1M count=(the size of your ram);
done


