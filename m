Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWJQQx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWJQQx5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 12:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWJQQx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 12:53:56 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:11229 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1751315AbWJQQx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 12:53:56 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: John Philips <johnphilips42@yahoo.com>
Subject: Re: BUG: warning at kernel/softirq.c:141/local_bh_enable()
Date: Tue, 17 Oct 2006 18:53:56 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <20061017164308.10124.qmail@web57808.mail.re3.yahoo.com>
In-Reply-To: <20061017164308.10124.qmail@web57808.mail.re3.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610171853.56170.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 October 2006 18:43, John Philips wrote:
> >OK, could you please send now :
> >
> >ifconfig eth6
> >cat /proc/interrupts
>
> Eric,
>
> Here you go:
>
> ifconfig eth6:
> eth6      Link encap:Ethernet  HWaddr XX:XX:XX:XX:XX:XX
>           inet addr:X.X.X.X  Bcast:X.X.X.X  Mask:X.X.X.X
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:19015877 errors:0 dropped:880 overruns:82 frame:0
>           TX packets:18771972 errors:1970 dropped:17259 overruns:25
> carrier:25 collisions:0 txqueuelen:1000
>           RX bytes:2956503786 (2.7 GiB)  TX bytes:2149556909 (2.0 GiB)
>           Interrupt:12 Base address:0x8000
>
>
> cat /proc/interrupts:
>            CPU0
>   0:   71570907          XT-PIC  timer
>   2:          0          XT-PIC  cascade
>   4:        465          XT-PIC  serial
>   8:          4          XT-PIC  rtc
>  10:   17076423          XT-PIC  eth1
>  11:    3602236          XT-PIC  eth2
>  12:   52112382          XT-PIC  eth0, eth6
>  14:     955580          XT-PIC  ide0
> NMI:          0
> LOC:          0
> ERR:          0

Hum, given your slow cpu, you might revert tx queue length to 2.4.XX level 
(100 instead of 1000)

ifconfig eth6 txqueuelen 100

Are you sure you cannot post here : 

tc -s -d qdisc show dev eth6

You might want to make inet_peer_cache purge faster :

echo 1 >/proc/sys/net/ipv4/inet_peer_gc_mintime
echo 2 >/proc/sys/net/ipv4/inet_peer_gc_maxtime

Eric
