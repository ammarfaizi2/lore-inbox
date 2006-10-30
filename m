Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161244AbWJ3QJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161244AbWJ3QJf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 11:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161243AbWJ3QJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 11:09:34 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:35730 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1161232AbWJ3QJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 11:09:34 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Kirill Korotaev <dev@sw.ru>
Subject: Re: [PATCH 2.6.19-rc3] VFS: per-sb dentry lru list
Date: Mon, 30 Oct 2006 17:09:31 +0100
User-Agent: KMail/1.9.5
Cc: Vasily Averin <vvs@sw.ru>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>, Neil Brown <neilb@suse.de>,
       Jan Blunck <jblunck@suse.de>, Olaf Hering <olh@suse.de>,
       Balbir Singh <balbir@in.ibm.com>, Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
References: <4541F2A3.8050004@sw.ru> <200610301608.25861.dada1@cosmosbay.com> <45461BA0.9000405@sw.ru>
In-Reply-To: <45461BA0.9000405@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610301709.31993.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 October 2006 16:34, Kirill Korotaev wrote:
> > Quick search maybe, but your patch adds 2 pointers to each dentry in the
> > system... That's pretty expensive, as dentries are already using a *lot*
> > of ram.
>
> I don't see much problems with it... it is cache and it can be pruned if
> needed. Some time ago, for example, my patch introducing the same list for
> inodes was commited.

The ratio of dentries/PAGE is higher than ration of inodes/PAGE.
(On a x86_64 machine, 19 dentries per PAGE, 5 ext3 inodes per PAGE=

Therefore I suspect that the number of pages locked in dentry_cache because of 
one inuse dentry is higher.

>
> > Maybe an alternative would be to not have anymore a global dentry_unused,
> > but only per-sb unused dentries lists ?
>
> I don't know global LRU implementation based on per-sb lists, do you?
> If someone suggest the algorithm for more or less fair global LRU
> based on non-global list we will implement it. However, so far,
> AFAICS there were problems with it.

Using 32 bytes per dentry for unused LRUs sounds too much, maybe we should 
revert LRUS handling to timestamps or things like that.

