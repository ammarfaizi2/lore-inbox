Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266018AbUAVIby (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 03:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266092AbUAVIby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 03:31:54 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:1623 "EHLO
	gpkxch01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266018AbUAVIbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 03:31:48 -0500
Subject: [PATCH] The RAW_GETBIND compat_ioctl fails
From: James Cross <jscross@veritas.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Jan 2004 08:53:38 +0000
Message-Id: <1074761619.9010.128.camel@tinkle>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The RAW_GETBIND compatibility ioctl call does convert properly between
the 32bit/64bit version of raw_config_request due to a trivial error,
and the ioctl call fails.

Thanks,

James

--- linux-2.6.2-rc1/fs/compat_ioctl.c.orig	2004-01-21 17:20:26.000000000 +0000
+++ linux-2.6.2-rc1/fs/compat_ioctl.c	2004-01-21 17:20:41.000000000 +0000
@@ -2426,7 +2426,7 @@
         __get_user(hi_min, ((__u32*)(&user_req->block_minor) + 1));
 
         req->block_major = lo_maj | (((__u64)hi_maj) << 32);
-        req->block_minor = lo_min | (((__u64)lo_min) << 32);
+        req->block_minor = lo_min | (((__u64)hi_min) << 32);
 
         return ret;
 }

