Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965269AbVLRUlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965269AbVLRUlk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 15:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbVLRUlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 15:41:40 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:6708 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932185AbVLRUlj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 15:41:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nisKRO3fPmj3AHmkYhLY4+KtwoWam1rKvBllGqAEQBUz9A7RwMGJlydcoHMZb1B7y2n6n22hpQnWD5hqs3dA4PvcpRAtP+MHr0tSm/UJSkNtjtRbIIH2IwMlDs/mBHde9uq+Z9cuvQYQBgZ3JMRVGUIyHhWQhhj9iljiFHif2d8=
Message-ID: <84144f020512181241q72f289f5x5076824aa7f73286@mail.gmail.com>
Date: Sun, 18 Dec 2005 22:41:37 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: 2.6.16-rc5-mm2 - kzalloc() considered harmful for debugging.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200512181258.jBICwMdj003410@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512181258.jBICwMdj003410@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valdis,

On 12/18/05, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> Blargh.  It's tempting to do something like this in include/linux/slab.h:
>
> #ifdef CONFIG_SLAB_DEBUG
> static inline void* kzalloc(size_t size, gfp_t flags)
> {
>         void *ret = kmalloc(size, flags);
>         if (ret)
>                 memset(ret, 0, size);
>         return ret;
> }
> #else
> extern void *kzalloc(size_t, gfp_t);
> #end

I don't see CONFIG_SLAB_DEBUG in 2.6.15-rc5-mm2. Is it an external patch?

> or maybe some ad-crock macro implementation, just so the actual calling site of
> kmalloc is recorded, rather than losing the caller of kzalloc.

I would prefer this. Both kzalloc and kstrdup should override the call
site of kmalloc. Preferably, all of them should use something like
__kmalloc_tracked() and pass the call site as an parameter.

                          Pekka
