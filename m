Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263032AbUFWWPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbUFWWPM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 18:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbUFWWNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 18:13:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:26062 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262882AbUFWWMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 18:12:45 -0400
Date: Wed, 23 Jun 2004 15:15:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [oom]: [3/4] track wired pages on a per-zone basis
Message-Id: <20040623151536.023404fc.akpm@osdl.org>
In-Reply-To: <0406231407.1a2a3aHb2aIbHbLbHb5a0a5a0aWaJbJbLbIbXaJbLbIbWaKbXa0a4aMbJbHb4aXa342@holomorphy.com>
References: <0406231407.Wa3a0aIbWaLbXaJbIb1a1aLbKb2aKb2a3aYaJbYa3a1a4aJbKbWa4a0a4a4aWaHb342@holomorphy.com>
	<0406231407.1a2a3aHb2aIbHbLbHb5a0a5a0aWaJbJbLbIbXaJbLbIbWaKbXa0a4aMbJbHb4aXa342@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> Index: linux-2.6.7/include/linux/mmzone.h
> ===================================================================
> --- linux-2.6.7.orig/include/linux/mmzone.h	2004-06-16 05:19:36.000000000 +0000
> +++ linux-2.6.7/include/linux/mmzone.h	2004-06-23 18:58:13.000000000 +0000
> @@ -170,6 +170,7 @@
>  	ZONE_PADDING(_pad3_)
>  
>  	struct per_cpu_pageset	pageset[NR_CPUS];
> +	unsigned long		nr_wired[NR_CPUS];

These will share cachelines of course, so the percpuification won't be very
effective.  I wonder if there's some way in which the nr_wired accounting
can be batched up and then dumped into a single per-zone counter when we
have the zone->lru_lock.

How come there are all those PageWired() tests in the LRU manipulation
functions?


