Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbTKDWJo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 17:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbTKDWJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 17:09:44 -0500
Received: from rth.ninka.net ([216.101.162.244]:33665 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261176AbTKDWJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 17:09:41 -0500
Date: Tue, 4 Nov 2003 15:09:33 -0800
From: "David S. Miller" <davem@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -bk regression against -test9
Message-Id: <20031104150933.5b2c7a32.davem@redhat.com>
In-Reply-To: <20031104110703.GA217@elf.ucw.cz>
References: <20031104110703.GA217@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Nov 2003 12:07:03 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> Current -bk does not boot (where -test9 works okay):
> 
> Null pointer dereference
> EIP=dev_add_pack+0x3d
> Called from irda_init, do_initcalls.
> 
> Any ideas?

The change that causes this has been reverted from
Linus's tree already, as follows below.  Another workaround
is to disable IRDA or build it as a module.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1396.1.7 -> 1.1396.1.8
#	      net/core/dev.c	1.122   -> 1.123  
#	drivers/pnp/isapnp/core.c	1.44    -> 1.45   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/11/01	davem@nuts.ninka.net	1.1396.1.8
# Cset exclude: akpm@osdl.org|ChangeSet|20031029192849|64746
# --------------------------------------------
#
diff -Nru a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
--- a/drivers/pnp/isapnp/core.c	Tue Nov  4 14:06:01 2003
+++ b/drivers/pnp/isapnp/core.c	Tue Nov  4 14:06:01 2003
@@ -1160,7 +1160,7 @@
 	return 0;
 }
 
-fs_initcall(isapnp_init);
+device_initcall(isapnp_init);
 
 /* format is: noisapnp */
 
diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	Tue Nov  4 14:06:01 2003
+++ b/net/core/dev.c	Tue Nov  4 14:06:01 2003
@@ -3049,7 +3049,7 @@
 	return rc;
 }
 
-fs_initcall(net_dev_init);
+subsys_initcall(net_dev_init);
 
 EXPORT_SYMBOL(__dev_get);
 EXPORT_SYMBOL(__dev_get_by_flags);


