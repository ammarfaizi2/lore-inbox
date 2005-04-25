Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbVDYDLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbVDYDLM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 23:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVDYDLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 23:11:11 -0400
Received: from pat.uio.no ([129.240.130.16]:669 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262503AbVDYDKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 23:10:14 -0400
Subject: Re: bdflush/rpciod high CPU utilization, profile does not make
	sense
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Greg Banks <gnb@melbourne.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050424071523.GV17359@unthought.net>
References: <20050411134703.GC13369@unthought.net>
	 <1113230125.9962.7.camel@lade.trondhjem.org>
	 <20050411144127.GE13369@unthought.net>
	 <1113232905.9962.15.camel@lade.trondhjem.org>
	 <20050411154211.GG13369@unthought.net>
	 <1113267809.1956.242.camel@hole.melbourne.sgi.com>
	 <20050412092843.GB17359@unthought.net>
	 <20050419194515.GP17359@unthought.net>
	 <1113950788.10685.9.camel@lade.trondhjem.org>
	 <20050420135758.GS17359@unthought.net>
	 <20050424071523.GV17359@unthought.net>
Content-Type: text/plain
Date: Sun, 24 Apr 2005 23:09:58 -0400
Message-Id: <1114398598.2874.32.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.594, required 12,
	autolearn=disabled, AWL 1.36, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

su den 24.04.2005 Klokka 09:15 (+0200) skreiv Jakob Oestergaard:
> Performance on SMP NFS client:
>          File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
>   Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
> ------- ------ ------- --- ----------- ----------- ----------- -----------
>    .     2000   4096    1  47.53 80.0% 5.013 2.79% 22.34 32.2% 6.510 14.9%
>    .     2000   4096    2  45.29 78.6% 8.068 5.44% 24.53 34.1% 7.042 14.9%
>    .     2000   4096    4  45.38 78.0% 11.02 7.95% 25.13 35.1% 7.525 18.0%
> 
> Performance on UP NFS client:
>          File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
>   Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
> ------- ------ ------- --- ----------- ----------- ----------- -----------
>    .     2000   4096    1  57.11 54.7% 69.60 24.9% 35.09 14.2% 6.656 19.1%
>    .     2000   4096    2  60.11 58.8% 70.99 30.8% 33.82 14.1% 7.283 25.1%
>    .     2000   4096    4  67.89 59.8% 42.10 19.1% 29.86 12.7% 7.850 26.4%
> 
> So, by booting the NFS client in uniprocessor mode, I got a 50% write
> performance boost, 20% read perforamance boost, and the tests use about
> half the CPU time.
> 
> Isn't this a little disturbing?  :)

Actually, the most telling difference here is with the random read rates
which shows up to 1000% difference. I seriously doubt that has much to
do with lock contention (given that the sequential reads show 20% as you
said).

Could you once again have a look at the retransmission rates (both UDP
and TCP), comparing the SMP and UP cases?

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

