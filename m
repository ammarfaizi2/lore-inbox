Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758998AbWLAFGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758998AbWLAFGM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 00:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758987AbWLAFGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 00:06:12 -0500
Received: from smtp.osdl.org ([65.172.181.25]:65423 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1759035AbWLAFGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 00:06:10 -0500
Date: Thu, 30 Nov 2006 21:05:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Jakub Jelinek <jakub@redhat.com>, Keith Owens <kaos@ocs.com.au>,
       Nicholas Miell <nmiell@comcast.net>, linux-kernel@vger.kernel.org,
       davem@davemloft.net
Subject: Re: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick
 away
Message-Id: <20061130210551.e5ca0f29.akpm@osdl.org>
In-Reply-To: <20061129201410.GB1736@1wt.eu>
References: <1164769705.2825.4.camel@entropy>
	<21982.1164772580@kao2.melbourne.sgi.com>
	<20061129090800.GI6570@devserv.devel.redhat.com>
	<20061129201410.GB1736@1wt.eu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 21:14:10 +0100
Willy Tarreau <w@1wt.eu> wrote:

> Then why not simply check for gcc 4.1.0 in compiler.h and refuse to build
> with 4.1.0 if it's known to produce bad code ?

Think so.  I'll queue this and see how many howls it causes.

--- a/init/main.c~gcc-4-1-0-is-bust
+++ a/init/main.c
@@ -75,6 +75,10 @@
 #error Sorry, your GCC is too old. It builds incorrect kernels.
 #endif
 
+#if __GNUC__ == 4 && __GNUC_MINOR__ == 1 && __GNUC_PATCHLEVEL__ == 0
+#error gcc-4.1.0 is known to miscompile the kernel.  Please use a different compiler version.
+#endif
+
 static int init(void *);
 
 extern void init_IRQ(void);
_

