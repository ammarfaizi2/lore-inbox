Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbTIOCDm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 22:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbTIOCDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 22:03:41 -0400
Received: from srv1.mail.cv.net ([167.206.112.40]:7065 "EHLO srv1.mail.cv.net")
	by vger.kernel.org with ESMTP id S262410AbTIOCDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 22:03:40 -0400
Date: Sun, 14 Sep 2003 22:03:37 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
Subject: ACPI without PCI doesn't compile in 2.6.0-test5-bk3
X-X-Sender: proski@portland.hansa.lan
To: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.56.0309142154090.11432@portland.hansa.lan>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm trying to compile Linux 2.6.0-test5-bk3 for my 486 laptop.  The config
file is here:
http://www.red-bean.com/~proski/i486/dotconfig

I'm getting this error:

drivers/built-in.o(.init.text+0x913): In function `acpi_bus_init':
: undefined reference to `eisa_set_level_irq'
make: *** [.tmp_vmlinux1] Error 1

Close examination shows that acpi_bus_init() from drivers/acpi/bus.c calls
eisa_set_level_irq() if CONFIG_X86 is defined.  On the other hand,
eisa_set_level_irq() is defined in arch/i386/pci/irq.c and requires
CONFIG_PCI is addition to CONFIG_X86.

It's trivial to remove eisa_set_level_irq() call is CONFIG_PCI is not
defined, but I don't know if it's right.  I actually don't have APCI on
that laptop (I enabled it by mistake), so I cannot test if it works.

-- 
Regards,
Pavel Roskin
