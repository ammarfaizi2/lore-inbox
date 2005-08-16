Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965203AbVHPMyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965203AbVHPMyi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 08:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbVHPMyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 08:54:37 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:25213 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965203AbVHPMyg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 08:54:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aq3RuT+UzSMzXDghdLec2tKX61Z9OaWbQG9EsGgL5O3DfKvjcFpZ8qLNBLUMGSUHeakFZC2R0E/t3s2ICoTYZonXaq5bI4ynLoGyOOMTX7FwCjpsex9wPQnjrPbZDEJ88ixytJ0Tt3KuDq4+tDX9PgSfuYdCfiPAOtrANG8N5mw=
Message-ID: <6bffcb0e050816055437477aaf@mail.gmail.com>
Date: Tue, 16 Aug 2005 14:54:35 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [ANNOUNCE][RFC] PlugSched-5.2.4 for 2.6.12 and 2.6.13-rc6
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <4301330B.3070400@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43001E18.8020707@bigpond.net.au>
	 <6bffcb0e05081505291806f529@mail.gmail.com>
	 <43012427.9080406@bigpond.net.au> <4301330B.3070400@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/16/05, Peter Williams <pwil3058@bigpond.net.au> wrote:
> Peter Williams wrote:
> > Michal Piotrowski wrote:
> >
> >> Hi,
> >> here are my benchmarks (part1):
> >
> >
> > Would you mind doing a few extra runs when you do Zaphod with different
> > configuration parameters?  Namely:
> >
> > 1. default value for max_ia_bonus and max_tpt_bonus set to zero
> > 2. default value for max_tpt_bonus and max_ia_bonus set to zero
> > 3. both max_tpt_bonus and max_ia_bonus set to zero
> >
> > in addition to the run you've already done with them both set to their
> > defaults.
> >
> > These parameters can be set via the files:
> >
> > /sys/cpusched/zaphod/max_ia_bonus
> > /sys/cpusched/zaphod/max_tpt_bonus
> 
> Also, could you print the schedstat data immediately before each run as
> well as after?  This will enable the amount of cpu consumed by other
> activity on the computer during the run.
> 
> Thanks
> Peter
> --
> Peter Williams                                   pwil3058@bigpond.net.au
> 
> "Learning, n. The kind of ignorance distinguishing the studious."
>   -- Ambrose Bierce
> 

here are additional tests of Zaphod scheduler (part1+).

1 max_ia_bonus=default max_tpt_bonus=1 (<- sorry, my big mistake, I
can rerun it if You think that it is necesery)

ng02:~# cat /proc/schedstat
version 12
timestamp 4294828669
cpu0 6 0 0 50 0 27581 11365 7805 6518 12028 9490 16216
domain0 3 74615 74286 213 10011 369 35 0 74286 813 652 2 5536 718 7 0
652 5898 5392 89 12115 1236 25 0 5392 0 0 0 0 0 0 0 0 0 2765 854 0
cpu1 9 0 0 43 0 23815 9899 6639 3872 9024 8916 13916
domain0 3 75250 74902 17 12551 823 2 0 74902 764 635 1 5312 651 0 0
635 3892 3436 107 10030 924 0 0 3436 1 0 1 0 0 0 0 0 0 1287 557 0

ng02:/usr/src/linux-2.6.12# time make all -j8
[..]
real    53m50.308s
user    73m41.361s
sys     5m47.309s

ng02:/usr/src/linux-2.6.12# cat /proc/scheduler
zaphod
ng02:/usr/src/linux-2.6.12# cat /proc/schedstat
version 12
timestamp 3333744
cpu0 6 0 0 50 0 704151 369300 155105 115309 2553853 9337517 334851
domain0 3 442011 416564 237 2659989 240011 35 0 416564 275875 85866 4
14144768 1493106 7 0 85866 69758 41638 105 2004639 224561 28 0 41638 0
0 0 0 0 0 0 0 0 61856 26188 0
cpu1 9 0 0 43 0 692905 432937 111840 49982 2503830 10233772 259968
domain0 3 444424 413562 138 3196551 288515 6 0 413562 276354 88926 12
14168673 1479753 0 0 88926 43605 18661 135 1513860 191772 1 0 18661 1
0 1 0 0 0 0 0 0 39796 15220 0

(make clean, reboot)

2 max_tpt_bonus=default max_ia_bonus=0

ng02:~# cat /proc/schedstat
version 12
timestamp 4294736329
cpu0 6 0 0 45 0 24443 9581 6929 5524 8469 7482 14862
domain0 3 29996 29706 6 7644 434 1 0 29706 606 463 2 5365 638 0 0 463 4831 4253
129 12121 1189 2 0 4253 0 0 0 0 0 0 0 0 0 2152 943 0
cpu1 9 0 0 47 0 21331 8444 5946 3792 7270 7520 12887
domain0 3 30319 29993 5 10291 652 1 0 29993 583 459 1 4207 545 0 0 459
3709 3135 128 11252 1040 0 0 3135 1 0 1 0 0 0 0 0 0 1405 623 0

ng02:/usr/src/linux-2.6.12# time make all -j8
[..]
real    51m6.564s
user    76m54.454s
sys     6m25.822s

ng02:/usr/src/linux-2.6.12# cat /proc/scheduler
zaphod
ng02:/usr/src/linux-2.6.12# cat /proc/schedstat
version 12
timestamp 2952618
cpu0 6 0 0 45 0 320718 57175 139391 101798 2959644 9817575 263543
domain0 3 152057 151673 11 14914 1062 1 0 151673 270770 97767 2
15285427 1592321 0 0 97767 55159 33566 142 1764130 187626 2 0 33566 0
0 0 0 0 0 0 0 0 64980 23518 0
cpu1 9 0 0 47 0 279159 42693 127159 62177 2367418 11675673 236466
domain0 3 447572 447107 55 18429 1277 12 0 447107 233998 60674 2
15481677 1604012 0 0 60674 42247 20848 156 1733831 187162 0 0 20848 4
0 4 0 0 0 0 0 0 37593 12259 0

(make clean, reboot)

3 max_tpt_bonus=0 max_ia_bonus=0

ng02:/usr/src/linux-2.6.12# cat /proc/schedstat
version 12
timestamp 11675
cpu0 5 0 0 47 0 71540 28537 29644 27894 20805 9048 43003
domain0 3 148153 147803 4 10552 646 0 0 147803 1002 876 2 4529 563 0 0
876 22990 22404 122 12815 1211 2 0 22404 0 0 0 0 0 0 0 0 0 4906 1101 0
cpu1 10 0 0 60 0 31563 12992 9851 4943 17957 7986 18571
domain0 3 147104 146655 141 10768 437 5 0 146655 1160 1021 2 5429 666
0 0 1021 7517 6962 133 12439 1211 1 0 6962 2 0 2 0 0 0 0 0 0 1750 566
0

ng02:/usr/src/linux-2.6.12# time make all -j8
[..]
real    51m6.603s
user    76m52.540s
sys     6m23.543s

ng02:/usr/src/linux-2.6.12# cat /proc/scheduler
zaphod
ng02:/usr/src/linux-2.6.12# cat /proc/schedstat
version 12
timestamp 3115369
cpu0 5 0 0 47 0 374548 76035 167205 128963 2979961 10874604 298513
domain0 3 226463 225988 13 22104 1676 2 0 225988 278776 91526 2
16756230 1738221 0 0 91526 72724 51543 154 1688685 184528 2 0 51543 2
0 2 0 0 0 0 0 0 66687 22160 0
cpu1 10 0 0 60 0 287129 47253 129103 62414 2359157 10725845 239876
domain0 3 533436 532838 197 20068 1159 13 0 532838 240341 53220 3
16822420 1740549 0 0 53220 46356 24486 156 1771913 191086 1 0 24486 4
0 4 0 0 0 0 0 0 38242 12689 0

Regards,
Michal Piotrowski
