Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWENPaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWENPaJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 11:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWENPaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 11:30:09 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:35579 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751454AbWENPaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 11:30:08 -0400
Message-ID: <44674CFC.5050706@gmail.com>
Date: Sun, 14 May 2006 16:30:04 +0100
From: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc4 1/6] Base support for kmemleak
References: <20060513155757.8848.11980.stgit@localhost.localdomain>	 <20060513160541.8848.2113.stgit@localhost.localdomain> <84144f020605140753t67f10c3fmf754581aa74b39f5@mail.gmail.com>
In-Reply-To: <84144f020605140753t67f10c3fmf754581aa74b39f5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> On 5/13/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
>> This patch adds the base support for the kernel memory leak detector. It
>> traces the memory allocation/freeing in a way similar to the Boehm's
>> conservative garbage collector, the difference being that the orphan
>> pointers are not freed but only shown in /proc/memleak. Enabling this
>> feature would introduce an overhead to memory allocations.
> 
> Hmm. How much is the overhead anyway? I am guessing lots so can we
> reasonably expect anyone to run such kernel?

The overhead is probably high since an allocated pointer needs to be
inserted in a radix tree, together with its aliases. However, no-one
should enable this feature for a production kernel, but only for
debugging (as with Valgrind for user-space, there isn't anyone using
those libraries for production versions).

> Why isn't DEBUG_SLAB_LEAK
> enough for us?

I haven't looked at DEBUG_SLAB_LEAK in detail but it looks to me like it
only shows the calling address of whoever allocated the object. Kmemleak
detects whether the object is still refered (tracing garbage collection).

So, DEBUG_SLAB_LEAK should be enough if you suspect a memory leak. If
you don't, some leaks might go unnoticed.

Catalin
