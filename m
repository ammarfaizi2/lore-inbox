Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261410AbSIWVXG>; Mon, 23 Sep 2002 17:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261426AbSIWVXG>; Mon, 23 Sep 2002 17:23:06 -0400
Received: from gherkin.frus.com ([192.158.254.49]:28570 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S261410AbSIWVXE>;
	Mon, 23 Sep 2002 17:23:04 -0400
Message-Id: <m17takZ-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: 2.5.38: modular IDE broken
To: linux-kernel@vger.kernel.org
Date: Mon, 23 Sep 2002 16:28:15 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may well have been broken in earlier versions...  The last one I
tried to compile before 2.5.38 was 2.5.34.  Quick problem summary:

ide-proc.o doesn't get built if CONFIG_BLK_DEV_IDE isn't "y", so
depmod complains about unresolved symbols.

If I edit linux/drivers/ide/Makefile to force the build, I still end
up with various depmod errors, some of which would doubtless go away
if I turned off module versioning.  Anyone got a quick fix that I'm
too tired to see?  Here's the depmod output with ide-proc.o forced:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.38; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.38/kernel/drivers/ide/ide-disk.o
depmod:         proc_ide_read_geometry_R50fed6f7
depmod: *** Unresolved symbols in /lib/modules/2.5.38/kernel/drivers/ide/ide-floppy.o
depmod:         proc_ide_read_geometry_R50fed6f7
depmod: *** Unresolved symbols in /lib/modules/2.5.38/kernel/drivers/ide/ide-probe.o
depmod:         do_ide_request
depmod:         ide_add_generic_settings
depmod:         create_proc_ide_interfaces_Rab2c600e
depmod:         ide_bus_type
depmod: *** Unresolved symbols in /lib/modules/2.5.38/kernel/drivers/ide/ide.o
depmod:         proc_ide_create_Ra8e0f104
depmod:         ide_remove_proc_entries_R5a5a621b
depmod:         ide_add_proc_entries_Rce569c25
depmod:         destroy_proc_ide_drives_Ra54f63e5
depmod:         proc_ide_destroy_R35e1351c
depmod:         bus_unregister
depmod:         proc_ide_read_capacity_R46b2a30d
depmod:         create_proc_ide_interfaces_Rab2c600e
depmod:         ide_scan_pcibus
make: *** [_modinst_post] Error 1

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
