Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268544AbUHaXHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268544AbUHaXHx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 19:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269115AbUHaXGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 19:06:52 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:45287 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269204AbUHaXDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 19:03:20 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Schmitt <pnambic@unu.nu>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com, tytso@mit.edu
In-Reply-To: <20040831065327.GA30631@elte.hu>
References: <200408282210.03568.pnambic@unu.nu>
	 <20040828203116.GA29686@elte.hu>
	 <1093727453.8611.71.camel@krustophenia.net>
	 <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net>
	 <1093737080.1385.2.camel@krustophenia.net>
	 <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu>
	 <20040830090608.GA25443@elte.hu> <1093934448.5403.4.camel@krustophenia.net>
	 <20040831065327.GA30631@elte.hu>
Content-Type: text/plain
Message-Id: <1093993396.3404.17.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 31 Aug 2004 19:03:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 02:53, Ingo Molnar wrote:
> > > 
> > >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q5
>
> ok. It seems the random driver is _mostly_ in shape latency-wise, except
> the IP rekeying visible in the above trace. To solve this problem, could
> you try the patch below, ontop of -Q5? It moves the random seed
> generation outside of the spinlock - AFAICS the spinlock is only needed
> to protect the IP sequence counter itself.

This solves the problem with the random driver.  The worst latencies I
am seeing are in netif_receive_skb().  With netdev_max_backlog set to 8,
the worst is about 160 usecs:

http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q5#/var/www/2.6.9-rc1-Q5/trace2.txt
http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q5#/var/www/2.6.9-rc1-Q5/trace3.txt

Setting netdev_max_backlog to 1 has no effect:

http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q5#/var/www/2.6.9-rc1-Q5/trace4.txt

I would expect this one to scale with CPU speed, so this is pretty good
considering my relatively underpowered system.  I would imagine on a
fast UP system you would not see any latencies worse than 100 usecs.

Lee




