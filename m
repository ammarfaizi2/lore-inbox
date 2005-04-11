Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVDKQuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVDKQuz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVDKQs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:48:29 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:28393 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261850AbVDKQpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:45:03 -0400
Date: Mon, 11 Apr 2005 18:44:33 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [2.6 ppc patch] fix compilation error in include/asm/prom.h
Message-ID: <20050411164433.GC12136@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.8i
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make defconfig give the following error on ppc (gcc-4):

arch/ppc/syslib/prom_init.c:120: error: static declaration of ‘prom_display_paths’ follows non-static declaration
include/asm/prom.h:17: error: previous declaration of ‘prom_display_paths’ was here
arch/ppc/syslib/prom_init.c:122: error: static declaration of ‘prom_num_displays’ follows non-static declaration
include/asm/prom.h:18: error: previous declaration of ‘prom_num_displays’ was here

The following patch solves it.

Signed-Off-By: Benoit Boissinot <benoit.boissinot@ens-lyon.org>


--- ./include/asm-ppc/prom.h.orig	2005-04-11 14:49:31.000000000 +0200
+++ ./include/asm-ppc/prom.h	2005-04-11 14:49:46.000000000 +0200
@@ -14,9 +14,6 @@
 typedef u32 phandle;
 typedef u32 ihandle;
 
-extern char *prom_display_paths[];
-extern unsigned int prom_num_displays;
-
 struct address_range {
 	unsigned int space;
 	unsigned int address;
