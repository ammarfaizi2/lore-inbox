Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263207AbUDEVAV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbUDEVAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:00:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:44225 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263210AbUDEVAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:00:13 -0400
Date: Mon, 5 Apr 2004 14:02:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shrink core hashes on small systems
Message-Id: <20040405140223.2f775da4.akpm@osdl.org>
In-Reply-To: <20040405204957.GF6248@waste.org>
References: <20040405204957.GF6248@waste.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> Shrink hashes on small systems
> 
> Tweak vfs_caches_init logic so that hashes don't start growing as
> quickly on small systems.
> 
> -	vfs_caches_init(num_physpages);
> +	/* Treat machines smaller than 6M as having 2M of memory
> +	   for hash-sizing purposes */
> +	vfs_caches_init(max(500, (int)num_physpages-1000));

This seems rather arbitrary.  It also implicitly "knows" that
PAGE_SIZE=4096.

num_physpages is of course the wrong thing to use here - on small systems
we should be accounting for memory which is pinned by kernel text, etc.

But you're going further than that.  What's the theory here?
