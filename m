Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751739AbWJZDfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbWJZDfS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 23:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbWJZDfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 23:35:18 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:58051 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1751748AbWJZDfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 23:35:17 -0400
Date: Thu, 26 Oct 2006 13:26:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org, ak@suse.de,
       linux-mm@kvack.org
Subject: [PATCH 1/3] Constify compat_get_bitmap argument
Message-Id: <20061026132659.2ff90dd1.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 2.3.0beta3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This means we can call it when the bitmap we want to fetch is declared
const.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/compat.h |    2 +-
 kernel/compat.c        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

This is headed towards getting sys_migrate_pages wired up for powerpc.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/linux/compat.h b/include/linux/compat.h
index f4ebf96..f155319 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -196,7 +196,7 @@ #define BITS_PER_COMPAT_LONG    (8*sizeo
 #define BITS_TO_COMPAT_LONGS(bits) \
 	(((bits)+BITS_PER_COMPAT_LONG-1)/BITS_PER_COMPAT_LONG)
 
-long compat_get_bitmap(unsigned long *mask, compat_ulong_t __user *umask,
+long compat_get_bitmap(unsigned long *mask, const compat_ulong_t __user *umask,
 		       unsigned long bitmap_size);
 long compat_put_bitmap(compat_ulong_t __user *umask, unsigned long *mask,
 		       unsigned long bitmap_size);
diff --git a/kernel/compat.c b/kernel/compat.c
index 75573e5..d4898aa 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -678,7 +678,7 @@ int get_compat_sigevent(struct sigevent
 		? -EFAULT : 0;
 }
 
-long compat_get_bitmap(unsigned long *mask, compat_ulong_t __user *umask,
+long compat_get_bitmap(unsigned long *mask, const compat_ulong_t __user *umask,
 		       unsigned long bitmap_size)
 {
 	int i, j;
-- 
1.4.3.2

