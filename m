Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbVK3OmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbVK3OmT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 09:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVK3OmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 09:42:18 -0500
Received: from adsl-80.mirage.euroweb.hu ([193.226.228.80]:4882 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751250AbVK3OmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 09:42:18 -0500
To: dhowells@redhat.com
CC: torvalds@osdl.org, akpm@osdl.org, hugh@veritas.com, aia21@cam.ac.uk,
       hch@infradead.org, linux-kernel@vger.kernel.org
In-reply-to: <5425.1133359116@warthog.cambridge.redhat.com> (message from
	David Howells on Wed, 30 Nov 2005 13:58:36 +0000)
Subject: Re: [PATCH] Add notification of page becoming writable to VMA ops [try #3]
References: <15253.1130246296@warthog.cambridge.redhat.com>  <Pine.LNX.4.61.0510241938100.6142@goblin.wat.veritas.com> <1130168619.19518.43.camel@imp.csi.cam.ac.uk> <1130167005.19518.35.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.61.0502091357001.6086@goblin.wat.veritas.com> <7872.1130167591@warthog.cambridge.redhat.com> <9792.1130171024@warthog.cambridge.redhat.com> <5425.1133359116@warthog.cambridge.redhat.com>
Message-Id: <E1EhT8Y-0003CF-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 30 Nov 2005 15:40:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The attached patch adds a new VMA operation to notify a filesystem or other
> driver about the MMU generating a fault because userspace attempted to write
> to a page mapped through a read-only PTE.
> 
> This facility permits the filesystem or driver to:
> 
>  (*) Implement storage allocation/reservation on attempted write, and so to
>      deal with problems such as ENOSPC more gracefully (perhaps by generating
>      SIGBUS).
> 
>  (*) Delay making the page writable until the contents have been written to a
>      backing cache. This is useful for NFS/AFS when using FS-Cache/CacheFS.
>      It permits the filesystem to have some guarantee about the state of the
>      cache.

  (*) account and limit number of dirty pages

This is one piece of the puzze needed to make shared writable mapping
work safely in FUSE.

> Updated to 2.6.14-git14.

But doesn't apply against 2.6.15-rc3 or -rc3-mm1.

Miklos
