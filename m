Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbTBSROj>; Wed, 19 Feb 2003 12:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbTBSROj>; Wed, 19 Feb 2003 12:14:39 -0500
Received: from air-2.osdl.org ([65.172.181.6]:59329 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261398AbTBSROh>;
	Wed, 19 Feb 2003 12:14:37 -0500
Date: Wed, 19 Feb 2003 09:20:46 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Ion Badulescu <ionut@badula.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add new DMA_ADDR_T_SIZE define
Message-Id: <20030219092046.458c2876.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0302191050290.29393-100000@guppy.limebrokerage.com>
References: <Pine.LNX.4.44.0302191050290.29393-100000@guppy.limebrokerage.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2003 11:26:27 -0500 (EST)
Ion Badulescu <ionut@badula.org> wrote:

| This patch adds a new preprocessor define called DMA_ADDR_T_SIZE for all 
| architectures, for the benefit of those drivers who care about its size 
| (and yes, starfire is one of them).
| 
| Alternatives are:
| 
| 1. a really ugly #ifdef in every single driver, which is error-prone and 
| likely to break (see drivers/net/starfire.c around line 274 and have a 
| barf bag ready).
| 
| 2. always cast it to u64, which adds unnecessary overhead to 32-bit 
| platforms.
| 
| 3. use run-time checks all over the place, of the 
| "sizeof(dma_addr_t)==sizeof(u64)" kind, which adds unnecessary overhead to 
| all platforms.
| 
| 4. use the results from pci_set_dma_mask(), which still amounts to 
| unnecessary run-time overhead on platforms which have a 32-bit dma_addr_t 
| to begin with.
| 
| So I think a define in each architecture's types.h file is the cleanest 
| way to approach this, and that's what my patch does.
| 
| Comments and/or suggestions are appreciated.
| -- 

Does this help with being able to printk() a <dma_addr_t>?  How?
Always use a cast to (u64) or something else?

--
~Randy
