Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbVK3COj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVK3COj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 21:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbVK3COj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 21:14:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47774 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750785AbVK3COi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 21:14:38 -0500
Date: Tue, 29 Nov 2005 18:14:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: dada1@cosmosbay.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shrinks dentry struct
Message-Id: <20051129181421.0e273d83.akpm@osdl.org>
In-Reply-To: <20051129180653.f8d40e9a.pj@sgi.com>
References: <121a28810511282317j47a90f6t@mail.gmail.com>
	<20051129000916.6306da8b.akpm@osdl.org>
	<438C7218.8030109@cosmosbay.com>
	<20051129180653.f8d40e9a.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
>  Would the following accomplish the same thing as your patch, to shrink
>  UP dentry structs back to 128 bytes, with a smaller and less intrusive
>  patch?
> 
> ...
>  -	struct list_head d_child;	/* child of parent list */
>  +	union {				/* Fit 32 bit UP dentry in 128 bytes */
>  +		struct list_head du_child;	/* child of parent list */
>  + 		struct rcu_head du_rcu;
>  +	} d_du;
> ...
>   
>  +#define d_child d_du.du_child
>  +#define d_rcu d_du.du_rcu

Yes, but it's better to just do the big edit, rather than letting these
little namespace crufties accumulate over time.

Even better would be to ditch gcc-2.95.x and use an anonymous union, but
Hugh won't let me ;)
