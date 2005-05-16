Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVEPIaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVEPIaw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 04:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVEPIac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 04:30:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:64428 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261234AbVEPHiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 03:38:00 -0400
Date: Mon, 16 May 2005 00:37:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Jan Beulich" <JBeulich@novell.com>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix file2alias for cross builds
Message-Id: <20050516003713.21778e7f.akpm@osdl.org>
In-Reply-To: <s283286f.070@emea1-mh.id2.novell.com>
References: <s283286f.070@emea1-mh.id2.novell.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <JBeulich@novell.com> wrote:
>
> When doing cross builds for 64-bit targets on 32-bit platforms, 64-bit
>  types may not have the same alignment on build and target platforms,
>  causing problems when parsing the ieee1394_device_id structures. This
>  adds explicit alignment to the 64-bit type used in file2alias.
> 
>  Signed-off-by: Jan Beulich <jbeulich@novell.com>
> 
>  diff -Npru linux-2.6.12-rc4.base/scripts/mod/file2alias.c linux-2.6.12-rc4/scripts/mod/file2alias.c
>  --- linux-2.6.12-rc4.base/scripts/mod/file2alias.c	2005-05-11 17:28:26.866988056 +0200
>  +++ linux-2.6.12-rc4/scripts/mod/file2alias.c	2005-05-11 17:50:36.316880952 +0200
>  @@ -17,7 +17,8 @@
>   #if KERNEL_ELFCLASS == ELFCLASS32
>   typedef Elf32_Addr	kernel_ulong_t;
>   #else
>  -typedef Elf64_Addr	kernel_ulong_t;
>  +/* This can't be a typedef as otherwise the attribute gets ignored. */
>  +#define kernel_ulong_t __attribute__((__aligned__(8))) Elf64_Addr
>   #endif
>   #ifdef __sun__
>   #include <inttypes.h>

It breaks ia64:

In file included from scripts/mod/file2alias.c:36:
include/linux/mod_devicetable.h:21: parse error before `__attribute__'
include/linux/mod_devicetable.h:21: warning: no semicolon at end of struct or union
include/linux/mod_devicetable.h:36: parse error before `__attribute__'
include/linux/mod_devicetable.h:36: warning: no semicolon at end of struct or union
include/linux/mod_devicetable.h:118: parse error before `__attribute__'
include/linux/mod_devicetable.h:118: warning: no semicolon at end of struct or union
include/linux/mod_devicetable.h:142: parse error before `__attribute__'
include/linux/mod_devicetable.h:142: warning: no semicolon at end of struct or union
include/linux/mod_devicetable.h:156: parse error before `__attribute__'
include/linux/mod_devicetable.h:156: warning: no semicolon at end of struct or union
include/linux/mod_devicetable.h:161: parse error before `__attribute__'
include/linux/mod_devicetable.h:161: warning: no semicolon at end of struct or union
include/linux/mod_devicetable.h:165: parse error before `}'
scripts/mod/file2alias.c: In function `do_usb_entry':
scripts/mod/file2alias.c:60: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:60: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:60: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:60: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:60: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:62: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:62: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:62: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:62: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:62: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:73: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:76: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:76: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:76: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:76: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:76: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:78: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:78: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:78: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:78: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:78: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:81: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:81: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:81: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:81: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:81: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:84: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:84: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:84: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:84: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:84: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:87: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:87: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:87: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:87: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:87: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:90: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:90: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:90: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:90: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:90: dereferencing pointer to incomplete type
scripts/mod/file2alias.c: In function `do_usb_entry_multi':
scripts/mod/file2alias.c:107: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:107: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:108: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:108: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:109: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:109: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:111: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:112: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:113: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:114: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:120: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:120: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:120: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:124: dereferencing pointer to incomplete type
scripts/mod/file2alias.c: In function `do_usb_table':
scripts/mod/file2alias.c:149: sizeof applied to an incomplete type
scripts/mod/file2alias.c: In function `do_ieee1394_entry':
scripts/mod/file2alias.c:166: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:166: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:167: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:167: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:168: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:168: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:169: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:169: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:170: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:170: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:173: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:173: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:173: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:173: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:173: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:175: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:175: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:175: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:175: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:175: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:177: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:177: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:177: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:177: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:177: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:179: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:179: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:179: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:179: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:179: dereferencing pointer to incomplete type
scripts/mod/file2alias.c: In function `do_pci_entry':
scripts/mod/file2alias.c:193: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:193: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:194: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:194: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:195: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:195: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:196: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:196: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:197: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:197: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:198: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:198: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:201: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:201: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:201: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:201: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:201: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:202: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:202: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:202: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:202: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:202: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:203: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:203: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:203: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:203: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:203: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:204: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:204: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:204: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:204: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:204: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:206: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:207: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:208: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:209: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:210: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:211: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:218: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:190: warning: `baseclass' might be used uninitialized in this function
scripts/mod/file2alias.c:190: warning: `subclass' might be used uninitialized in this function
scripts/mod/file2alias.c:190: warning: `interface' might be used uninitialized in this function
scripts/mod/file2alias.c:191: warning: `baseclass_mask' might be used uninitialized in this function
scripts/mod/file2alias.c:191: warning: `subclass_mask' might be used uninitialized in this function
scripts/mod/file2alias.c:191: warning: `interface_mask' might be used uninitialized in this function
scripts/mod/file2alias.c: In function `do_ccw_entry':
scripts/mod/file2alias.c:232: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:232: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:233: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:233: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:234: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:234: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:235: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:235: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:236: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:236: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:239: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:239: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:239: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:239: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:239: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:241: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:241: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:241: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:241: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:241: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:243: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:243: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:243: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:243: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:243: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:245: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:245: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:245: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:245: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:245: dereferencing pointer to incomplete type
scripts/mod/file2alias.c: In function `do_pnp_entry':
scripts/mod/file2alias.c:272: dereferencing pointer to incomplete type
scripts/mod/file2alias.c: In function `do_pnp_card_entry':
scripts/mod/file2alias.c:282: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:284: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:286: dereferencing pointer to incomplete type
scripts/mod/file2alias.c: In function `handle_moddevtable':
scripts/mod/file2alias.c:346: sizeof applied to an incomplete type
scripts/mod/file2alias.c:352: sizeof applied to an incomplete type
scripts/mod/file2alias.c:355: sizeof applied to an incomplete type
scripts/mod/file2alias.c:361: sizeof applied to an incomplete type
scripts/mod/file2alias.c:364: sizeof applied to an incomplete type
make[2]: *** [scripts/mod/file2alias.o] Error 1
make[1]: *** [scripts/mod] Error 2
make: *** [scripts] Error 2

