Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264894AbUFVQje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264894AbUFVQje (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 12:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264963AbUFVP1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:27:38 -0400
Received: from holomorphy.com ([207.189.100.168]:43395 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264885AbUFVPR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:17:56 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [profile]: [20/23] clean up profile_init() not to oversize buffer
Message-ID: <0406220817.4aXa3aHb5aMb4a3a1aYaZa3aIbXa5aIbKbJbXa1aLbJb4a2a2aZaYa0aHb2aMbYa15250@holomorphy.com>
In-Reply-To: <0406220817.WaZaYaLb4aMb4a1aZa0a5a1a0aYaZa5aLbIb0a2a3aJb3aMbYaLb4aHb0aIbHbYa15250@holomorphy.com>
CC: rddunlap@osdl.org
Date: Tue, 22 Jun 2004 08:17:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't overestimate the length of prof_buffer in profile_init().

Index: prof-2.6.7/kernel/profile.c
===================================================================
--- prof-2.6.7.orig/kernel/profile.c	2004-06-22 07:25:59.267153192 -0700
+++ prof-2.6.7/kernel/profile.c	2004-06-22 07:26:00.201011224 -0700
@@ -28,17 +28,12 @@
 
 void __init profile_init(void)
 {
-	unsigned int size;
- 
 	if (!prof_on) 
 		return;
  
 	/* only text is profiled */
-	prof_len = _etext - _stext;
-	prof_len >>= prof_shift;
-		
-	size = prof_len * sizeof(unsigned int) + PAGE_SIZE - 1;
-	prof_buffer = (unsigned int *) alloc_bootmem(size);
+	prof_len = (_etext - _stext) >> prof_shift;
+	prof_buffer = alloc_bootmem(sizeof(unsigned int)*prof_len);
 }
 
 int profiling_on(void)
