Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264298AbUEXOOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264298AbUEXOOQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 10:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUEXOOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 10:14:15 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:47836 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S264296AbUEXOOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 10:14:04 -0400
Subject: [PATCH] msync shouldn't go over bss sections
From: Alexander Nyberg <alexn@telia.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1085408042.27361.17.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 24 May 2004 16:14:02 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This changes the behaviour of msync_interval() to make it impossible to
try to sys_msync() anything not file mapped.


--- mm/msync_orig.c     2004-05-23 21:31:32.000000000 +0200
+++ mm/msync.c  2004-05-24 16:10:24.000000000 +0200
@@ -137,7 +137,7 @@ static int filemap_sync(struct vm_area_s
 static int msync_interval(struct vm_area_struct * vma,
        unsigned long start, unsigned long end, int flags)
 {
-       int ret = 0;
+       int ret = -ENOMEM;
        struct file * file = vma->vm_file;
  
        if ((flags & MS_INVALIDATE) && (vma->vm_flags & VM_LOCKED))

