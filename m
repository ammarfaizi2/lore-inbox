Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263045AbTDBQKL>; Wed, 2 Apr 2003 11:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263048AbTDBQKL>; Wed, 2 Apr 2003 11:10:11 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:7811 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263045AbTDBQKI>; Wed, 2 Apr 2003 11:10:08 -0500
Date: Wed, 2 Apr 2003 17:21:26 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: acpi spinlock breakage
Message-ID: <20030402162119.GA19179@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

osl stuff looks really borked in current 2.5-bk ..

drivers/acpi/osl.c: In function `acpi_os_acquire_lock':
drivers/acpi/osl.c:739: warning: dereferencing `void *' pointer
drivers/acpi/osl.c:739: request for member `magic' in something not a structure or union
drivers/acpi/osl.c:739: warning: dereferencing `void *' pointer
drivers/acpi/osl.c:739: request for member `lock' in something not a structure or union
drivers/acpi/osl.c:739: warning: dereferencing `void *' pointer
drivers/acpi/osl.c:739: request for member `babble' in something not a structure or union
drivers/acpi/osl.c:739: warning: dereferencing `void *' pointer
drivers/acpi/osl.c:739: request for member `module' in something not a structure or union
drivers/acpi/osl.c:739: warning: dereferencing `void *' pointer
drivers/acpi/osl.c:739: request for member `owner' in something not a structure or union
drivers/acpi/osl.c:739: warning: dereferencing `void *' pointer
drivers/acpi/osl.c:739: request for member `oline' in something not a structure or union
drivers/acpi/osl.c:739: warning: dereferencing `void *' pointer
drivers/acpi/osl.c:739: request for member `babble' in something not a structure or union
drivers/acpi/osl.c:739: warning: dereferencing `void *' pointer
drivers/acpi/osl.c:739: request for member `lock' in something not a structure or union
drivers/acpi/osl.c:739: warning: dereferencing `void *' pointer
drivers/acpi/osl.c:739: request for member `owner' in something not a structure or union
drivers/acpi/osl.c:739: warning: dereferencing `void *' pointer
drivers/acpi/osl.c:739: request for member `oline' in something not a structure or union
drivers/acpi/osl.c: In function `acpi_os_release_lock':
drivers/acpi/osl.c:758: warning: dereferencing `void *' pointer
drivers/acpi/osl.c:758: request for member `magic' in something not a structure or union
drivers/acpi/osl.c:758: warning: dereferencing `void *' pointer
drivers/acpi/osl.c:758: request for member `lock' in something not a structure or union
drivers/acpi/osl.c:758: warning: dereferencing `void *' pointer
drivers/acpi/osl.c:758: request for member `babble' in something not a structure or union
drivers/acpi/osl.c:758: warning: dereferencing `void *' pointer
drivers/acpi/osl.c:758: request for member `module' in something not a structure or union
drivers/acpi/osl.c:758: warning: dereferencing `void *' pointer
drivers/acpi/osl.c:758: request for member `babble' in something not a structure or union
drivers/acpi/osl.c:758: warning: dereferencing `void *' pointer
drivers/acpi/osl.c:758: request for member `lock' in something not a structure or union
make[2]: *** [drivers/acpi/osl.o] Error 1
make[1]: *** [drivers/acpi] Error 2
make: *** [drivers] Error 2

Looks like its trying to spin_lock an 'acpi_handle',
which is typedef'd to void *

		Dave
