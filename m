Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267427AbTBXUUq>; Mon, 24 Feb 2003 15:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267429AbTBXUUp>; Mon, 24 Feb 2003 15:20:45 -0500
Received: from camus.xss.co.at ([194.152.162.19]:38665 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S267427AbTBXUUn>;
	Mon, 24 Feb 2003 15:20:43 -0500
Message-ID: <3E5A80F7.5070500@xss.co.at>
Date: Mon, 24 Feb 2003 21:30:47 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Make Linux 2.4.21pre4-ac6 compile
References: <200302240030.h1O0UaX14560@devserv.devel.redhat.com>
In-Reply-To: <200302240030.h1O0UaX14560@devserv.devel.redhat.com>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I need two small patches to make 2.4.21-pre4-ac6 compile for me:

1.) To solve an "unresolved symbol" error

root@install:/lib/modules/2.4.21-pre4-ac6 {508} $ depmod -ae
depmod: *** Unresolved symbols in /lib/modules/2.4.21-pre4-ac6/kernel/drivers/char/ipmi/ipmi_kcs_drv.o
depmod:         acpi_get_firmware_table

The following patch is needed:

--- linux-2.4.21-pre4-ac6/drivers/acpi/acpi_ksyms.c.orig        Sat Aug  3 02:39:43 2002
+++ linux-2.4.21-pre4-ac6/drivers/acpi/acpi_ksyms.c     Mon Feb 24 20:32:46 2003
@@ -68,6 +68,7 @@
  EXPORT_SYMBOL(acpi_get_next_object);
  EXPORT_SYMBOL(acpi_evaluate_object);
  EXPORT_SYMBOL(acpi_get_table);
+EXPORT_SYMBOL(acpi_get_firmware_table);

  EXPORT_SYMBOL(acpi_install_notify_handler);
  EXPORT_SYMBOL(acpi_remove_notify_handler);


2.) To make the new Intel i8xx framebuffer driver compile,
the following patch is needed:

--- linux-2.4.21-pre4-ac6/drivers/video/intel/intelfbdrv.c.orig Mon Feb 24 12:26:51 2003
+++ linux-2.4.21-pre4-ac6/drivers/video/intel/intelfbdrv.c      Mon Feb 24 12:25:52 2003
@@ -873,7 +873,7 @@
                 dinfo->cursor.timer.function = intelfb_flashcursor;
                 dinfo->cursor.timer.data = (unsigned long)dinfo;
                 dinfo->cursor.state = CM_ERASE;
-               spin_lock_init(dinfo->DAClock);
+               spin_lock_init(&(dinfo->DAClock));
         }

         if (bailearly == 19)

Otherwise 2.4.21-pre4-ac6 is now running fine on my test machine.

HTH

- andreas

PS: Any idea about when the new IDE driver can be compiled
and used completely as modules?

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71

