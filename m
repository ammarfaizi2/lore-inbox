Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161277AbVIPT7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161277AbVIPT7Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 15:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbVIPT7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 15:59:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63174 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161274AbVIPT7X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 15:59:23 -0400
Date: Fri, 16 Sep 2005 15:59:19 -0400 (EDT)
Message-Id: <20050916.155919.41629794.davem@redhat.com>
To: kloczek@rudy.mif.pg.gda.pl
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org, aurora-sparc-devel@lists.auroralinux.org
Subject: Re: [2.6.14-rc1/sparc54]: BUG: soft lockup detected on CPU#0!
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.BSO.4.62.0509161405550.5000@rudy.mif.pg.gda.pl>
References: <Pine.BSO.4.62.0509151929580.5000@rudy.mif.pg.gda.pl>
	<20050915.133026.21581824.davem@davemloft.net>
	<Pine.BSO.4.62.0509161405550.5000@rudy.mif.pg.gda.pl>
X-Mailer: Mew version 4.2.52 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz K³oczko <kloczek@rudy.mif.pg.gda.pl>
Date: Fri, 16 Sep 2005 14:42:56 +0200 (CEST)

> On Thu, 15 Sep 2005, David S. Miller wrote:
> 
> > I wonder if the NFS daemon code needs to have some limits put on
> > how much cpu it consumes handling requests before it gives up the
> > cpu.  Perhaps, it has such throttling already, I don't know.
> 
> But this not case NFS server but NSF client. During this lookups I observe 
> rpciod takes 90-99% time of single processor. Load is between 10 and 20.

After studying some code yesterday, NFS client has the same
exact problem as NFS daemon, namely that if you give it enough
work it will never give up the cpu so that other tasks can
be scheduled.

This is a serious bug, and can easily trigger those soft lockup
messages.  Based upon some other reports seen on linux-kernel
and elsewhere, things like the raid1 kernel daemon have a similar
issue as well.

I think you can help things _enormusly_ by turning off SLAB
poisioning, as I said that debugging feature is _VERY_ expensive.
