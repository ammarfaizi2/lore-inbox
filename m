Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbVK1RET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbVK1RET (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 12:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbVK1RET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 12:04:19 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:55118 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751304AbVK1RES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 12:04:18 -0500
Date: Mon, 28 Nov 2005 18:04:15 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: jbglaw@lug-owl.de, akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH 2.6.15-rc2-git6] Fix tar-pkg target
Message-ID: <20051128170414.GA10601@harddisk-recovery.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The various tar-pkg Makefile targets forget to apply the
CONFIG_LOCALVERSION_AUTO to the vminux and System.map files because the
script (scripts/package/buildtar) doesn't know about it. This can be
fixed by computing the correct "version" variable, but it's better to
use the one computed by Kbuild itself, just like the like the
"builddeb" and "mkspec" scripts do.

Without this patch, "make tar-pkg" would generate a file
linux-2.6.15-rc2.tar containing vmlinuz-2.6.15-rc2. With this patch, it
generates linux-2.6.15-rc2-g458af543.tar containing
vmlinuz-2.6.15-rc2-g458af543.


Erik

Signed-off-by: Erik Mouw <erik@harddisk-recovery.com>

diff --git a/scripts/package/buildtar b/scripts/package/buildtar
index d8fffe6..4c1b706 100644
--- a/scripts/package/buildtar
+++ b/scripts/package/buildtar
@@ -15,7 +15,7 @@ set -e
 #
 # Some variables and settings used throughout the script
 #
-version="${VERSION}.${PATCHLEVEL}.${SUBLEVEL}${EXTRAVERSION}${EXTRANAME}"
+version="${KERNELRELEASE}"
 tmpdir="${objtree}/tar-install"
 tarball="${objtree}/linux-${version}.tar"
 
