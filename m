Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263003AbSIUV2l>; Sat, 21 Sep 2002 17:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263060AbSIUV2l>; Sat, 21 Sep 2002 17:28:41 -0400
Received: from franka.aracnet.com ([216.99.193.44]:33177 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263003AbSIUV2k>; Sat, 21 Sep 2002 17:28:40 -0400
Date: Sat, 21 Sep 2002 14:32:15 -0700
From: "Martin J. Bligh" <fletch@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       "David S. Miller" <davem@redhat.com>
cc: Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: free_area_init_node fix (for non discontigmem direct use)
Message-ID: <7425387.1032618735@[10.10.2.3]>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some idiot (OK, it was me) broke free_area_init_node for
non discontigmem systems that call it directly (eg sparc64),
during a recent cleanup, thus invoking the wrath of DaveM.

I know Dave sent you a patch yesterday, but I think the BUG
statement in it will break anyone who just uses free_area_init
(eg any PC). So here's a portion of Dave's patch that should
fix things for everyone I think. Unfortunately my non-NUMA
test box is borked right now, but it just removes the BUG
statement from what he tested, and it's so simple that even
I couldn't screw this up (famous last words).

This code really needs some more cleanup work, but this will 
fix it for now so everyone can do their work ...

Please apply,

Martin.

diff -urN -X /home/mbligh/.diff.exclude virgin/mm/numa.c fain/mm/numa.c
--- virgin/mm/numa.c	Fri Sep 20 08:20:34 2002
+++ fain/mm/numa.c	Sat Sep 21 13:20:50 2002
@@ -27,6 +27,7 @@
 {
 	unsigned long size;
 
+	pgdat = &contig_page_data;
 	contig_page_data.node_id = 0;
 	contig_page_data.node_start_pfn = node_start_pfn;
 	calculate_totalpages (&contig_page_data, zones_size, zholes_size);

