Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbVJ0HwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbVJ0HwV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 03:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbVJ0Hv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 03:51:57 -0400
Received: from mail6.hitachi.co.jp ([133.145.228.41]:39918 "EHLO
	mail6.hitachi.co.jp") by vger.kernel.org with ESMTP id S964985AbVJ0Hvy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 03:51:54 -0400
Date: Thu, 27 Oct 2005 16:45:58 +0900 (JST)
Message-Id: <20051027.164558.92586706.noboru.obata.ar@hitachi.com>
To: indou.takao@soft.fujitsu.com
Cc: akpm@osdl.org, hyoshiok@miraclelinux.com, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Dump Summit 2005
From: OBATA Noboru <noboru.obata.ar@hitachi.com>
In-Reply-To: <C5C5D45B9312EFindou.takao@soft.fujitsu.com>
References: <C5C5D45B9312EFindou.takao@soft.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2005, Takao Indoh wrote:
> > 
> > Could you briefly explain the implementation of partial dump in
> > diskdump for those who are not familiar with it?
> > 
> > - Levels of partial dump (supported page categories)
> > - How to indentify the category (kernel data structure used)
> 
> Ok.
> Partial dump of diskdump defines 5 filters.
> 
> #define DUMP_EXCLUDE_CACHE 0x00000001 /* Exclude LRU & SwapCache pages*/
> #define DUMP_EXCLUDE_CLEAN 0x00000002 /* Exclude all-zero pages */
> #define DUMP_EXCLUDE_FREE  0x00000004 /* Exclude free pages */
> #define DUMP_EXCLUDE_ANON  0x00000008 /* Exclude Anon pages */
> #define DUMP_SAVE_PRIVATE  0x00000010 /* Save private pages */

> DUMP_EXCLUDE_FREE has some risks. If this filter is enable, diskdump
> scans free page linked lists. If the list is corrupt, diskdump may hang.
> Therefore, I always use level-19 (EXCLUDE_CACHE & EXCLUDE_CLEAN &
> SAVE_PRIVATE).
> 
> DUMP_EXCLUDE_CACHE reduces dump size effectively when file caches on
> memory are big. I don't use DUMP_EXCLUDE_ANON because user data(user
> stack, thread stack, mutex, etc.) is sometimes needed to investigate
> dump.
> DUMP_SAVE_PRIVATE is needed for filesystem. Filesystem (journal) uses
> PG_private pages, so these pages is necessary to investigate
> trouble of filesystem. 

Thank you for filters' description as well as the recommended
filter combination.

I'm just wondering the use of DUMP_EXCLUDE_CLEAN.  When a zero
page is excluded from a dump, how people know?  What I'm afraid
is that people would see an error (e.g., no such page in a dump)
in analyzing such a dump and be confused why.  Because it is a
cache, or zero-cleared, or, ...?  Any ideas?

Regards,

-- 
OBATA Noboru (noboru.obata.ar@hitachi.com)

