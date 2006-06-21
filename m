Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbWFUW2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWFUW2U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 18:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030332AbWFUW2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 18:28:19 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:35772 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030320AbWFUW2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 18:28:19 -0400
Date: Thu, 22 Jun 2006 00:27:59 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: Mattia Dongili <malattia@linux.it>, hpa@zytor.com, mbligh@mbligh.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] fix __range_ok constraint
In-Reply-To: <20060621134215.1bca6a5c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606220023230.17704@scrub.home>
References: <44998DCB.1030703@mbligh.org> <20060621184814.GQ24595@inferi.kami.home>
 <44999BC5.7060702@zytor.com> <20060621193932.GR24595@inferi.kami.home>
 <20060621134215.1bca6a5c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 21 Jun 2006, Andrew Morton wrote:

> what the heck?  Can you do `make fs/binfmt_aout.s' then send the relevant
> parts of that file?

I've hit this too, I haven't booted with the patch yet, but it should be 
simple enough to be safe.

bye, Roman





An immediate operand can't be the destination of the cmpl instruction,
so exclude it.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---
 include/asm-i386/uaccess.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-mm/include/asm-i386/uaccess.h
===================================================================
--- linux-2.6-mm.orig/include/asm-i386/uaccess.h	2006-06-21 16:23:56.000000000 +0200
+++ linux-2.6-mm/include/asm-i386/uaccess.h	2006-06-21 16:46:55.000000000 +0200
@@ -58,7 +58,7 @@ extern struct movsl_mask {
 	__chk_user_ptr(addr); \
 	asm("addl %3,%1 ; sbbl %0,%0; cmpl %1,%4; sbbl $0,%0" \
 		:"=&r" (flag), "=r" (sum) \
-		:"1" (addr),"g" ((int)(size)),"g" (current_thread_info()->addr_limit.seg)); \
+		:"1" (addr),"g" ((int)(size)),"rm" (current_thread_info()->addr_limit.seg)); \
 	flag; })
 
 /**
