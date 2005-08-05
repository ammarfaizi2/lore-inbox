Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262860AbVHEFkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbVHEFkZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 01:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbVHEFkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 01:40:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20894 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262860AbVHEFkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 01:40:23 -0400
Date: Thu, 4 Aug 2005 22:38:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: use kcalloc instead kmalloc/memset
Message-Id: <20050804223842.2b3abeee.akpm@osdl.org>
In-Reply-To: <1123219747.20398.1.camel@localhost>
References: <1123219747.20398.1.camel@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> wrote:
>
> This patch converts kernel/ to use kcalloc instead of kmalloc/memset.
>

grr.
 
>  -	struct resource *res = kmalloc(sizeof(*res), GFP_KERNEL);
>  +	struct resource *res = kcalloc(1, sizeof(*res), GFP_KERNEL);

Notice how every conversion you did passes in `1' in the first argument?

And that's going to happen again and again and again.  Each callsite
needlessly passing that silly third argument, adding more kernel text.

If we're going to do this, we should add a two-arg helper function first,
and use that, no?
