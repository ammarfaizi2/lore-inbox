Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267432AbVBEVYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267432AbVBEVYT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 16:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270233AbVBEVYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 16:24:18 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:31188 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S270694AbVBEVYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 16:24:08 -0500
Subject: [PATCH] Missing Select in NFS server support causes comile error
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: SoftwareSuspend Development 
	<softwaresuspend-devel@lists.berlios.de>
In-Reply-To: <1107637875.6348.22.camel@desktop.cunninghams>
References: <1107637875.6348.22.camel@desktop.cunninghams>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1107638788.6348.31.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sun, 06 Feb 2005 08:26:28 +1100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

(Resent in a format that can be more easily applied).

This issues was picked up by Peter Frühberger.

If NFS server support is selected, but ExportFS is not, the following
compile time errors occur:

> > >   LD      init/built-in.o
> > >   LD      .tmp_vmlinux1
> > > fs/built-in.o(.text+0x7329f): In function `fh_verify':
> > > : undefined reference to `export_op_default'
> > > fs/built-in.o(.text+0x738b7): In function `fh_compose':
> > > : undefined reference to `export_op_default'
> > > fs/built-in.o(.text+0x73bb7): In function `fh_update':
> > > : undefined reference to `export_op_default'
> > > fs/built-in.o(.text+0x73e80): In function `_fh_update':
> > > : undefined reference to `export_op_default'
> > > fs/built-in.o(.text+0x78150): In function `check_export':
> > > : undefined reference to `find_exported_dentry'
> > > make[1]: *** [.tmp_vmlinux1] Error 1
> > > 

Signed-off by: Nigel Cunningham <ncunningham@linuxmail.org>

diff -ruNp 990-select-exportfs-on-nfs-server-old/fs/Kconfig 990-select-exportfs-on-nfs-server-new/fs/Kconfig
--- 990-select-exportfs-on-nfs-server-old/fs/Kconfig	2005-02-03 22:33:40.000000000 +1100
+++ 990-select-exportfs-on-nfs-server-new/fs/Kconfig	2005-02-06 08:22:25.000000000 +1100
@@ -1400,6 +1400,7 @@ config NFSD
 	tristate "NFS server support"
 	depends on INET
 	select LOCKD
+	select EXPORTFS
 	select SUNRPC
 	help
 	  If you want your Linux box to act as an NFS *server*, so that other

-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

