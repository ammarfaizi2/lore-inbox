Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261834AbTCXI3z>; Mon, 24 Mar 2003 03:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261896AbTCXI3z>; Mon, 24 Mar 2003 03:29:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32016 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261834AbTCXI3y>; Mon, 24 Mar 2003 03:29:54 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: lmbench results for 2.4 and 2.5 -- updated results
Date: Mon, 24 Mar 2003 08:39:34 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b5mg86$qm$1@penguin.transmeta.com>
References: <3E7C8B22.7020505@nortelnetworks.com> <3E7EA0F6.8000308@nortelnetworks.com>
X-Trace: palladium.transmeta.com 1048495257 19634 127.0.0.1 (24 Mar 2003 08:40:57 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 24 Mar 2003 08:40:57 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3E7EA0F6.8000308@nortelnetworks.com>,
Chris Friesen  <cfriesen@nortelnetworks.com> wrote:
>
>Here are the results of 2.4.20 and 2.5.65 with as close to matching configs as I 
>could make them.
>
>The ones that stand out are:
>--fork/exec (due to rmap I assume?)
>--mmap (also due to rmap?)

Yes. You could try the objrmap patches, they are supposed to help. They
may be in -mm, I'm not sure.

>--select latency (any ideas?)

I think this is due to the extra TCP debugging, but it might be
something else. To disable the debugging, remove the setting of 
NETIF_F_TSO in linux/drivers/net/loopback.c, and re-test:

        /* Current netfilter will die with oom linearizing large skbs,
         * however this will be cured before 2.5.x is done.
         */
        dev->features          |= NETIF_F_TSO;

>--udp latency (related to select latency?)

I doubt it. But there might be some more overhead somewhere. You should
also run lmbench at least three times to get some feeling for the
variance of the numbers, it can be quite big.

>--page fault (is this significant?)

I don't think so, there's something strange with the lmbench pagefault
tests, it only has one significant digit of accuracy, and I don't even
know what it is testing. Because of the single lack of precision, it's
hard to tell what the real change is.

>--tcp bandwidth (explained as debugging code)

See if the NETIF_F_TSO change makes any difference. If performance is
still bad, holler.

		Linus
