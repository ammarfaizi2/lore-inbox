Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbVKJUqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbVKJUqE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 15:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbVKJUqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 15:46:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:65417 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932098AbVKJUqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 15:46:02 -0500
Date: Thu, 10 Nov 2005 15:45:56 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org
Subject: Don't print per-cpu vm stats for offline cpus.
Message-ID: <20051110204556.GA22475@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just hit a page allocation error on a kernel configured to support
64 CPUs.  It spewed 60 completely useless unnecessary lines of info.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.14/mm/page_alloc.c~	2005-11-10 15:42:52.000000000 -0500
+++ linux-2.6.14/mm/page_alloc.c	2005-11-10 15:43:16.000000000 -0500
@@ -1330,7 +1330,7 @@ void show_free_areas(void)
 		} else
 			printk("\n");
 
-		for_each_cpu(cpu) {
+		for_each_online_cpu(cpu) {
 			struct per_cpu_pageset *pageset;
 
 			pageset = zone_pcp(zone, cpu);
