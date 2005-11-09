Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbVKISjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbVKISjo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 13:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbVKISjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 13:39:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:27293 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751502AbVKISiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 13:38:03 -0500
Date: Wed, 9 Nov 2005 10:36:35 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, Dimitri Puzin <tristan-777@ddkom-online.de>,
       nathans@sgi.com
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, bunk@stusta.de
Subject: [patch 02/11] fix XFS_QUOTA for modular XFS
Message-ID: <20051109183635.GC3670@kroah.com>
References: <20051109182205.294803000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="xfs-modular-quota-build-fix.patch"
In-Reply-To: <20051109183614.GA3670@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dimitri Puzin <tristan-777@ddkom-online.de>

This patch by Dimitri Puzin submitted through kernel Bugzilla #5514
fixes the following issue:

Cannot build XFS filesystem support as module with quota support. It
works only when the XFS filesystem support is compiled into the kernel.
Menuconfig prevents from setting CONFIG_XFS_FS=m and CONFIG_XFS_QUOTA=y.

How to reproduce: configure the XFS filesystem with quota support as
module. The resulting kernel won't have quota support compiled into
xfs.ko.

Fix: Changing the fs/xfs/Kconfig file from tristate to bool lets you
configure the quota support to be compiled into the XFS module. The
Makefile-linux-2.6 checks only for CONFIG_XFS_QUOTA=y.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Nathan Scott <nathans@sgi.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 fs/xfs/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14.1.orig/fs/xfs/Kconfig
+++ linux-2.6.14.1/fs/xfs/Kconfig
@@ -24,7 +24,7 @@ config XFS_EXPORT
 	default y
 
 config XFS_QUOTA
-	tristate "XFS Quota support"
+	bool "XFS Quota support"
 	depends on XFS_FS
 	help
 	  If you say Y here, you will be able to set limits for disk usage on

--
