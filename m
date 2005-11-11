Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbVKKGA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbVKKGA5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 01:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbVKKGA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 01:00:57 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:53005 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1750816AbVKKGA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 01:00:56 -0500
To: akpm@osdl.org
CC: pmarques@grupopie.com, jgarzik@pobox.com, axboe@suse.de, neilb@suse.de,
       linux-kernel@vger.kernel.org
In-reply-to: <20051110161259.1189a040.akpm@osdl.org> (message from Andrew
	Morton on Thu, 10 Nov 2005 16:12:59 -0800)
Subject: Re: userspace block driver?
References: <4371A4ED.9020800@pobox.com>
	<17265.42782.188870.907784@cse.unsw.edu.au>
	<4371A944.6070302@pobox.com>
	<20051109075455.GN3699@suse.de>
	<4371ACE6.7010503@pobox.com>
	<4371EEBA.2080706@grupopie.com>
	<E1EZpTU-0001KK-00@dorka.pomaz.szeredi.hu>
	<E1EZqZK-0001RV-00@dorka.pomaz.szeredi.hu> <20051110161259.1189a040.akpm@osdl.org>
Message-Id: <E1EaRwq-00065e-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 11 Nov 2005 06:59:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > N.B. though FUSE itself is free of deadlocks, as soon as you put
> > something on top of it which has asyncronous page writeback it will
> > not be safe anymore.
> 
> Why?   What goes wrong?

Filesystem daemon can't use GFP_NOIO, and can't set PF_MEMALLOC.  Even
if it could, there's the problem with reply packets from network,
which are not even handled in kernel yet (?).

FUSE sidesteps the issue, by doing writes synchronously and not
allowing shared-writable mappings, hence never dirtying any pages.

The sync write is actually not so bad, the filesystem daemon can do
it's own buffering safely (it's swapabble memory), or do async writes
over the network (letting TCP handle the buffering).

Miklos
