Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbVHEGiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbVHEGiU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 02:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbVHEGiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 02:38:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29352 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262873AbVHEGiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 02:38:19 -0400
Date: Thu, 4 Aug 2005 23:36:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: linux-kernel@vger.kernel.org, pmarques@grupopie.com
Subject: Re: [PATCH] kernel: use kcalloc instead kmalloc/memset
Message-Id: <20050804233634.1406e92a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508050925370.27151@sbz-30.cs.Helsinki.FI>
References: <1123219747.20398.1.camel@localhost>
	<20050804223842.2b3abeee.akpm@osdl.org>
	<Pine.LNX.4.58.0508050925370.27151@sbz-30.cs.Helsinki.FI>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
>
> [PATCH] use kzalloc instead of kmalloc/memset
> 

dammit, I was hoping for akpmalloc()

>  
> +static inline void *kzalloc(size_t size, unsigned int __nocast flags)
> +{
> +	return kcalloc(1, size, flags);
> +}
> +

That'll generate just as much code as simply using kcalloc(1, ...).  This
function should be out-of-line and EXPORT_SYMBOL()ed.  And kcalloc() can
call it too..

