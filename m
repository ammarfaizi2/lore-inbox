Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261489AbTCZGh3>; Wed, 26 Mar 2003 01:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261490AbTCZGh3>; Wed, 26 Mar 2003 01:37:29 -0500
Received: from waste.org ([209.173.204.2]:29138 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S261489AbTCZGh2>;
	Wed, 26 Mar 2003 01:37:28 -0500
Date: Wed, 26 Mar 2003 00:48:29 -0600
From: Matt Mackall <mpm@selenic.com>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: Jeff Garzik <jgarzik@pobox.com>, Justin Cormack <justin@street-vision.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ENBD for 2.5.64
Message-ID: <20030326064829.GC20244@waste.org>
References: <20030326055525.GA20244@waste.org> <200303260631.h2Q6V9r32048@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303260631.h2Q6V9r32048@oboe.it.uc3m.es>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Both iSCSI and ENBD currently have issues with pending writes during
> > network outages. The current I/O layer fails to report failed writes
> > to fsync and friends.
> 
> ENBD has two (configurable) behaviors here. Perhaps it should have
> more. By default it blocks pending reads and writes during times when
> the connection is down. It can be configured to error them instead.

And in this case, the upper layers will silently drop write errors on
current kernels.

Cisco's Linux iSCSI driver has a configurable timeout, defaulting to
'infinite', btw.

> What I would like is some way of telling how backed up the VM is
> against us. If the VM is full of dirty buffers aimed at us, then
> I think we should consider erroring instead of blocking. The problem is
> that at that point we're likely not getting any requests at all,
> because the kernel long ago ran out of the 256 requests it has in
> hand to send us. 

Hrrmm. The potential to lose data by surprise here is not terribly
appealing. It might be better to add an accounting mechanism to say
"never go above x dirty pages against block device n" or something of
the sort but you can still get into trouble if you happen to have
hundreds of iSCSI devices each with their own request queue..

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
