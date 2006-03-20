Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965083AbWCTQO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbWCTQO2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbWCTQO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:14:27 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:4795 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964990AbWCTQOZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:14:25 -0500
Subject: Re: [PATCH] slab: introduce kmem_cache_zalloc allocator
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: balbir@in.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060320160500.GA25415@in.ibm.com>
References: <Pine.LNX.4.58.0603201506140.19005@sbz-30.cs.Helsinki.FI>
	 <20060320160500.GA25415@in.ibm.com>
Date: Mon, 20 Mar 2006 18:14:23 +0200
Message-Id: <1142871263.11694.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-20 at 21:35 +0530, Balbir Singh wrote:
> Could we please create a more generic variation of this patch -- may be a
> function called kmem_cache_alloc_set(). The function would not only
> memset the data to 0, but instead to any specified pattern passed as
> an argument.

No, no, no! I am introducing kmem_cache_zalloc() because there are
existing users in the tree. I plan to kill the slab wrappers from XFS
completely which is why I need this. We already have object constructors
for what you're describing.

On Mon, 2006-03-20 at 21:35 +0530, Balbir Singh wrote:
> This could be used to poison allocated memory. Passing 0 would make
> this equivalent to kmem_cache_zalloc(). Basically, instead of doing

I am not sure I understand what you mean. We already have slab poisoning
and that's in mm/slab.c. Why would you want to make the callers aware of
that?

				Pekka

