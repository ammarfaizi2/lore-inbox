Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbUD3Vjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbUD3Vjd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 17:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbUD3Vjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 17:39:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:42169 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261430AbUD3VjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 17:39:15 -0400
Date: Fri, 30 Apr 2004 14:41:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Art Haas" <ahaas@airmail.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with recent changes to fs/dcache.c
Message-Id: <20040430144119.3e13a342.akpm@osdl.org>
In-Reply-To: <20040430204157.GD23466@artsapartment.org>
References: <20040430020525.GI27793@artsapartment.org>
	<20040429203901.4cd21fdc.akpm@osdl.org>
	<20040430204157.GD23466@artsapartment.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Art Haas" <ahaas@airmail.net> wrote:
>
> I'm still trying to debug this, so I've cloned a 2.6.5 tree and added
> some printk() bits to see what it reported. Here's the top of the
> 'dmesg' output. Notice the 'num_phspages' is 45829, so the value I was
> getting in the 2.6.6-rc3 bootup of 46073 is very similar, which suggests
> that the problem _might_ be with the nr_free_pages() call - which leads
> down in the the mmzone code. Here's the dmesg output:
> 
> .......
> Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz).
> Patching kerne l for srmmu[TI Viking/MXCC]/iommu
> 319MB HIGHMEM available.
> On node 0 totalpages: 130409
>   DMA zone: 48666 pages, LIFO batch:11
>   Normal zone: 0 pages, LIFO batch:1
>   HighMem zone: 81743 pages, LIFO batch:16

130409 pages.

> Power off control detected.
> Built 1 zonelists
> Kernel command line: root=/dev/sda1
> PID hash table entries: 2048 (order 11: 16384 bytes)
> Console: colour dummy device 80x25
> calling mem_init()
> Memory: 509676k available (1352k kernel code, 312k data, 116k init,
>    326972k high mem) [f0000000,1ff4f000]
> num_physpages: 45829

That's wrong.

I do think that num_physpages is ripe for removal - we have a number of
ways of calculating much the same thing in generic code, and probably all
users could be changed to use something else anyway.

But short-term we're stuck with it, and there's a bug somewhere in
arch/sparc/'s calculation of this number.

