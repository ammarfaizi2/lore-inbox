Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265703AbUGHJUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265703AbUGHJUJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 05:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265644AbUGHJUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 05:20:09 -0400
Received: from mproxy.gmail.com ([216.239.56.241]:2733 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S265902AbUGHJTq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 05:19:46 -0400
Message-ID: <cc723f5904070802196746d36@mail.gmail.com>
Date: Thu, 8 Jul 2004 14:49:45 +0530
From: Aneesh Kumar <aneesh.kumar@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Alpha print the symbol name in Oops
Cc: rth@redhat.com, ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org
In-Reply-To: <cc723f5904070802165c127e62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_114_30465566.1089278385641"
References: <cc723f5904070722341dcde1af@mail.gmail.com> <20040708001547.0fa78731.akpm@osdl.org> <cc723f5904070802165c127e62@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_114_30465566.1089278385641
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 8 Jul 2004 14:46:17 +0530, Aneesh Kumar <aneesh.kumar@gmail.com> wrote:
> 
> 
> On Thu, 8 Jul 2004 00:15:47 -0700, Andrew Morton <akpm@osdl.org> wrote:
> > Aneesh Kumar <aneesh.kumar@gmail.com> wrote:
> > >
> > >  +            printk("[<%lx>]", tmp);
> > >  +            print_symbol(" %s\n", tmp);
> >
> > print_symbol() does nothing at all if CONFIG_KALLSYMS=n.  You probably want:
> >
> >         printk("[<%lx>]", tmp);
> >         print_symbol(" %s", tmp);
> >         printk("\n");
> >
> 
> Patch attached.
> 

Sorry  I attached a wrong patch  of the CI project :)

-aneesh

------=_Part_114_30465566.1089278385641
Content-Type: text/x-patch; name="traps.c.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="traps.c.diff"

--- arch/alpha/kernel/traps.c=092004-07-08 10:55:36.000000000 +0530
+++ /tmp/traps.c=092004-07-08 14:45:17.000000000 +0530
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
@@ -117,20 +118,22 @@
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
+=09=09print_symbol(" %s", tmp);
+=09=09printk("\n");
 =09=09if (i > 40) {
 =09=09=09printk(" ...");
 =09=09=09break;
 =09=09}
 =09}

------=_Part_114_30465566.1089278385641--
