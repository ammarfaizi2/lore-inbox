Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129450AbQLaXDl>; Sun, 31 Dec 2000 18:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129745AbQLaXDb>; Sun, 31 Dec 2000 18:03:31 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:41449 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129450AbQLaXDR>; Sun, 31 Dec 2000 18:03:17 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 31 Dec 2000 14:32:47 -0800
Message-Id: <200012312232.OAA06019@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: test13-pre[567]: acpi infinite loop on Sony PictureBook (Transmeta version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        At least when I build acpi as a module under 2.4.0-test13-pre5
(which requires tweaking the Makefiles and a config.in, but no 
modifications to .c or .h files), acpi gets into an infinite loop
when it is loaded as a module on a Transmeta-based Sony PictureBook.
The same kernel+module loads fine on a desktop machine that I tried,
and doing the same on 2.4.0-test13-pre3 works fine on both computers.
The problem is still in test13-pre7.

        From a day of reboots and printk's, I know that the infinite
loop includes at the following call hierarchy:

                acpi_resolve_to_value
                acpi_resolve_node_to_value
                acpi_aml_access_named_field
                acpi_aml_read_field
                acpi_aml_read_field_data

        I also know that, elsewhere in the inifinite loop,
acpi_release_parse_tree is called, as are acpi_cm_{acquire,release}_mutex.

        I know that the following calls are made shortly before
the infinite loop starts:

                acpi_aml_exec_store
                acpi_aml_store_object_to_node
                acpi_aml_access_named_field
                acpi_aml_write_field
                acpi_aml_write_field_data

        I will explore this more tomorrow, but I have been exploring
this problem on and off for three days, so I thought I ought to
mention it on linux-kernel.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
