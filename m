Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265795AbUGHFei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUGHFei (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 01:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265799AbUGHFeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 01:34:37 -0400
Received: from mproxy.gmail.com ([216.239.56.244]:10553 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S265795AbUGHFe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 01:34:29 -0400
Message-ID: <cc723f5904070722341dcde1af@mail.gmail.com>
Date: Thu, 8 Jul 2004 11:04:17 +0530
From: Aneesh Kumar <aneesh.kumar@gmail.com>
To: rth@redhat.com, ink@jurassic.park.msu.ru
Subject: [PATCH] Alpha print the symbol name in Oops
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_107_21740610.1089264857990"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_107_21740610.1089264857990
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

This makes Alpha to print the symbol name in a Oops message.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

-aneesh

------=_Part_107_21740610.1089264857990
Content-Type: text/x-patch; name="traps.c.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="traps.c.diff"

--- traps.c=092004-07-08 10:55:36.000000000 +0530
+++ /tmp/traps.c=092004-07-08 10:55:23.000000000 +0530
@@ -14,10 +14,11 @@
 #include <linux/tty.h>
 #include <linux/delay.h>
 #include <linux/smp_lock.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/kallsyms.h>
=20
 #include <asm/gentrap.h>
 #include <asm/uaccess.h>
 #include <asm/unaligned.h>
 #include <asm/sysinfo.h>
@@ -117,20 +118,21 @@
=20
 static void
 dik_show_trace(unsigned long *sp)
 {
 =09long i =3D 0;
-=09printk("Trace:");
+=09printk("Trace:\n");
 =09while (0x1ff8 & (unsigned long) sp) {
 =09=09extern char _stext[], _etext[];
 =09=09unsigned long tmp =3D *sp;
 =09=09sp++;
 =09=09if (tmp < (unsigned long) &_stext)
 =09=09=09continue;
 =09=09if (tmp >=3D (unsigned long) &_etext)
 =09=09=09continue;
-=09=09printk("%lx%c", tmp, ' ');
+=09=09printk("[<%lx>]", tmp);
+=09=09print_symbol(" %s\n", tmp);
 =09=09if (i > 40) {
 =09=09=09printk(" ...");
 =09=09=09break;
 =09=09}
 =09}

------=_Part_107_21740610.1089264857990--
