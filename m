Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUC3MHP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 07:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbUC3MHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 07:07:15 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:6635 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S263618AbUC3MHI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 07:07:08 -0500
Date: Tue, 30 Mar 2004 21:08:04 +0900 (JST)
Message-Id: <20040330.210804.71938972.taka@valinux.co.jp>
To: Zoltan.Menyhart@bull.net, Zoltan.Menyhart_AT_bull.net@nospam.org
Cc: haveblue@us.ibm.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, iwamoto@valinux.co.jp
Subject: Re: Migrate pages from a ccNUMA node to another - patch
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <40695802.1F13AB0D@nospam.org>
References: <20040330082741.541B77054E@sv1.valinux.co.jp>
	<20040330.180523.08003015.taka@valinux.co.jp>
	<40695802.1F13AB0D@nospam.org>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Zoltán Menyhárt wrote:

> > > > Have you considered any common ground your patch might share with the
> > > > people doing memory hotplug?
> > > >
> > > >     http://people.valinux.co.jp/~iwamoto/mh.html
> > > >
> > > > They have a similar problem to your migration that occurs when a user
> > > > wants to remove a whole or partial NUMA node.
> > > > lhms-devel@lists.sourceforge.net
> > >
> > > Processes must be migrated to other nodes when a node is being
> > > removed.  Conversely, processes may be migrated from other nodes when
> > > a node is added.  I'm not familiar with NUMA things, and I think our
> > > team doesn't have a particular solution.  If you have some idea,
> > > that's great.
> > >
> > > BTW, it seems page migration can use my remap_onepage function.  Our
> > > code can move most kinds of pages including hugetlbfs pages and page
> > > caches.
> > 
> > I believe his patch will interest you since most of the code is
> > independent of cpu architecture and it also covers mmaped files,
> > shmem, ramdisk, mlocked pages and so on.
> > 
> > We will post new version of the memory hotplug patches in a week.
> > 
> > Thank you,
> > Hirokazu Takahashi.
> 
> I am afraid the "remap_onepage()" function + the modifications necessary
> at some other places are too much for me :-)
> 
> You do a couple of retries, waits. I cannot afford spending so much as
> overhead due to some performance optimization.

I understand what you want to do. Page migration is meaningless if the
cost of it is high.

> I can understand that if you want to remove a node / memory module, then you
> have to succeed by all means, you have to handle all kinds of pages,
> the performance is not at a premium.
> 
> Regards,
> 
> Zoltán Menyhárt

It's not hard to add "no-retry-mode" to "remap_onepage()" function
if you want. It may skip to migrate some pages if they are accessed
heavily. In paticular if you only want to care about anonymous pages,
they will be handled very well.

Thank you,
Hirokazu Takahashi.
