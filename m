Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263817AbTETRcV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 13:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263837AbTETRcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 13:32:21 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:11015 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263817AbTETRcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 13:32:20 -0400
Subject: [PATCH] do_fork fixes for voyager x86 subarch
From: James Bottomley <James.Bottomley@steeleye.com>
To: tovalds@transmeta.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-ZvomgKYsBDax72TCDYHS"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 20 May 2003 12:45:12 -0500
Message-Id: <1053452713.1860.75.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZvomgKYsBDax72TCDYHS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



It looks like the do_fork was converted in voyager_smp.c, but the
addition of wake_up_forked_process() was missed leading to a boot
panic.  The attached fixes it.

James


--=-ZvomgKYsBDax72TCDYHS
Content-Disposition: attachment; filename=tmp.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=tmp.diff; charset=ISO-8859-1

=3D=3D=3D=3D=3D arch/i386/mach-voyager/voyager_smp.c 1.13 vs edited =3D=3D=
=3D=3D=3D
--- 1.13/arch/i386/mach-voyager/voyager_smp.c	Sun May 18 19:00:00 2003
+++ edited/arch/i386/mach-voyager/voyager_smp.c	Tue May 20 10:13:39 2003
@@ -593,6 +593,8 @@
 	if(IS_ERR(idle))
 		panic("failed fork for CPU%d", cpu);
=20
+	wake_up_forked_process(idle);
+
 	init_idle(idle, cpu);
=20
 	idle->thread.eip =3D (unsigned long) start_secondary;

--=-ZvomgKYsBDax72TCDYHS--

