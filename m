Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263827AbTDNTye (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263828AbTDNTye (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:54:34 -0400
Received: from ns.suse.de ([213.95.15.193]:46598 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263827AbTDNTyd (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 15:54:33 -0400
Subject: Re: [PATCH] blockgroup_lock: hashed spinlocks for ext2 and ext3
From: Andi Kleen <ak@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: akpm@digeo.com
In-Reply-To: <200304131113.h3DBDvj2004773@hera.kernel.org>
References: <200304131113.h3DBDvj2004773@hera.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 14 Apr 2003 22:06:21 +0200
Message-Id: <1050350782.7912.400.camel@averell>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-04-13 at 12:00, Linux Kernel Mailing List wrote:

[....]
> 	
> 	These locks are actually fairly generic.  However I presented it as something
> 	which is specific to ext2 and ext3 so that people wouldn't go using them all
> 	over the place.  They consume a lot of storage.
> 

> +
> +struct bgl_lock {
> +	spinlock_t lock;
> +} ____cacheline_aligned_in_smp;
> +
> +struct blockgroup_lock {
> +	struct bgl_lock locks[NR_BG_LOCKS];
> +};

Why don't you use per_cpu data for this ? It can be indexed as well
with per_cpu() and it would safe a lot of space because the padding
would not be all wasted. If you want more than NR_CPUS locks it could be
done using a simple two level index scheme.

-Andi



