Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264682AbTE1LWc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 07:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264684AbTE1LWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 07:22:32 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:43558 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264682AbTE1LWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 07:22:31 -0400
Date: Wed, 28 May 2003 04:36:00 -0700
From: Andrew Morton <akpm@digeo.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70: CODA breaks boot
Message-Id: <20030528043600.650a2f82.akpm@digeo.com>
In-Reply-To: <20030528112437.GA442@elf.ucw.cz>
References: <20030528112437.GA442@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 May 2003 11:35:47.0034 (UTC) FILETIME=[48105BA0:01C3250D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> ...it oopses in kmem_cache_create, called from release_console_sem and
>  coda_init_inodecache.

You'll be needing this one.

 fs/coda/inode.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN fs/coda/inode.c~coda-typo-fix fs/coda/inode.c
--- 25/fs/coda/inode.c~coda-typo-fix	2003-05-27 22:27:11.000000000 -0700
+++ 25-akpm/fs/coda/inode.c	2003-05-27 22:27:27.000000000 -0700
@@ -69,9 +69,9 @@ static void init_once(void * foo, kmem_c
 int coda_init_inodecache(void)
 {
 	coda_inode_cachep = kmem_cache_create("coda_inode_cache",
-					     sizeof(struct coda_inode_info),
-					     0, SLAB_HWCACHE_ALIGN||SLAB_RECLAIM_ACCOUNT,
-					     init_once, NULL);
+				sizeof(struct coda_inode_info),
+				0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+				init_once, NULL);
 	if (coda_inode_cachep == NULL)
 		return -ENOMEM;
 	return 0;

_

