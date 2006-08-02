Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWHBVqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWHBVqQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWHBVqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:46:16 -0400
Received: from 1wt.eu ([62.212.114.60]:12813 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932239AbWHBVqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:46:14 -0400
Date: Wed, 2 Aug 2006 23:46:08 +0200
From: Willy Tarreau <w@1wt.eu>
To: mtosatti@redhat.com
Cc: linux-kernel@vger.kernel.org, Grant Coady <gcoady.lk@gmail.com>
Subject: [PATCH] 2.4.33-rc3 needs to export memchr() for smbfs
Message-ID: <20060802214608.GA1987@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

just finished building 2.4.33-rc3 on my dual-CPU Sun U60 (works
fine BTW). I noticed that smbfs built as a module needs memchr()
since a recent fix, so this one now needs to be exported, which
this patch does.  Sources show that the lp driver would need it
too is console on LP is enabled and LP is set as a module (which
seems stupid to me anyway). I've pushed it into -upstream if you
prefer to pull from it.

Overall, 2.4.33-rc3 seems to be OK to me. I don't think that
an additionnal -rc4 would be needed just for this export (Grant
CCed in case he's wishing to do a few more builds, you know
him...  :-) ).

Regards,
Willy


>From e3523609bec99d5c607fc00b4f68386d3390fb82 Mon Sep 17 00:00:00 2001
From: Willy Tarreau <w@1wt.eu>
Date: Wed, 2 Aug 2006 23:30:22 +0200
Subject: [PATCH] export memchr() which is used by smbfs and lp driver.

Recently, an smbfs fix added a dependency on memchr() which is
not exported if smbfs is built as a module.

Signed-Off-By: Willy Tarreau <w@1wt.eu>
---
 kernel/ksyms.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/kernel/ksyms.c b/kernel/ksyms.c
index d1e66c7..73ad3e9 100644
--- a/kernel/ksyms.c
+++ b/kernel/ksyms.c
@@ -579,6 +579,7 @@ EXPORT_SYMBOL(get_write_access);
 EXPORT_SYMBOL(strnicmp);
 EXPORT_SYMBOL(strspn);
 EXPORT_SYMBOL(strsep);
+EXPORT_SYMBOL(memchr);
 
 #ifdef CONFIG_CRC32
 EXPORT_SYMBOL(crc32_le);
-- 
1.4.1

