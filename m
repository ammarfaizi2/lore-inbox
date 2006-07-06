Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030353AbWGFRgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbWGFRgn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 13:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbWGFRgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 13:36:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30390 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030353AbWGFRgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 13:36:42 -0400
Date: Thu, 6 Jul 2006 10:36:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, bernds_cb1@t-online.de, sam@ravnborg.org,
       dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] FRV: Fix FRV arch compile errors [try #3]
Message-Id: <20060706103622.ebf00e68.akpm@osdl.org>
In-Reply-To: <20060706124721.7098.50514.stgit@warthog.cambridge.redhat.com>
References: <20060706124716.7098.5752.stgit@warthog.cambridge.redhat.com>
	<20060706124721.7098.50514.stgit@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2006 13:47:21 +0100
David Howells <dhowells@redhat.com> wrote:

> From: David Howells <dhowells@redhat.com>
> 
> The attached patch fixes some FRV arch compile errors, including:
> 
>  (*) Marking nr_kernel_pages as __initdata so that references to it end up
>      being properly calculated rather than being assumed to be in the small
>      data section (and thus calculated wrt the GP register).  Not doing this
>      causes the linker to emit errors as the offset is too big to fit into the
>      load instruction.

ocrap, I didn't read this bit.  Really?  We skip the section tag on the
declaration all over the place and keeping them in sync is going to be
quite unreliable due to lack of compiler checking.

> --- a/include/linux/bootmem.h
> +++ b/include/linux/bootmem.h
> @@ -91,7 +91,7 @@ static inline void *alloc_remap(int nid,
>  }
>  #endif
>  
> -extern unsigned long nr_kernel_pages;
> +extern unsigned long __initdata nr_kernel_pages;
>  extern unsigned long nr_all_pages;
>  
>  extern void *__init alloc_large_system_hash(const char *tablename,

So this wants to be __meminitdata.  Problem.  How does it manifest on FRV? 
A linker error or a mysterious crash?
