Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270766AbTHDL4S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 07:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271707AbTHDL4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 07:56:18 -0400
Received: from mail-8.tiscali.it ([195.130.225.154]:60349 "EHLO
	mail-8.tiscali.it") by vger.kernel.org with ESMTP id S270766AbTHDL4P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 07:56:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniele Bellucci <bellucda@tiscali.it>
Reply-To: bellucda@tiscali.it
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test2-mm4
Date: Mon, 4 Aug 2003 13:56:03 +0200
User-Agent: KMail/1.4.3
References: <20030804013036.16d9fa3a.akpm@osdl.org>
In-Reply-To: <20030804013036.16d9fa3a.akpm@osdl.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200308041356.03739.bellucda@tiscali.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


make all:

mm/usercopy.c: In function `pin_page':
mm/usercopy.c:55: warning: implicit declaration of function `in_atomic'
mm/built-in.o: In function `rw_vm':
/usr/src/linux-2.6.0-test2-mm4/mm/usercopy.c:55: undefined reference to `in_atomic'
make: *** [.tmp_vmlinux1] Error 1

seems like #include <linux/interrupt.h> is missing.


diff -urN 1.0/mm/usercopy.c 1.1/mm/usercopy.c
--- 1.0/mm/usercopy.c	2003-08-04 13:46:22.000000000 +0200
+++ 1.1/mm/usercopy.c	2003-08-04 13:46:39.000000000 +0200
@@ -15,6 +15,7 @@
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
 #include <linux/ptrace.h>
+#include <linux/interrupt.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>


