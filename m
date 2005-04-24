Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbVDXHPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbVDXHPd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 03:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbVDXHPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 03:15:32 -0400
Received: from unthought.net ([212.97.129.88]:12503 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S262273AbVDXHPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 03:15:25 -0400
Date: Sun, 24 Apr 2005 09:15:24 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Greg Banks <gnb@melbourne.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bdflush/rpciod high CPU utilization, profile does not make sense
Message-ID: <20050424071523.GV17359@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Greg Banks <gnb@melbourne.sgi.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050411134703.GC13369@unthought.net> <1113230125.9962.7.camel@lade.trondhjem.org> <20050411144127.GE13369@unthought.net> <1113232905.9962.15.camel@lade.trondhjem.org> <20050411154211.GG13369@unthought.net> <1113267809.1956.242.camel@hole.melbourne.sgi.com> <20050412092843.GB17359@unthought.net> <20050419194515.GP17359@unthought.net> <1113950788.10685.9.camel@lade.trondhjem.org> <20050420135758.GS17359@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050420135758.GS17359@unthought.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2005 at 03:57:58PM +0200, Jakob Oestergaard wrote:
...
> Will try either changing tg3 driver or putting in an e1000 on my NFS
> server - I will let you know about the status on this when I know more.

tg3 or e1000 on the NFS server doesn't make a noticable difference.

Now, I tried booting the 2.6.11 NFS client in uniprocessor mode
(thinking the rpciod threads might be wasting their time contending for
a lock), and that turned out to be interesting.

Performance on SMP NFS client:
         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     2000   4096    1  47.53 80.0% 5.013 2.79% 22.34 32.2% 6.510 14.9%
   .     2000   4096    2  45.29 78.6% 8.068 5.44% 24.53 34.1% 7.042 14.9%
   .     2000   4096    4  45.38 78.0% 11.02 7.95% 25.13 35.1% 7.525 18.0%

Performance on UP NFS client:
         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     2000   4096    1  57.11 54.7% 69.60 24.9% 35.09 14.2% 6.656 19.1%
   .     2000   4096    2  60.11 58.8% 70.99 30.8% 33.82 14.1% 7.283 25.1%
   .     2000   4096    4  67.89 59.8% 42.10 19.1% 29.86 12.7% 7.850 26.4%

So, by booting the NFS client in uniprocessor mode, I got a 50% write
performance boost, 20% read perforamance boost, and the tests use about
half the CPU time.

Isn't this a little disturbing?  :)

-- 

 / jakob

