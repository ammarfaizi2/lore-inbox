Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbTJKTqV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 15:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbTJKTqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 15:46:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:26754 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263387AbTJKTqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 15:46:19 -0400
Date: Sat, 11 Oct 2003 12:40:25 -0700
From: "David S. Miller" <davem@redhat.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: patches for PROC_FS=n (2.6.0-test7)
Message-Id: <20031011124025.6cc2ada8.davem@redhat.com>
In-Reply-To: <20031011194008.GA2395@mars.ravnborg.org>
References: <20031010141646.779f10bb.rddunlap@osdl.org>
	<20031011120852.13fa8ec4.davem@redhat.com>
	<20031011194008.GA2395@mars.ravnborg.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Oct 2003 21:40:08 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> Due to this - the real offender:
> 
> from: net/atm/clip.c:
> #ifdef CONFIG_PROC_FS
> #include <linux/proc_fs.h>
> #include <linux/seq_file.h>
> #endif

That makes a whole lot more sense, here is the fix I just
checked in:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1352  -> 1.1353 
#	      net/atm/clip.c	1.26    -> 1.27   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/10/11	davem@nuts.ninka.net	1.1353
# [ATM]: Kill PROC_FS ifdef around includes.
# --------------------------------------------
#
diff -Nru a/net/atm/clip.c b/net/atm/clip.c
--- a/net/atm/clip.c	Sat Oct 11 12:43:12 2003
+++ b/net/atm/clip.c	Sat Oct 11 12:43:12 2003
@@ -24,10 +24,8 @@
 #include <linux/if.h> /* for IFF_UP */
 #include <linux/inetdevice.h>
 #include <linux/bitops.h>
-#ifdef CONFIG_PROC_FS
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
-#endif
 #include <net/route.h> /* for struct rtable and routing */
 #include <net/icmp.h> /* icmp_send */
 #include <asm/param.h> /* for HZ */
