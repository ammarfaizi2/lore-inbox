Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVAWIlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVAWIlO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 03:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVAWIlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 03:41:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:59016 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261259AbVAWIlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 03:41:10 -0500
Date: Sun, 23 Jan 2005 00:40:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] core-small: Introduce CONFIG_CORE_SMALL from -tiny
Message-Id: <20050123004042.09f7f8eb.akpm@osdl.org>
In-Reply-To: <1.464233479@selenic.com>
References: <1.464233479@selenic.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> This set of patches introduces a new config option CONFIG_CORE_SMALL
> from the -tiny tree for small systems. This series should apply
> cleanly against 2.6.11-rc1-mm2.
> 
> When selected, it enables various tweaks to miscellaneous core data
> structures to shrink their size on small systems. While each tweak is
> fairly small, in aggregate they can save a substantial amount of
> memory.

You know what I'm going to ask ;)  How much memory?

I wish it didn't have "core" in the name.  A little misleading.

Did you think of making CONFIG_CORE_SMALL an integer which has values zero
or one?

Then you can lose all those ifdefs:

#define MAX_PROBE_HASH (255 - CONFIG_CORE_SMALL * 254)	/* dorky */

#define PID_MAX_DEFAULT (CONFIG_CORE_SMALL ? 0x1000 : 0x8000)
#define UIDHASH_BITS (CONFIG_CORE_SMALL ? 3 : 8)
#define FUTEX_HASHBITS (CONFIG_CORE_SMALL ? 4 : 8)
etc.

I think the ?: thing will work everywhere:

	#define XX 1
	char xx[XX ? 10 : 20];

even this works...
