Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267947AbUGaMh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267947AbUGaMh4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 08:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267946AbUGaMhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 08:37:55 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:58754 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267954AbUGaMhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 08:37:00 -0400
Message-ID: <cc723f590407310536634ede0b@mail.gmail.com>
Date: Sat, 31 Jul 2004 18:06:59 +0530
From: Aneesh Kumar <aneesh.kumar@gmail.com>
To: Andrew Morton <akpm@osdl.org>, rth@redhat.com,
       linux-kernel@vger.kernel.org
Subject: [ PATCH ] Alpha print the symbol of pc and ra during Oops
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_60_1129377.1091277419620"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_60_1129377.1091277419620
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

The below patch add the symbol information of the pc and ra to the
Oops message.

-aneesh

------=_Part_60_1129377.1091277419620
Content-Type: text/x-patch; name="traps.c.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="traps.c.diff"

--- traps.c=092004-07-31 18:02:39.000000000 +0530
+++ /tmp/traps.c=092004-07-31 18:04:19.000000000 +0530
@@ -63,10 +63,12 @@
 void
 dik_show_regs(struct pt_regs *regs, unsigned long *r9_15)
 {
 =09printk("pc =3D [<%016lx>]  ra =3D [<%016lx>]  ps =3D %04lx    %s\n",
 =09       regs->pc, regs->r26, regs->ps, print_tainted());
+=09print_symbol("pc is at %s\n", regs->pc);
+=09print_symbol("ra is at %s\n", regs->r26 );
 =09printk("v0 =3D %016lx  t0 =3D %016lx  t1 =3D %016lx\n",
 =09       regs->r0, regs->r1, regs->r2);
 =09printk("t2 =3D %016lx  t3 =3D %016lx  t4 =3D %016lx\n",
  =09       regs->r3, regs->r4, regs->r5);
 =09printk("t5 =3D %016lx  t6 =3D %016lx  t7 =3D %016lx\n",

------=_Part_60_1129377.1091277419620--
