Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbTHXOuK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 10:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbTHXOuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 10:50:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61191 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261185AbTHXOuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 10:50:03 -0400
Date: Mon, 25 Aug 2003 00:49:52 +1000 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jamesm@excalibur.intercode.com.au
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: linux-kernel@vger.kernel.org, <linux-ia64@vger.kernel.org>,
       <sds@epoch.ncsc.mil>
Subject: Re: selinux build failure
In-Reply-To: <33070.4.4.25.4.1061612835.squirrel@www.osdl.org>
Message-ID: <Mutt.LNX.4.44.0308250048080.21789-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Aug 2003, Randy.Dunlap wrote:

> selinux/hooks.c won't build on ia64.
> 2.6.0-test3 + ia64 patch or 2.6.0-test4.
> 
> security/selinux/hooks.c: In function `selinux_file_fcntl':
> security/selinux/hooks.c:2032: error: `F_GETLK64' undeclared (first use in
> this function) security/selinux/hooks.c:2033: error: `F_SETLK64' undeclared
> (first use in this function) security/selinux/hooks.c:2034: error:
> `F_SETLKW64' undeclared (first use in this function)
> 
> The __64 versions of these are defined in include/asm-ia64/compat.h. I don't
> see a good way to #include asm/compat.h, nor is it available for all
> processor architectures.

It is available via <linux/compat.h> if CONFIG_COMPAT is defined.

Does the patch below fix this for you?


- James
-- 
James Morris
<jmorris@redhat.com>

diff -urN -X dontdiff linux-2.6.0-test4.orig/security/selinux/hooks.c linux-2.6.0-test4.w1/security/selinux/hooks.c
--- linux-2.6.0-test4.orig/security/selinux/hooks.c	2003-08-23 11:53:14.000000000 +1000
+++ linux-2.6.0-test4.w1/security/selinux/hooks.c	2003-08-25 00:31:58.655604472 +1000
@@ -44,6 +44,7 @@
 #include <linux/ext2_fs.h>
 #include <linux/proc_fs.h>
 #include <linux/kd.h>
+#include <linux/compat.h>
 #include <net/icmp.h>
 #include <net/ip.h>		/* for sysctl_local_port_range[] */
 #include <net/tcp.h>		/* struct or_callable used in sock_rcv_skb */

