Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbULAXnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbULAXnB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 18:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbULAXmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 18:42:51 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:55690 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261502AbULAXlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 18:41:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=kJQ5QIIATQRBudSSlFEq2FaKZ2d4EYb7/OwGrAljFfEERAULNtOPlI2ZVWimYkHfhHqvxAfW5yDbVHmhlUy9LB+nKCqZXu8KhYv9wiSzIRDQurf629Kf9C2qwZ5CvL3OK4um631h43dzPUGKHkDEWf+m8qVYe5ZhzvZY0S++fY4=
Message-ID: <aec7e5c304120115415153f706@mail.gmail.com>
Date: Thu, 2 Dec 2004 00:41:22 +0100
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] documentation - mem=
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_666_29074319.1101944482054"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_666_29074319.1101944482054
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

I recently learnt that limiting RAM with by using only "mem=xxxM" is
no good on machines equipped with PCI. In my case (vanilla 2.6.9) the
cardbus bridge on my laptop got mapped to the unused RAM area which
resulted in wierd errors due to the collision.

The right solution is to use "mem=" together with "memmap=" to mark
the unused RAM area reserved.

>From now on I force the kernel to use 2016MiB by passing "mem=2016M
memmap=32M#2016M" instead of just "mem=2016M".

Anyway, this patch tried to document the behaviour. Please comment or apply.

Thanks!

/ magnus

------=_Part_666_29074319.1101944482054
Content-Type: text/x-patch; name="linux-2.6.10-rc2-mm4-mem_hints.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="linux-2.6.10-rc2-mm4-mem_hints.patch"

diff -urN linux-2.6.10-rc2-mm4/Documentation/kernel-parameters.txt linux-2.=
6.10-rc2-mm4-mem_hints/Documentation/kernel-parameters.txt
--- linux-2.6.10-rc2-mm4/Documentation/kernel-parameters.txt=092004-12-01 2=
3:50:53.125191440 +0100
+++ linux-2.6.10-rc2-mm4-mem_hints/Documentation/kernel-parameters.txt=0920=
04-12-02 00:14:39.465354776 +0100
@@ -704,6 +704,9 @@
 =09mem=3Dnn[KMG]=09[KNL,BOOT] Force usage of a specific amount of memory
 =09=09=09Amount of memory to be used when the kernel is not able
 =09=09=09to see the whole system memory or for test.
+=09=09=09[IA-32] Use together with memmap=3D to avoid physical
+=09=09=09address space collisions. Without memmap=3D PCI devices
+=09=09=09could be placed at addresses belonging to unused RAM.
=20
 =09mem=3Dnopentium=09[BUGS=3DIA-32] Disable usage of 4MB pages for kernel
 =09=09=09memory.
diff -urN linux-2.6.10-rc2-mm4/Documentation/memory.txt linux-2.6.10-rc2-mm=
4-mem_hints/Documentation/memory.txt
--- linux-2.6.10-rc2-mm4/Documentation/memory.txt=092004-10-18 23:55:36.000=
000000 +0200
+++ linux-2.6.10-rc2-mm4-mem_hints/Documentation/memory.txt=092004-12-02 00=
:03:01.712429344 +0100
@@ -21,6 +21,8 @@
 All of these problems can be addressed with the "mem=3DXXXM" boot option
 (where XXX is the size of RAM to use in megabytes). =20
 It can also tell Linux to use less memory than is actually installed.
+If you use "mem=3D" on a machine with PCI, consider using "memmap=3D" to a=
void
+physical address space collisions.
=20
 See the documentation of your boot loader (LILO, loadlin, etc.) about
 how to pass options to the kernel.
@@ -44,7 +46,9 @@
 =09* Disabling the cache from the BIOS.
=20
 =09* Try passing the "mem=3D4M" option to the kernel to limit
-=09  Linux to using a very small amount of memory.
+=09  Linux to using a very small amount of memory. Use "memmap=3D"-option
+=09  together with "mem=3D" on systems with PCI to avoid physical address
+=09  space collisions.
=20
=20
 Other tricks:

------=_Part_666_29074319.1101944482054--
