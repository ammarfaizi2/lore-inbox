Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262257AbVCDGZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbVCDGZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 01:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVCDGZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 01:25:58 -0500
Received: from fire.osdl.org ([65.172.181.4]:52389 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262201AbVCDGYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 01:24:04 -0500
Date: Thu, 3 Mar 2005 22:23:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: jgarzik@pobox.com, chrisw@osdl.org, olof@austin.ibm.com, paulus@samba.org,
       rene@exactcode.de, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/
 Altivec
Message-Id: <20050303222335.372d1ad2.akpm@osdl.org>
In-Reply-To: <20050304062016.GO5389@shell0.pdx.osdl.net>
References: <422751D9.2060603@exactcode.de>
	<422756DC.6000405@pobox.com>
	<16935.36862.137151.499468@cargo.ozlabs.ibm.com>
	<20050303225542.GB16886@austin.ibm.com>
	<20050303175951.41cda7a4.akpm@osdl.org>
	<20050304022424.GA26769@austin.ibm.com>
	<20050304055451.GN5389@shell0.pdx.osdl.net>
	<20050303220631.79a4be7b.akpm@osdl.org>
	<4227FC5C.60707@pobox.com>
	<20050304062016.GO5389@shell0.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
>  * Jeff Garzik (jgarzik@pobox.com) wrote:
>  > Andrew Morton wrote:
>  > >Chris Wright <chrisw@osdl.org> wrote:
>  > >>Olof's patch is in the linux-release tree, so this brings up a point
>  > >>regarding merging.  If the quick fix is to be replaced by a better fix
>  > >>later (as in this case) there's some room for merge conflict.  Does this
>  > >>pose a problem for either -mm or Linus' tree?
>  > >
>  > >It depends who gets to Linus's tree first.  If linux-release merges first,
>  > >I just revert the temp fix while adding the real fix.  But the temp fix
>  > >should never have gone into Linus's tree in the first place.
> 
>  Consider it first patch in fixup series ;-)

Here's the second, and this is much more critical.

And it's untested.

And it's a temp-fix - it'll be addressed by other means in 2.6.12.

What do we do?



From: Dmitry Torokhov <dtor_core@ameritech.net>

Some ACPI-related changes were recently made to i8042 discovery for ia64. 
Unfortunately this broke a significant number of Dell laptops due to their
having incorrect BIOS tables.

So, for now, arrange for the new code to be ia64-only.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/input/serio/i8042-x86ia64io.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/input/serio/i8042-x86ia64io.h~i8042-pnp-workaround drivers/input/serio/i8042-x86ia64io.h
--- 25/drivers/input/serio/i8042-x86ia64io.h~i8042-pnp-workaround	2005-03-03 13:34:49.000000000 -0800
+++ 25-akpm/drivers/input/serio/i8042-x86ia64io.h	2005-03-03 13:34:49.000000000 -0800
@@ -88,7 +88,7 @@ static struct dmi_system_id __initdata i
 };
 #endif
 
-#ifdef CONFIG_ACPI
+#if defined(__ia64__) && defined(CONFIG_ACPI)
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
 
@@ -281,7 +281,7 @@ static inline int i8042_platform_init(vo
 	i8042_kbd_irq = I8042_MAP_IRQ(1);
 	i8042_aux_irq = I8042_MAP_IRQ(12);
 
-#ifdef CONFIG_ACPI
+#if defined(__ia64__) && defined(CONFIG_ACPI)
 	if (i8042_acpi_init())
 		return -1;
 #endif
@@ -300,7 +300,7 @@ static inline int i8042_platform_init(vo
 
 static inline void i8042_platform_exit(void)
 {
-#ifdef CONFIG_ACPI
+#if defined(__ia64__) && defined(CONFIG_ACPI)
 	i8042_acpi_exit();
 #endif
 }
_

