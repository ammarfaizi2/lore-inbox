Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030727AbWKUIJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030727AbWKUIJX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 03:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030737AbWKUIJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 03:09:23 -0500
Received: from smtp.osdl.org ([65.172.181.25]:947 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030727AbWKUIJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 03:09:22 -0500
Date: Tue, 21 Nov 2006 00:09:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Manfred Spraul <manfred@colorfullife.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [RFC 4/7] Move files_cachep to file.h
Message-Id: <20061121000902.52849f2f.akpm@osdl.org>
In-Reply-To: <20061118054403.8884.32124.sendpatchset@schroedinger.engr.sgi.com>
References: <20061118054342.8884.12804.sendpatchset@schroedinger.engr.sgi.com>
	<20061118054403.8884.32124.sendpatchset@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006 21:44:03 -0800 (PST)
Christoph Lameter <clameter@sgi.com> wrote:

> Move files_cachep to file.h
> 
> The proper place is in file.h since its related to file I/O.
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Index: linux-2.6.19-rc5-mm2/include/linux/file.h
> ===================================================================
> --- linux-2.6.19-rc5-mm2.orig/include/linux/file.h	2006-11-15 16:48:08.583913536 -0600
> +++ linux-2.6.19-rc5-mm2/include/linux/file.h	2006-11-17 23:03:59.254839099 -0600
> @@ -101,4 +101,6 @@ struct files_struct *get_files_struct(st
>  void FASTCALL(put_files_struct(struct files_struct *fs));
>  void reset_files_struct(struct task_struct *, struct files_struct *);
>  
> +extern kmem_cache_t	*files_cachep;
> +
>  #endif /* __LINUX_FILE_H */
> Index: linux-2.6.19-rc5-mm2/include/linux/slab.h
> ===================================================================
> --- linux-2.6.19-rc5-mm2.orig/include/linux/slab.h	2006-11-17 23:03:55.587532089 -0600
> +++ linux-2.6.19-rc5-mm2/include/linux/slab.h	2006-11-17 23:03:59.268512148 -0600
> @@ -298,7 +298,6 @@ static inline void kmem_set_shrinker(kme
>  
>  /* System wide caches */
>  extern kmem_cache_t	*names_cachep;
> -extern kmem_cache_t	*files_cachep;
>  extern kmem_cache_t	*filp_cachep;
>  extern kmem_cache_t	*fs_cachep;
>  

Please convert to `struct kmem_cache' (all patches).
