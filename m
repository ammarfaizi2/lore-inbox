Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031423AbWKVESF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031423AbWKVESF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 23:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031089AbWKVERj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 23:17:39 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18189 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030684AbWKVERg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 23:17:36 -0500
Date: Wed, 22 Nov 2006 05:17:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] CACHEFILES must depend on PROC_FS
Message-ID: <20061122041736.GB5200@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error with CONFIG_PROC_FS=n:

<--  snip  -->

...
  CC      fs/cachefiles/cf-main.o
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/fs/cachefiles/cf-main.c: In function 'cachefiles_init':
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/fs/cachefiles/cf-main.c:77: error: 'proc_root_fs' undeclared (first use in this function)
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/fs/cachefiles/cf-main.c:77: error: (Each undeclared identifier is reported only once
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/fs/cachefiles/cf-main.c:77: error: for each function it appears in.)
make[3]: *** [fs/cachefiles/cf-main.o] Error 1

<--  snip  -->

This patch adds the missing dependency of CACHEFILES on PROC_FS.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/fs/Kconfig.old	2006-11-22 02:48:36.000000000 +0100
+++ linux-2.6.19-rc5-mm2/fs/Kconfig	2006-11-22 02:49:01.000000000 +0100
@@ -654,6 +654,7 @@ config FSCACHE
 
 config CACHEFILES
 	tristate "Filesystem caching on files"
+	depends on PROC_FS
 	select FSCACHE
 	help
 	  This permits use of a mounted filesystem as a cache for other

