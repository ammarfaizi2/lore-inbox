Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264796AbSJVRWe>; Tue, 22 Oct 2002 13:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261641AbSJVRWd>; Tue, 22 Oct 2002 13:22:33 -0400
Received: from sr1.terra.com.br ([200.176.3.16]:35306 "EHLO sr1.terra.com.br")
	by vger.kernel.org with ESMTP id <S264798AbSJVRWU>;
	Tue, 22 Oct 2002 13:22:20 -0400
Subject: [PATCH 2.5.44] compile error whit LOCAL_APIC disabled...
From: Lucio Maciel <abslucio@terra.com.br>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-5M/1thPs2lVmUWHA6DMx"
X-Mailer: Ximian Evolution 1.0.7 
Date: 22 Oct 2002 14:28:26 -0300
Message-Id: <1035307707.7677.27.camel@walker>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5M/1thPs2lVmUWHA6DMx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello

2.5.44 are not compiling with APIC disabled.

<cut arch/i386/config.in>
if [ "$CONFIG_X86_LOCAL_APIC" = "y" ]; then
	define_bool CONFIG_X86_EXTRA_IRQS y
	define_bool CONFIG_X86_FIND_SMP_CONFIG y
	define_bool CONFIG_X86_MPPARSE y
fi
</cut>

CONFIG_X86_MPPARSE that should only be enabled when LOCAL_APIC is enable to, is getting always enable
breaking the compile...

the problem is with a undefined reference do Dprintk, defined in <asm/apic.h>

regards..
-- 
::: Lucio F. Maciel
::: abslucio@terra.com.br
::: icq 93065464
::: Absoluta.net

--=-5M/1thPs2lVmUWHA6DMx
Content-Disposition: attachment; filename=mpparse.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=mpparse.diff; charset=ANSI_X3.4-1968

--- ../linux-2.5.44/arch/i386/kernel/mpparse.c	2002-10-16 09:32:26.00000000=
0 -0300
+++ arch/i386/kernel/mpparse.c	2002-10-22 14:16:12.000000000 -0300
@@ -29,6 +29,7 @@
 #include <asm/mtrr.h>
 #include <asm/mpspec.h>
 #include <asm/pgalloc.h>
+#include <asm/apic.h>
 #include <asm/io_apic.h>
 #include "mach_apic.h"
=20

--=-5M/1thPs2lVmUWHA6DMx--

