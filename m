Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbSKOIpA>; Fri, 15 Nov 2002 03:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265939AbSKOIpA>; Fri, 15 Nov 2002 03:45:00 -0500
Received: from holomorphy.com ([66.224.33.161]:57037 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262201AbSKOIo7>;
	Fri, 15 Nov 2002 03:44:59 -0500
Date: Fri, 15 Nov 2002 00:49:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>, pavel@suse.cz,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swsuspend and CONFIG_DISCONTIGMEM=y
Message-ID: <20021115084915.GS23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Arnaldo Carvalho de Melo <acme@conectiva.com.br>, pavel@suse.cz,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021115081044.GI18180@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115081044.GI18180@conectiva.com.br>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 06:10:44AM -0200, Arnaldo Carvalho de Melo wrote:
> So perhaps the following patch is in order? Its kind of brute force,
> disabling it altogether, but it at least fixes it for now.
> You can import this changeset into BK by piping this whole message to:
> '| bk receive [path to repository]' or apply the patch as usual.
> ===================================================================
> ChangeSet@1.851, 2002-11-15 06:07:56-02:00, acme@conectiva.com.br
>   o swsusp: depends on CONFIG_DISCONTIGMEM=n

The following dropped hunk from Pavel should repair it:


--- clean/kernel/suspend.c	2002-11-01 00:37:42.000000000 +0100
+++ linux-swsusp/kernel/suspend.c	2002-11-08 11:37:06.000000000 +0100
@@ -623,7 +623,7 @@
 static void free_some_memory(void)
 {
 	printk("Freeing memory: ");
-	while (try_to_free_pages(&contig_page_data.node_zones[ZONE_HIGHMEM], GFP_KSWAPD, 0))
+	while (shrink_all_memory(10000))
 		printk(".");
 	printk("|\n");
 }
