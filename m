Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264723AbUEORWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264723AbUEORWE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 13:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264722AbUEORWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 13:22:04 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:46327 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264719AbUEORV4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 13:21:56 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Marc Singer <elf@buici.com>
Subject: [RFC][DOC] writing IDE driver guidelines
Date: Sat, 15 May 2004 19:23:50 +0200
User-Agent: KMail/1.5.3
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405151923.50343.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Feedback is welcomed.


writing IDE driver guidelines


general rules:

- code outside drivers/ide directory shouldn't need to
  include <linux/ide.h> if it does something is wrong

- do not believe in popular myth that driver code
  can be of less quality than core kernel code

- don't copy without thinking ugly and bogus code
  (there is still lot of such in IDE)

- IDE is going into full host driver model
  so write host driver for your interface

- host drivers should request/release IO resource
  themelves and set hwif->mmio to 2

- remember about ordering issues
  (you break device ordering and some machines won't boot)

- use linux-ide@vger.kernel.org mailing list


new architecture:

- add only what is really necessary to <asm/ide.h>
  and put interface specific code into drivers/ide

- ide_init_hwif_ports() is obsolete and dying,
  define IDE_ARCH_NO_OBSOLETE_INIT in <asm/ide.h>

- define ide_default_irq(), ide_init_default_irq()
  and ide_default_io_base() to (0)

- ide_init_default_hwifs() is gone


architecture specific drivers:

- do not abuse ide_default_irq()/ide_default_io_base() from <asm/ide.h>

- your driver should be in drivers/ide/<your_arch>/<your_driver_name>

- see drivers in drivers/ide/arm and drivers/ide/legacy for examples
  (especially m68k and arm specific drivers)

- do not use ide_setup_ports()


PCI drivers:

- no need to split your driver on .c and .h files

- /proc/ide/ interfaces are obsolete


--
Bartlomiej Zolnierkiewicz (15 May 2004)

