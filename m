Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVDCKiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVDCKiL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 06:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVDCKiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 06:38:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40466 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261648AbVDCKiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 06:38:07 -0400
Date: Sun, 3 Apr 2005 11:38:04 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix u32 vs. pm_message_t in arm
Message-ID: <20050403113804.A921@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Andrew Morton <akpm@osdl.org>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20050329191543.GA8309@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050329191543.GA8309@elf.ucw.cz>; from pavel@ucw.cz on Tue, Mar 29, 2005 at 09:15:43PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 09:15:43PM +0200, Pavel Machek wrote:
> This fixes u32 vs. pm_message_t confusion in arm. I was not able to
> even compile it, but it should not cause any problems. Please apply,

On testing this patch, it doesn't build.  You need to include
linux/pm.h into linux/sysdev.h for starters, and fix sysdev.h
to also use pm_message_t in it's function pointers.

Therefore, I'd like the following patch either to be in mainline first,
or in my ARM tree for Linus to pull so ARM doesn't completely break
on my next merge.

===== include/linux/sysdev.h 1.7 vs edited =====
--- 1.7/include/linux/sysdev.h	2004-02-13 06:18:02 +00:00
+++ edited/include/linux/sysdev.h	2005-04-03 11:30:13 +01:00
@@ -22,6 +22,7 @@
 #define _SYSDEV_H_
 
 #include <linux/kobject.h>
+#include <linux/pm.h>
 
 
 struct sys_device;


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
