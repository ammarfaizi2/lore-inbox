Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbTEMWPz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTEMWNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:13:48 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:29681 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263643AbTEMWNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:13:20 -0400
Date: Tue, 13 May 2003 15:21:41 -0700
From: Andrew Morton <akpm@digeo.com>
To: paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mjbligh@us.ibm.com
Subject: Re: [RFC][PATCH] Interface to invalidate regions of mmaps
Message-Id: <20030513152141.5ab69f07.akpm@digeo.com>
In-Reply-To: <20030513133636.C2929@us.ibm.com>
References: <20030513133636.C2929@us.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2003 22:26:02.0535 (UTC) FILETIME=[A2EB1B70:01C3199E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@us.ibm.com> wrote:
>
> This patch adds an API to allow networked and distributed filesystems
> to invalidate portions of (or all of) a file.  This is needed to 
> provide POSIX or near-POSIX semantics in such filesystems, as
> discussed on LKML late last year:
> 
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=103609089604576&w=2
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=103167761917669&w=2
> 
> Thoughts?

What filesystems would be needing this, and when could we see live code
which actually uses it?

> +/*
> + * Helper function for invalidate_mmap_range().
> + * Both hba and hlen are page numbers in PAGE_SIZE units.
> + */
> +static void 
> +invalidate_mmap_range_list(struct list_head *head,
> +			   unsigned long const hba,
> +			   unsigned long const hlen)

Be nice to consolidate this with vmtruncate_list, so that it gets
exercised.

