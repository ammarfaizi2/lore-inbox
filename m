Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbTI1PSs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 11:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTI1PSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 11:18:48 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42473 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262593AbTI1PSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 11:18:46 -0400
Date: Sun, 28 Sep 2003 17:18:39 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@osdl.org>, David Howells <dhowells@redhat.com>,
       David Woodhouse <dwmw2@cambridge.redhat.com>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: [2.6 patch] select for fs/Kconfig
Message-ID: <20030928151839.GG15338@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below switches fs/Kconfig to use select where appropriate 
(affects nfs{,d} and afs).

diffstat output:
ú
 fs/Kconfig |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)
 

cu
Adrian

--- linux-2.6.0-test6-full/fs/Kconfig.old	2003-09-28 16:12:39.000000000 +0200
+++ linux-2.6.0-test6-full/fs/Kconfig	2003-09-28 16:20:56.000000000 +0200
@@ -1253,8 +1253,10 @@
 
 config NFS_FS
 	tristate "NFS file system support"
 	depends on INET
+	select LOCKD
+	select SUNRPC
 	help
 	  If you are connected to some other (usually local) Unix computer
 	  (using SLIP, PLIP, PPP or Ethernet) and want to mount files residing
 	  on that computer (the NFS server) using the Network File Sharing
@@ -1308,8 +1310,10 @@
 
 config NFSD
 	tristate "NFS server support"
 	depends on INET
+	select LOCKD
+	select SUNRPC
 	help
 	  If you want your Linux box to act as an NFS *server*, so that other
 	  computers on your local network which support NFS can access certain
 	  directories on your box transparently, you have two options: you can
@@ -1370,10 +1374,8 @@
 	  Most people say N here.
 
 config LOCKD
 	tristate
-	default m if NFS_FS!=y && NFSD!=y && (NFS_FS=m || NFSD=m)
-	default y if NFS_FS=y || NFSD=y
 
 config LOCKD_V4
 	bool
 	depends on NFSD_V3 || NFS_V3
@@ -1384,10 +1386,8 @@
 	default NFSD
 
 config SUNRPC
 	tristate
-	default m if NFS_FS!=y && NFSD!=y && (NFS_FS=m || NFSD=m)
-	default y if NFS_FS=y || NFSD=y
 
 config SUNRPC_GSS
 	tristate "Provide RPCSEC_GSS authentication (EXPERIMENTAL)"
 	depends on SUNRPC && EXPERIMENTAL
@@ -1564,8 +1564,9 @@
 config AFS_FS
 # for fs/nls/Config.in
 	tristate "Andrew File System support (AFS) (Experimental)"
 	depends on INET && EXPERIMENTAL
+	select RXRPC
 	help
 	  If you say Y here, you will get an experimental Andrew File System
 	  driver. It currently only supports unsecured read-only AFS access.
 
@@ -1574,10 +1575,8 @@
 	  If unsure, say N.
 
 config RXRPC
 	tristate
-	default m if AFS_FS=m
-	default y if AFS_FS=y
 
 endmenu
 
 menu "Partition Types"
