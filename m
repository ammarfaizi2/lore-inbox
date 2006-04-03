Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWDCFMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWDCFMc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 01:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWDCFMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 01:12:32 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:21226 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750821AbWDCFMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 01:12:31 -0400
Date: Mon, 3 Apr 2006 14:13:25 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, pavel@ucw.cz
Subject: Re: Linux 2.6.17-rc1
Message-Id: <20060403141325.b4ccc5f4.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org>
References: <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Apr 2006 20:47:06 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> Ok, 
>  it's two weeks since 2.6.16, and the merge window is closed.
> 

Because my original patch was buggy and not tested, arm cannot work.
This is a fix patch.

Is this Okay? > Russell-san
-Kame
==
This patch fixes arch_local_page_offset(pfn,nid) in arm.
This macro calculate page offset in a node.

Note:
comment from arm's sub-archs. include/asm-arm/arch-clps711x/memory.h
/*
 * Given a kaddr, LOCAL_MAR_NR finds the owning node of the memory
 * and returns the index corresponding to the appropriate page in the
 * node's mem_map.
 */

Signed-Off-By:KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitu.com>

Index: linux-2.6.17-rc1/include/asm-arm/memory.h
===================================================================
--- linux-2.6.17-rc1.orig/include/asm-arm/memory.h
+++ linux-2.6.17-rc1/include/asm-arm/memory.h
@@ -188,7 +188,7 @@ static inline __deprecated void *bus_to_
  */
 #include <linux/numa.h>
 #define arch_pfn_to_nid(pfn)	(PFN_TO_NID(pfn))
-#define arch_local_page_offset(pfn, nid) (LOCAL_MAP_NR((pfn) << PAGE_OFFSET))
+#define arch_local_page_offset(pfn, nid) (LOCAL_MAP_NR(pfn_to_kaddr(pfn)))
 
 #define pfn_valid(pfn)						\
 	({							\

