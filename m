Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130794AbQLTBbu>; Tue, 19 Dec 2000 20:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130855AbQLTBba>; Tue, 19 Dec 2000 20:31:30 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:53927 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S130794AbQLTBb2>; Tue, 19 Dec 2000 20:31:28 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 19 Dec 2000 17:00:58 -0800
Message-Id: <200012200100.RAA02590@adam.yggdrasil.com>
To: acme@conectiva.com.br, acpi@phobos.fachschaften.tu-muenchen.de
Subject: 2.4.0-test13pre3 acpi circular dependency
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Although the stock linux-2.4.0-test13pre3 does not allow
one to build the acpi interpreter as a loadable module, I had
tweaked the Makefiles in previous kernels to do this (the supporting
code is there and it seemed to work, at least for shutting off the
power after a shutdown).  Unfortunately, in 2.4.0-test13pre3, this
is no harder to do, because there is a circular dependency:

drivers/acpi/ references acpi_get_rsdp_ptr in arch/i386/kernel/acpi.c,
				and
arch/i386/kernel/acpi.c references acp_find_root_pointer in drivers/acpi/.


	I would like to recommend that the contents of
arch/i{386,a64}/kernel/acpi.c be merged back somewhere in drivers/acpi/,
and just selected with Makefile options, ifdefs, or perhaps runtime
options (if the ia64 code is potentionally useable to an i386 kernel
that find itself running on an ia64 CPU, which will probably be the case
with most Linux distributions initially installed on ia64 hardware).

	If need be, I would be willing to at least write a quick and
dirty #ifdef-based version of this proposed change.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
