Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271721AbTGRGUE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 02:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271722AbTGRGUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 02:20:04 -0400
Received: from dyn-ctb-210-9-243-47.webone.com.au ([210.9.243.47]:51209 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S271721AbTGRGT7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 02:19:59 -0400
Message-ID: <3F1794F0.1090803@cyberone.com.au>
Date: Fri, 18 Jul 2003 16:34:24 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Davide Libenzi <davidel@xmailserver.org>, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] O6int for interactivity
References: <200307170030.25934.kernel@kolivas.org> <200307170030.25934.kernel@kolivas.org> <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Galbraith wrote:

> At 03:12 PM 7/16/2003 -0700, Davide Libenzi wrote:
>
>> http://www.xmailserver.org/linux-patches/irman2.c
>>
>> and run it with different -n (number of tasks) and -b (CPU burn ms 
>> time).
>> At the same time try to build a kernel for example. Then you will 
>> realize
>> that interactivity is not the bigger problem that the scheduler has 
>> right
>> now.
>
>
> I added an irman2 load to contest.  Con's changes 06+06.1 stomped it 
> flat [1].  irman2 is modified to run for 30s at a time, but with 
> default parameters.
>
>         -Mike
>
> [1] imho a little too flat.  it also made a worrisome impression on 
> apache bench
>
>
>------------------------------------------------------------------------
>
>no_load:
>Kernel          [runs]	Time	CPU%	Loads	LCPU%	Ratio
>2.5.69               1	153	94.8	0.0	0.0	1.00
>2.5.70               1	153	94.1	0.0	0.0	1.00
>2.6.0-test1          1	153	94.1	0.0	0.0	1.00
>2.6.0-test1-mm1      1	152	94.7	0.0	0.0	1.00
>cacherun:
>Kernel          [runs]	Time	CPU%	Loads	LCPU%	Ratio
>2.5.69               1	146	98.6	0.0	0.0	0.95
>2.5.70               1	146	98.6	0.0	0.0	0.95
>2.6.0-test1          1	146	98.6	0.0	0.0	0.95
>2.6.0-test1-mm1      1	146	98.6	0.0	0.0	0.96
>process_load:
>Kernel          [runs]	Time	CPU%	Loads	LCPU%	Ratio
>2.5.69               1	331	43.8	90.0	55.3	2.16
>2.5.70               1	199	72.4	27.0	25.5	1.30
>2.6.0-test1          1	264	54.5	61.0	44.3	1.73
>2.6.0-test1-mm1      1	323	44.9	88.0	54.2	2.12
>ctar_load:
>Kernel          [runs]	Time	CPU%	Loads	LCPU%	Ratio
>2.5.69               1	190	77.9	0.0	0.0	1.24
>2.5.70               1	186	80.1	0.0	0.0	1.22
>2.6.0-test1          1	213	70.4	0.0	0.0	1.39
>2.6.0-test1-mm1      1	207	72.5	0.0	0.0	1.36
>xtar_load:
>Kernel          [runs]	Time	CPU%	Loads	LCPU%	Ratio
>2.5.69               1	196	75.0	0.0	3.1	1.28
>2.5.70               1	195	75.9	0.0	3.1	1.27
>2.6.0-test1          1	193	76.7	1.0	4.1	1.26
>2.6.0-test1-mm1      1	195	75.9	1.0	4.1	1.28
>io_load:
>Kernel          [runs]	Time	CPU%	Loads	LCPU%	Ratio
>2.5.69               1	437	34.6	69.1	15.1	2.86
>2.5.70               1	401	37.7	72.3	17.4	2.62
>2.6.0-test1          1	243	61.3	48.1	17.3	1.59
>2.6.0-test1-mm1      1	336	44.9	64.5	17.3	2.21
>

Looks like gcc is getting less priority after a read completes.
Keep an eye on this please.


