Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266180AbUFWVpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266180AbUFWVpW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUFWVi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:38:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:64947 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266714AbUFWVfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:35:15 -0400
Date: Wed, 23 Jun 2004 14:38:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pat Gefre <pfg@sgi.com>
Cc: linux-kernel@vger.kernel.org, erikj@sgi.com
Subject: Re: [PATCH 2.6] Altix serial driver
Message-Id: <20040623143801.74781235.akpm@osdl.org>
In-Reply-To: <Pine.SGI.3.96.1040623094239.19458C-100000@fsgi900.americas.sgi.com>
References: <Pine.SGI.3.96.1040623094239.19458C-100000@fsgi900.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pat Gefre <pfg@sgi.com> wrote:
>
> 2.6 patch for our console driver. We converted the driver to use the
> serial core functions. Also some changes to use sysfs/udev and a
> different major number.

This patch broke x86 `allmodconfig' and `allyesconfig'.  I fixed it with the
below patch.  Probably the condition should be IA64_SGI_SN2, yes?


diff -puN drivers/serial/Kconfig~altix-serial-driver-fix drivers/serial/Kconfig
--- 25/drivers/serial/Kconfig~altix-serial-driver-fix	Wed Jun 23 14:35:33 2004
+++ 25-akpm/drivers/serial/Kconfig	Wed Jun 23 14:35:33 2004
@@ -628,6 +628,7 @@ config SERIAL_LH7A40X_CONSOLE
 
 config SERIAL_SGI_L1_CONSOLE
 	bool "SGI Altix L1 serial console support"
+	depends on IA64
 	select SERIAL_CORE
 	help
 		If you have an SGI Altix and you would like to use the system
_

