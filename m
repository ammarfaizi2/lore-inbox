Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUIPJ6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUIPJ6S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 05:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267904AbUIPJ6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 05:58:18 -0400
Received: from mx03.cybersurf.com ([209.197.145.106]:25017 "EHLO
	mx03.cybersurf.com") by vger.kernel.org with ESMTP id S261234AbUIPJ6A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 05:58:00 -0400
Subject: RE: The ultimate TOE design
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Leonid Grossman <leonid.grossman@s2io.com>
Cc: "'Jeff Garzik'" <jgarzik@pobox.com>,
       "'David S. Miller'" <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk,
       paul@clubi.ie, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <200409160525.i8G5PtqG009228@guinness.s2io.com>
References: <200409160525.i8G5PtqG009228@guinness.s2io.com>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1095328673.1063.130.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 16 Sep 2004 05:57:54 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-16 at 01:25, Leonid Grossman wrote:
>  
> > -----Original Message-----
> > From: jamal [mailto:hadi@cyberus.ca] 

> > On a serious note, I think that PCI-express (if it lives upto its
> > expectation) will demolish dreams of a lot of these TOE investments.
> > Our problem is NOT the CPU right now (80% idle processing 
> > 450Kpps forwarding). Bus and memory distance/latency are. 
> 
> In servers, both bottlenecks are there - if you look at the cost of TCP and
> filesystem processing at 10GbE, CPU is a huge problem (and will be for
> foreseeable future), even for fastest 64-bit systems. 

True, but with the bus contention being a non-issue you got more of that
xeon being available for use (lets say i can use 50% more of its
capacity then i can do more). IOW, it becomes a compute capacity problem
mostly - one that you should in theory be able to throw more CPU at. SMT
(the way power5 and some of the network processors do it[1]) should go a
long way to address both additional compute and hardware threading to
work around memory latencies. With PCI-express, compute power in
mini-clustering in the form of AS (http://www.asi-sig.org/home) is being
plotted as we speak.
To sumarize: The problem to solve in 24 months maybe 100Gige.

> I agree though that bus and memory are bigger issues, this is exactly the
> reason for all these RDMA over Ethernet investments :-)

And AS does a damn good job at specing all those RDMA requirements; my
view is that intel is going to build them chips - so it can be done on a
$5 board off the pacific rim. This takes most of the small players out
of the market.

> Anyways, did not mean to start an argument - with all the new CPU, bus and
> HBA technologies coming to the market it will be another 18-24 months before
> we know what works and what doesn't...

Agreed. Would you like to invest on something that will obsoleted in
18-24 months though? OR even not obsoleted, but holds that uncertainty?
I think thats the risk facing you when you are in the offload bussiness.

Here are results for Hifn 7956 ref board on 2.6GHz P4 (HT) system,
kernel  2.6.6 SMP as compared to a s/ware only setup on same machine.
[Name of tester withheld to protect privacy].

first column - algo, second - packet size, third - 
time in us spend by hw crypto, forth - time in us spent by sw crypto:

des   64:       28      3
des  128:       29      6
des  192:       33      9
des  256:       33      12
des  320:       37      15
des  384:       38      18
des  448:       41      21
des  512:       42      23
des  576:       45      26
des  640:       46      29
des  704:       49      33
des  768:       50      35
des  832:       53      38
des  896:       54      41
des  960:       57      44
des 1024:       58      47
des 1088:       61      50
des 1152:       62      53
des 1216:       66      56
des 1280:       66      59
des 1344:       70      62
des 1408:       71      65
des 1472:       74      68
des3_ede   64:  28      6
des3_ede  128:  30      13
des3_ede  192:  34      20
des3_ede  256:  43      26
des3_ede  320:  38      33
des3_ede  384:  48      40
des3_ede  448:  44      45
des3_ede  512:  54      53
des3_ede  576:  50      60
des3_ede  640:  59      67
des3_ede  704:  55      74
des3_ede  768:  66      78
des3_ede  832:  61      85
des3_ede  896:  72      94
des3_ede  960:  67      100
des3_ede 1024:  77      107
des3_ede 1088:  73      114
des3_ede 1152:  82      121
des3_ede 1216:  79      127
des3_ede 1280:  88      128
des3_ede 1344:  84      135
des3_ede 1408:  94      147
des3_ede 1472:  90      153
aes   64:       28      2
aes  192:       33      6
aes  320:       37      10
aes  448:       46      15
aes  576:       53      19
aes  704:       53      23
aes  832:       65      28
aes  960:       66      32
aes 1088:       71      37
aes 1216:       80      41
aes 1344:       83      45
aes 1472:       92      50

Moral of the data above: The 2.6Ghz is already showing signs of
obsoleting the hifn crypto offloader[2]. I think it took less than a
year for it to happen.

cheers,
jamal

[1] I also like the MIPS.com approach to SMT

[2] There are actually issues with some of the crypto offloading in
Linux; however this does serve as a good example.

