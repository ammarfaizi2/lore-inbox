Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262602AbTAJEkc>; Thu, 9 Jan 2003 23:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbTAJEkc>; Thu, 9 Jan 2003 23:40:32 -0500
Received: from tisch.mail.mindspring.net ([207.69.200.157]:45882 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S262602AbTAJEkb>; Thu, 9 Jan 2003 23:40:31 -0500
Message-ID: <3E1E50FB.4000301@emageon.com>
Date: Thu, 09 Jan 2003 22:50:03 -0600
From: Brian Tinsley <btinsley@emageon.com>
Organization: Emageon
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440)
References: <3E1E3B64.5040803@emageon.com> <20030110032937.GI23814@holomorphy.com> <3E1E410E.5050905@emageon.com> <20030110035412.GJ23814@holomorphy.com> <3E1E4757.3060206@emageon.com> <20030110041918.GK23814@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>We're straying from the subject here.
>
Sorry

>Please describe your machine,
>in terms of how many cpus it has and how much highmem it has, and
>your workload, so I can better determine the issue. Perhaps we can
>cooperatively devise something that works well for you.
>
IBM x360
Pentium 4 Xeon MP processors

2 processor system has 4GB RAM
4 processor system has 8GB RAM

1 IBM ServeRAID controller
2 Intel PRO/1000MT NICs
2 QLogic 2340 Fibre Channel HBAs

>Or perhaps the kernel version is not up-to-date. Please also provide
>the precise kernel version (and included patches). And workload too.
>
The kernel version is stock 2.4.20 with Chris Mason's data logging and 
journal relocation patches for ReiserFS (neither of which are actually 
in use for any mounted filesystems). It is compiled for 64GB highmem 
support. And just to refresh, I have seen this exact behavior on stock 
2.4.19 and stock 2.4.17 (no patches on either of these) also compiled 
with 64GB highmem support.

Workload:
When the live-lock occurs, the system is performing intensive network 
I/O and intensive disk reads from the fibre channel storage (i.e., the 
backup program is reading files from disk and transferring them to the 
backup server). I posted a snapshot of sar data collection earlier today 
showing selected stats leading up to and just after the live-lock occurs 
(which is noted by a ~2 minute gap in sar logging). After the live-lock 
is released, the only thing that stands out is an unusual increase in 
runtime for kswapd (as reported by ps).

The various Java programs mentioned in prior postings are *mostly* idle 
at this point in time as it is after hours for our clients.


