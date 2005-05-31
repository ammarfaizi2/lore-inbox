Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVEaOJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVEaOJx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 10:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVEaOJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 10:09:53 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:18331 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261467AbVEaOJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 10:09:47 -0400
Message-ID: <429C7024.40002@mesatop.com>
Date: Tue, 31 May 2005 08:09:40 -0600
From: Steven Cole <elenstev@mesatop.com>
User-Agent: Thunderbird 0x29A (Multics)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Alexander Nyberg <alexn@telia.com>,
       Pete Clements <clem@clem.clem-digital.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc5-git3 fails compile -- acpi_boot_table_init
References: <200505281206.j4SC6iLa015878@clem.clem-digital.net> <1117287439.952.17.camel@localhost.localdomain> <Pine.LNX.4.58.0505291157120.10545@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505291157120.10545@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 28 May 2005, Alexander Nyberg wrote:
> 
>>This is a neverending story
>>
>>linux/acpi.h contains empty declarations for acpi_boot_init() &
>>acpi_boot_table_init() but they are nested inside #ifdef CONFIG_ACPI.
>>
>>So we'll have to #ifdef in arch/i386/kernel/setup.c: setup_arch()
> 
> 
> Wouldn't it be much nicer to just fix <linux/acpi.h> instead? Or, if you
> really prefer this, then you should remove the now useless code from
> acpi.h. In either case, this patch looks wrong.
> 
> 		Linus

Andrew provided a patch to fix this in include/linux/acpi.h back in
early April: http://marc.theaimsgroup.com/?l=linux-kernel&m=111275175906204&w=2

I had to fix up one reject, but it still fixes the no ACPI build for me, with
the current HEAD=5e485b7975472ba4a408523deb6541e70c451842.

Here's the patch.  Since akpm is the real author, he should sign off too.

Signed-off-by: Steven Cole <elenstev@mesatop.com>

Steven

include/linux/acpi.h: needs update
Index: include/linux/acpi.h
===================================================================
--- 3ac19ebb77c3cd8a1df31b7170c6eaf9e1afb1a4/include/linux/acpi.h  (mode:100644)
+++ uncommitted/include/linux/acpi.h  (mode:100644)
@@ -415,16 +415,6 @@

  #define acpi_mp_config	0

-static inline int acpi_boot_init(void)
-{
-	return 0;
-}
-
-static inline int acpi_boot_table_init(void)
-{
-	return 0;
-}
-
  #endif 	/*!CONFIG_ACPI_BOOT*/

  unsigned int acpi_register_gsi (u32 gsi, int edge_level, int active_high_low);
@@ -535,5 +525,17 @@

  extern int pnpacpi_disabled;

+ #else	/* CONFIG_ACPI */
+
+ static inline int acpi_boot_init(void)
+ {
+ 	return 0;
+ }
+
+ static inline int acpi_boot_table_init(void)
+ {
+ 	return 0;
+ }
+
  #endif	/* CONFIG_ACPI */
  #endif	/*_LINUX_ACPI_H*/
