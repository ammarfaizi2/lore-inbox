Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbWHNXIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbWHNXIf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 19:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbWHNXIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 19:08:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18582 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965044AbWHNXId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 19:08:33 -0400
Date: Mon, 14 Aug 2006 16:08:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] check return value of kmalloc() in setup_cpu_cache()
Message-Id: <20060814160824.c1a5ef53.akpm@osdl.org>
In-Reply-To: <20060813101654.GB8703@miraclelinux.com>
References: <20060813101654.GB8703@miraclelinux.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2006 18:16:54 +0800
Akinobu Mita <mita@miraclelinux.com> wrote:

> This patch makes crash happen when allocation of cpucache data fails
> in setup_cpu_cache(). It is a bit better than getting kernel NULL
> pointer dereference later.

This code is called on the kmem_cache_create() path.  We should back out
and return -ENOMEM from kmem_cache_create().

