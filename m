Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVDKMf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVDKMf6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 08:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVDKMf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 08:35:58 -0400
Received: from pat.uio.no ([129.240.130.16]:45705 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261574AbVDKMfv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 08:35:51 -0400
Subject: Re: bdflush/rpciod high CPU utilization, profile does not make
	sense
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Greg Banks <gnb@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050411074806.GX347@unthought.net>
References: <20050406160123.GH347@unthought.net>
	 <20050406231906.GA4473@sgi.com> <20050407153848.GN347@unthought.net>
	 <1112890671.10366.44.camel@lade.trondhjem.org>
	 <20050409213549.GW347@unthought.net>
	 <1113083552.11982.17.camel@lade.trondhjem.org>
	 <20050411074806.GX347@unthought.net>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Apr 2005 08:35:39 -0400
Message-Id: <1113222939.14281.17.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.666, required 12,
	autolearn=disabled, AWL 1.28, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

må den 11.04.2005 Klokka 09:48 (+0200) skreiv Jakob Oestergaard:

> tcp with timeo=600 causes retransmits (as seen with nfsstat) to drop to
> zero.

Good.

>          File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
>   Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
> ------- ------ ------- --- ----------- ----------- ----------- -----------
>    .     2000   4096    1  60.50 67.6% 30.12 14.4% 22.54 30.1% 7.075 27.8%
>    .     2000   4096    2  59.87 69.0% 34.34 19.0% 24.09 35.2% 7.805 30.0%
>    .     2000   4096    4  62.27 69.8% 44.87 29.9% 23.07 34.3% 8.239 30.9%
> 
> So, reads start off better, it seems, but writes are still half speed of
> 2.4.25.
>
> I should say that it is common to see a single rpciod thread hogging
> 100% CPU for 20-30 seconds - that looks suspicious to me, other than
> that, I can't really point my finger at anything in this setup.

That certainly shouldn't be the case (and isn't on any of my setups). Is
the behaviour identical same on both the PIII and the Opteron systems?

As for the WRITE rates, could you send me a short tcpdump from the
"sequential write" section of the above test? Just use "tcpdump -s 90000
-w binary.dmp"  just for a couple of seconds. I'd like to check the
latencies, and just check that you are indeed sending unstable writes
with not too many commit or getattr calls.

Cheers
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

