Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265928AbUHNU5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265928AbUHNU5j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 16:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265782AbUHNU5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 16:57:39 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:38067 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265928AbUHNU5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 16:57:34 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Len Brown <len.brown@intel.com>
Subject: Re: [BKPATCH] ACPI for 2.6
Date: Sat, 14 Aug 2004 13:56:51 -0700
User-Agent: KMail/1.6.2
Cc: Linus Torvalds <torvalds@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
References: <1092466509.5028.248.camel@dhcppc4>
In-Reply-To: <1092466509.5028.248.camel@dhcppc4>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TynHBaaPsbMZ9XT"
Message-Id: <200408141356.51746.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_TynHBaaPsbMZ9XT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday, August 13, 2004 11:55 pm, Len Brown wrote:
> Hi Linus, please do a
>
> 	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.6.8
>
> 	Key fixes for suspend/resume, a couple of common
> 	boot failures, and misc. random fixes.

You'll need this fix for ia64 though.  Linus, please apply.

Define acpi_noirq on ia64 since it's used now in pci_link.c.  All ia64 
machines use ACPI, so we can just define it to 0 like we do for acpi_disabled 
and acpi_pci_disabled.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse

--Boundary-00=_TynHBaaPsbMZ9XT
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="ia64-acpi-build-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ia64-acpi-build-fix.patch"

diff -Napur -X /home/jbarnes/dontdiff linux-2.6.8-rc4.orig/include/asm-ia64/acpi.h linux-2.6.8-rc4/include/asm-ia64/acpi.h
--- linux-2.6.8-rc4.orig/include/asm-ia64/acpi.h	2004-08-10 09:01:34.000000000 -0700
+++ linux-2.6.8-rc4/include/asm-ia64/acpi.h	2004-08-10 09:26:39.000000000 -0700
@@ -89,6 +89,7 @@ ia64_acpi_release_global_lock (unsigned 
 	((Acq) = ia64_acpi_release_global_lock((unsigned int *) GLptr))
 
 #define acpi_disabled 0	/* ACPI always enabled on IA64 */
+#define acpi_noirq 0	/* ACPI always enabled on IA64 */
 #define acpi_pci_disabled 0 /* ACPI PCI always enabled on IA64 */
 #define acpi_strict 1	/* no ACPI spec workarounds on IA64 */
 static inline void disable_acpi(void) { }

--Boundary-00=_TynHBaaPsbMZ9XT--
