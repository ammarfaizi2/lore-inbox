Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbUFNLPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUFNLPp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 07:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbUFNLPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 07:15:44 -0400
Received: from holomorphy.com ([207.189.100.168]:55455 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262391AbUFNLPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 07:15:43 -0400
Date: Mon, 14 Jun 2004 04:15:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc3-mm2
Message-ID: <20040614111540.GB1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040614021018.789265c4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614021018.789265c4.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 02:10:18AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc3/2.6.7-rc3-mm2/
> - Mainly lots of little fixes.
> - Added the ext3 online-resize patch.  See
>   http://sourceforge.net/projects/ext2resize/ for some details.  Needs a bit
>   of work, and documentation.

The arrangement of the #include <linux/kernel.h> in list.h breaks the
build of documentation. The following patch moves the include to where
it no longer interferes with kerneldoc's operation.


-- wli

Index: debian-2.6.7-rc3/include/linux/list.h
===================================================================
--- debian-2.6.7-rc3.orig/include/linux/list.h	2004-06-14 03:18:03.000000000 -0700
+++ debian-2.6.7-rc3/include/linux/list.h	2004-06-14 04:06:36.000000000 -0700
@@ -5,6 +5,7 @@
 
 #include <linux/stddef.h>
 #include <linux/prefetch.h>
+#include <linux/kernel.h>	/* BUG_ON */
 #include <asm/system.h>
 
 /*
@@ -158,7 +159,6 @@
  * Note: list_empty on entry does not return true after this, the entry is
  * in an undefined state.
  */
-#include <linux/kernel.h>	/* BUG_ON */
 static inline void list_del(struct list_head *entry)
 {
 	BUG_ON(entry->prev->next != entry);
