Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264709AbUD1Jhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264709AbUD1Jhz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 05:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264710AbUD1Jhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 05:37:55 -0400
Received: from holomorphy.com ([207.189.100.168]:35200 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264709AbUD1Jhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 05:37:53 -0400
Date: Wed, 28 Apr 2004 02:37:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc2-mm2
Message-ID: <20040428093758.GA696@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040426013944.49a105a8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040426013944.49a105a8.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 01:39:44AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6-rc2/2.6.6-rc2-mm2/
> - Largeish reiserfs feature update.  The biggest change is probably the new
>   block allocation algorithm.  See the changelog inside
>   reiserfs-group-alloc-9.patch for details.
> - Added the ia64 CPU hotplug support patch
> - More work against the ext3 block allocator.
> - Several more framebuffer driver update, some quite substantial.
> - Lots of fixes, mostly minor.

arch/i386/kernel/built-in.o(.init.text+0x1efe): In function `ignore_timer_override':
arch/i386/kernel/entry.S:307: undefined reference to `acpi_skip_timer_override'
make[1]: *** [.tmp_vmlinux1] Error 1

ignore_timer_override() is only usable #if defined(CONFIG_ACPI_BOOT)
anyway, so:


-- wli


Index: local/wli-2.6.6-rc2-mm2/arch/i386/kernel/dmi_scan.c
===================================================================
--- local.orig/wli-2.6.6-rc2-mm2/arch/i386/kernel/dmi_scan.c	2004-04-28 01:22:29.000000000 -0700
+++ local/wli-2.6.6-rc2-mm2/arch/i386/kernel/dmi_scan.c	2004-04-28 02:31:59.000000000 -0700
@@ -565,6 +565,7 @@
  * early nForce2 reference BIOS shipped with a
  * bogus ACPI IRQ0 -> pin2 interrupt override -- ignore it
  */
+#ifdef CONFIG_ACPI_BOOT
 static __init int ignore_timer_override(struct dmi_blacklist *d)
 {
 	extern int acpi_skip_timer_override;
@@ -574,6 +575,7 @@
 	acpi_skip_timer_override = 1;
 	return 0;
 }
+#endif
 /*
  *	Process the DMI blacklists
  */
