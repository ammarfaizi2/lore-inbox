Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbULBItJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbULBItJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 03:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbULBItJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 03:49:09 -0500
Received: from mini002.webpack.hosteurope.de ([80.237.130.131]:11484 "EHLO
	mini002.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S261516AbULBItB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 03:49:01 -0500
From: "cr7" <cr7@darav.de>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: Re: 2.6.10-rc2-mm4 - non-ACPI compile broken
Date: Thu, 02 Dec 2004 10:42:40 +0100
Message-ID: <elmo110198056013041086480495@debian>
User-Agent: elmo/1.3.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="--java_obsysa424990052"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----java_obsysa424990052
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,


I've tried to compile 2.6.10-rc2-mm4 without ACPI on an i386-arch.
It shows:
arch/i386/kernel/built-in.o(.init.text+0x167e): In function `setup_arch':
: undefined reference to `acpi_boot_table_init'
make: *** [.tmp_vmlinux1] Fehler 1

The patch which seems to be responsible is:
x86_64-split-acpi-boot-table-parsing.patch
Around line 83 and the following.

acpi_boot_table_init is located in arch/i386/kernel/acpi/boot.c
But it's only compiled with CONFIG_ACPI_BOOT set.

The attached patch fixes the problem by adding a dummy function to include/linux/acpi.h - like it's done for acpi_init() too.

Regards,
Carsten

Please cc, I'm not subscribed.




----java_obsysa424990052
Content-Type: text/plain
Content-Disposition: attachment; filename="fix_no_acpi_compile.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtdXByIGxpbnV4L2luY2x1ZGUvbGludXgvYWNwaS5oIGxpbnV4LW5ldy9pbmNsdWRlL2xpbnV4
L2FjcGkuaAotLS0gbGludXgvaW5jbHVkZS9saW51eC9hY3BpLmgJMjAwNC0xMi0wMSAxNDoyODozMi4w
MDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4LW5ldy9pbmNsdWRlL2xpbnV4L2FjcGkuaAkyMDA0LTEyLTAy
IDEwOjMwOjUzLjAwMDAwMDAwMCArMDEwMApAQCAtNDI0LDYgKzQyNCwxMyBAQCBzdGF0aWMgaW5saW5l
IGludCBhY3BpX3RhYmxlX2luaXQodm9pZCkKIAlyZXR1cm4gMDsKIH0KIAorc3RhdGljIGlubGluZSBp
bnQgYWNwaV9ib290X3RhYmxlX2luaXQodm9pZCkKK3sKKwlyZXR1cm4gMDsKK30KKworCisKICNlbmRp
ZiAJLyohQ09ORklHX0FDUElfQk9PVCovCiAKIHVuc2lnbmVkIGludCBhY3BpX3JlZ2lzdGVyX2dzaSAo
dTMyIGdzaSwgaW50IGVkZ2VfbGV2ZWwsIGludCBhY3RpdmVfaGlnaF9sb3cpOwo=
----java_obsysa424990052--

