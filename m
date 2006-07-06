Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030321AbWGFRb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbWGFRb7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 13:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030320AbWGFRb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 13:31:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35252 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030321AbWGFRb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 13:31:58 -0400
Date: Thu, 6 Jul 2006 10:31:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, bernds_cb1@t-online.de, sam@ravnborg.org,
       dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] FRV: Fix FRV arch compile errors [try #3]
Message-Id: <20060706103134.197c8679.akpm@osdl.org>
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

> --- a/include/linux/bootmem.h
> +++ b/include/linux/bootmem.h
> @@ -91,7 +91,7 @@ static inline void *alloc_remap(int nid,
>  }
>  #endif
>  
> -extern unsigned long nr_kernel_pages;
> +extern unsigned long __initdata nr_kernel_pages;

- The __init-style tags on declarations don't actually do anything and
  the compiler doesn't check for consistency with the definition - it's
  best to just omit it from the declaration.

- Setting nr_kernel_pages to be unloaded at free_initmem() seems risky.

- nr_kernel_pages is actually __meminitdata.

So I'll drop this hunk.
