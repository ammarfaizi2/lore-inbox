Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVDEU6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVDEU6w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 16:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVDEU6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:58:06 -0400
Received: from host201.dif.dk ([193.138.115.201]:46086 "EHLO
	diftmgw2.backbone.dif.dk") by vger.kernel.org with ESMTP
	id S261928AbVDEUoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:44:10 -0400
Date: Tue, 5 Apr 2005 22:46:24 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc2-mm1 fails to build with my config - acpi related
Message-ID: <Pine.LNX.4.62.0504052203190.2444@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I get this when trying to build 2.6.12-rc2-mm1 : 

  CC      arch/i386/kernel/setup.o
arch/i386/kernel/setup.c:96: error: parse error before "acpi_sci_flags"
arch/i386/kernel/setup.c:96: warning: type defaults to `int' in declaration of `acpi_sci_flags'
arch/i386/kernel/setup.c:96: warning: data definition has no type or storage class
arch/i386/kernel/setup.c: In function `parse_cmdline_early':
arch/i386/kernel/setup.c:811: error: request for member `trigger' in something not a structure or union
arch/i386/kernel/setup.c:814: error: request for member `trigger' in something not a structure or union
arch/i386/kernel/setup.c:817: error: request for member `polarity' in something not a structure or union
arch/i386/kernel/setup.c:820: error: request for member `polarity' in something not a structure or union
arch/i386/kernel/setup.c: In function `setup_arch':
arch/i386/kernel/setup.c:1571: warning: implicit declaration of function `acpi_boot_table_init'
arch/i386/kernel/setup.c:1572: warning: implicit declaration of function `acpi_boot_init'
make[1]: *** [arch/i386/kernel/setup.o] Error 1
make: *** [arch/i386/kernel] Error 2

If I enable CONFIG_ACPI all is well - it seems some things get enabled by 
CONFIG_ACPI_BOOT regardless of CONFIG_ACPI being defined, this causes 
things to break since some of the stuff CONFIG_ACPI_BOOT enables depends 
on things only enabled in include/linux/acpi.h when CONFIG_ACPI is set...


-- 
Jesper Juhl


