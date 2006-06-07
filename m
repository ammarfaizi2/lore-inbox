Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWFGRmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWFGRmF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 13:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWFGRmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 13:42:04 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:51350 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932090AbWFGRmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 13:42:02 -0400
Date: Wed, 7 Jun 2006 10:41:55 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Xin Zhao <uszhaoxin@gmail.com>
cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: Linux SLAB allocator issue
In-Reply-To: <4ae3c140606070837t23182496s42edb3a754169d43@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0606071030040.831@schroedinger.engr.sgi.com>
References: <4ae3c140606061358j140eec9fl45e22f8a9e673215@mail.gmail.com> 
 <84144f020606070516m4bccdecdr998941ee74744a83@mail.gmail.com>
 <4ae3c140606070837t23182496s42edb3a754169d43@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2006, Xin Zhao wrote:

> Then, I used kmem_cache_alloc() to allocate 128 objects. So it should
> occupy 12 full slabs and 1 partial slab. Right?

There may be additional objects in the various caches. If this is a UP 
system then some will certainly be in the per cpu cache.

You can push these back into the free lists by draining the array cache.

If you allocate objects on a slab that is fresh (no objects in it) then 
only full slabs will be used. The remaining objects will end up on the per 
cpu lists where they can be consumed without more work on the full/partial 
arrays.

