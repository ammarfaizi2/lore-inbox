Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262760AbUJ0VcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbUJ0VcX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 17:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262900AbUJ0V27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:28:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:38046 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262728AbUJ0VZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:25:14 -0400
Date: Wed, 27 Oct 2004 14:29:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       bzolnier@gmail.com, rddunlap@osdl.org, wli@holomorphy.com,
       axboe@suse.de
Subject: Re: [PATCH] Re: news about IDE PIO HIGHMEM bug (was: Re: 2.6.9-mm1)
Message-Id: <20041027142914.197c72ed.akpm@osdl.org>
In-Reply-To: <417FCE4E.4080605@pobox.com>
References: <58cb370e041027074676750027@mail.gmail.com>
	<417FBB6D.90401@pobox.com>
	<1246230000.1098892359@[10.10.2.4]>
	<1246750000.1098892883@[10.10.2.4]>
	<417FCE4E.4080605@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> > However, pfn_to_page(page_to_pfn(page) + 1) might be safer. If rather slower.
> 
> 
> Is this patch acceptable to everyone?  Andrew?

spose so.  The scatterlist API is being a bit silly there.

It might be worthwhile doing:

#ifdef CONFIG_DISCONTIGMEM
#define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + n)
#else
#define nth_page(page,n) ((page)+(n))
#endif

