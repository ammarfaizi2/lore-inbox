Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbTDHVmn (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 17:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbTDHVmm (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 17:42:42 -0400
Received: from x101-201-233-dhcp.reshalls.umn.edu ([128.101.201.233]:26045
	"EHLO minerva") by vger.kernel.org with ESMTP id S261764AbTDHVmm (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 17:42:42 -0400
Date: Tue, 8 Apr 2003 16:54:11 -0500
From: Matt Reppert <arashi@yomerashi.yi.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, rth@twiddle.net
Subject: Re: Linux 2.5.67
Message-Id: <20030408165411.4e6d1465.arashi@yomerashi.yi.org>
In-Reply-To: <Pine.LNX.4.44.0304071051190.1385-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0304071051190.1385-100000@penguin.transmeta.com>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Apr 2003 10:53:43 -0700 (PDT)
Linus Torvalds <torvalds@transmeta.com> wrote:

> 
> All over the place as usual - there's definitely a lot of small things 
> going on. PCMCIA and i2c updates may be the most noticeable ones.

Alpha (LX164) still doesn't build:

cc1: warnings being treated as errors
arch/alpha/kernel/pci.c:314: warning: type defaults to `int' in declaration of `EXPORT_SYMBOL'
arch/alpha/kernel/pci.c:314: warning: parameter names (without types) in function declaration
arch/alpha/kernel/pci.c:314: warning: data definition has no type or storage class

The included patch fixes this. I don't know what to do about the following, though:

kernel/sys.c:226: conflicting types for `sys_sendmsg'
include/linux/socket.h:245: previous declaration of `sys_sendmsg'
kernel/sys.c:227: conflicting types for `sys_recvmsg'
include/linux/socket.h:246: previous declaration of `sys_recvmsg'

Matt

--- 1.29/arch/alpha/kernel/pci.c	Sun Mar 23 19:35:08 2003
+++ 1.30/arch/alpha/kernel/pci.c	Fri Apr  4 20:06:45 2003
@@ -19,6 +19,7 @@
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/bootmem.h>
+#include <linux/module.h>
 #include <linux/cache.h>
 #include <asm/machvec.h>
 
