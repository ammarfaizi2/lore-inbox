Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265095AbSKRXJy>; Mon, 18 Nov 2002 18:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265108AbSKRXJy>; Mon, 18 Nov 2002 18:09:54 -0500
Received: from holomorphy.com ([66.224.33.161]:62945 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265095AbSKRXJw>;
	Mon, 18 Nov 2002 18:09:52 -0500
Date: Mon, 18 Nov 2002 15:13:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@zip.com.au
Subject: Re: 2.5.47 bootmem crash
Message-ID: <20021118231353.GS11776@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@zip.com.au
References: <Pine.GSO.4.21.0211182324570.16079-100000@vervain.sonytel.be> <Pine.LNX.4.44.0211182345421.2113-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211182345421.2113-100000@serv>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 11:47:15PM +0100, Roman Zippel wrote:
Index: mm/page_alloc.c
===================================================================
RCS file: /home/linux-m68k/cvsroot/linux/mm/page_alloc.c,v
retrieving revision 1.1.1.36
diff -u -p -r1.1.1.36 page_alloc.c
--- mm/page_alloc.c	11 Nov 2002 19:12:51 -0000	1.1.1.36
+++ mm/page_alloc.c	18 Nov 2002 22:45:34 -0000
@@ -1181,7 +1181,7 @@ struct pglist_data contig_page_data = { 
 
 void __init free_area_init(unsigned long *zones_size)
 {
-	free_area_init_node(0, &contig_page_data, NULL, zones_size, 0, NULL);
+	free_area_init_node(0, &contig_page_data, NULL, zones_size, __pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
 	mem_map = contig_page_data.node_mem_map;
 }
 #endif
---------- Roman Zippel's patch ends here ------------

This is a valid core fix for "memory doesn't start at zero", and will work
properly on all "memory starts at zero" machines without any overhead.


Thanks,
Bill
