Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVDKQrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVDKQrC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVDKQnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:43:32 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:26857 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261843AbVDKQnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:43:02 -0400
Date: Mon, 11 Apr 2005 18:42:31 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [2.6 ppc patch] fix compilation error in arch/ppc/kernel/time.c
Message-ID: <20050411164231.GB12136@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.8i
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make defconfig give the following error on ppc (gcc-4):

arch/ppc/kernel/time.c:92: error: static declaration of ‘time_offset’
follows non-static declaration
include/linux/timex.h:236: error: previous declaration of ‘time_offset’
was here

The following patch solves it (time_offset is declared in timer.c).

Signed-Off-By: Benoit Boissinot <benoit.boissinot@ens-lyon.org>


--- ./arch/ppc/kernel/time.c.orig	2005-04-11 14:44:19.000000000 +0200
+++ ./arch/ppc/kernel/time.c	2005-04-11 14:44:30.000000000 +0200
@@ -89,8 +89,6 @@ unsigned long tb_to_ns_scale;
 
 extern unsigned long wall_jiffies;
 
-static long time_offset;
-
 DEFINE_SPINLOCK(rtc_lock);
 
 EXPORT_SYMBOL(rtc_lock);
