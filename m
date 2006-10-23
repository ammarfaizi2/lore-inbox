Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751929AbWJWLcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbWJWLcM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 07:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbWJWLcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 07:32:12 -0400
Received: from kagl.donpac.ru ([80.254.111.32]:53659 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S1751929AbWJWLcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 07:32:10 -0400
Date: Mon, 23 Oct 2006 15:32:07 +0400
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2: known unfixed regressions (v3)
Message-ID: <20061023113206.GB30706@pazke.donpac.ru>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org> <20061022122355.GC3502@stusta.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline
In-Reply-To: <20061022122355.GC3502@stusta.de>
X-Uname: Linux 2.6.18-1-amd64 x86_64
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eRtJSFbw+EEWtPj3
Content-Type: multipart/mixed; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 295, 10 22, 2006 at 02:23:55PM +0200, Adrian Bunk wrote:
> This email lists some known unfixed regressions in 2.6.19-rc2 compared=20
> to 2.6.18 that are not yet fixed Linus' tree.
>=20
> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you caused a breakage or I'm considering you in any other way possibly
> involved with one or more of these issues.
>=20
> Due to the huge amount of recipients, please trim the Cc when answering.
>=20
>
> Subject    : CONFIG_X86_VISWS=3Dy, CONFIG_SMP=3Dn compile error
> References : http://lkml.org/lkml/2006/10/7/51
> Submitter  : Jesper Juhl <jesper.juhl@gmail.com>
> Caused-By  : David Howells <dhowells@redhat.com>
>              commit 7d12e780e003f93433d49ce78cfedf4b4c52adc5
> Status     : unknown

Attached patch fixes this problem.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-fix-visws
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Andrey Panin <pazke@donpac.ru>

 arch/i386/mach-visws/visws_apic.c       |    7 +---
 include/asm-i386/mach-visws/do_timer.h  |   53 ---------------------------=
-----
 include/asm-i386/mach-visws/mach_apic.h |    5 +++
 3 files changed, 8 insertions(+), 57 deletions(-)

diff -urdpNX /usr/share/dontdiff linux-2.6.19-rc2.vanilla/arch/i386/mach-vi=
sws/visws_apic.c linux-2.6.19-rc2/arch/i386/mach-visws/visws_apic.c
--- linux-2.6.19-rc2.vanilla/arch/i386/mach-visws/visws_apic.c	2006-10-22 1=
4:32:13.000000000 +0400
+++ linux-2.6.19-rc2/arch/i386/mach-visws/visws_apic.c	2006-10-22 14:37:30.=
000000000 +0400
@@ -122,7 +122,7 @@ static void end_cobalt_irq(unsigned int=20
 	spin_unlock_irqrestore(&cobalt_lock, flags);
 }
=20
-static struct hw_interrupt_type cobalt_irq_type =3D {
+static struct irq_chip cobalt_irq_type =3D {
 	.typename =3D	"Cobalt-APIC",
 	.startup =3D	startup_cobalt_irq,
 	.shutdown =3D	disable_cobalt_irq,
@@ -159,7 +159,7 @@ static void end_piix4_master_irq(unsigne
 	spin_unlock_irqrestore(&cobalt_lock, flags);
 }
=20
-static struct hw_interrupt_type piix4_master_irq_type =3D {
+static struct irq_chip piix4_master_irq_type =3D {
 	.typename =3D	"PIIX4-master",
 	.startup =3D	startup_piix4_master_irq,
 	.ack =3D		ack_cobalt_irq,
@@ -167,9 +167,8 @@ static struct hw_interrupt_type piix4_ma
 };
=20
=20
-static struct hw_interrupt_type piix4_virtual_irq_type =3D {
+static struct irq_chip piix4_virtual_irq_type =3D {
 	.typename =3D	"PIIX4-virtual",
-	.startup =3D	startup_8259A_irq,
 	.shutdown =3D	disable_8259A_irq,
 	.enable =3D	enable_8259A_irq,
 	.disable =3D	disable_8259A_irq,
diff -urdpNX /usr/share/dontdiff linux-2.6.19-rc2.vanilla/include/asm-i386/=
mach-visws/do_timer.h linux-2.6.19-rc2/include/asm-i386/mach-visws/do_timer=
=2Eh
--- linux-2.6.19-rc2.vanilla/include/asm-i386/mach-visws/do_timer.h	2006-10=
-22 14:33:24.000000000 +0400
+++ linux-2.6.19-rc2/include/asm-i386/mach-visws/do_timer.h	1970-01-01 03:0=
0:00.000000000 +0300
@@ -1,53 +0,0 @@
-/* defines for inline arch setup functions */
-
-#include <asm/fixmap.h>
-#include <asm/i8259.h>
-#include "cobalt.h"
-
-static inline void do_timer_interrupt_hook(void)
-{
-	/* Clear the interrupt */
-	co_cpu_write(CO_CPU_STAT,co_cpu_read(CO_CPU_STAT) & ~CO_STAT_TIMEINTR);
-
-	do_timer(1);
-#ifndef CONFIG_SMP
-	update_process_times(user_mode_vm(irq_regs));
-#endif
-/*
- * In the SMP case we use the local APIC timer interrupt to do the
- * profiling, except when we simulate SMP mode on a uniprocessor
- * system, in that case we have to call the local interrupt handler.
- */
-#ifndef CONFIG_X86_LOCAL_APIC
-	profile_tick(CPU_PROFILING);
-#else
-	if (!using_apic_timer)
-		smp_local_timer_interrupt();
-#endif
-}
-
-static inline int do_timer_overflow(int count)
-{
-	int i;
-
-	spin_lock(&i8259A_lock);
-	/*
-	 * This is tricky when I/O APICs are used;
-	 * see do_timer_interrupt().
-	 */
-	i =3D inb(0x20);
-	spin_unlock(&i8259A_lock);
-=09
-	/* assumption about timer being IRQ0 */
-	if (i & 0x01) {
-		/*
-		 * We cannot detect lost timer interrupts ...=20
-		 * well, that's why we call them lost, don't we? :)
-		 * [hmm, on the Pentium and Alpha we can ... sort of]
-		 */
-		count -=3D LATCH;
-	} else {
-		printk("do_slow_gettimeoffset(): hardware timer problem?\n");
-	}
-	return count;
-}
diff -urdpNX /usr/share/dontdiff linux-2.6.19-rc2.vanilla/include/asm-i386/=
mach-visws/mach_apic.h linux-2.6.19-rc2/include/asm-i386/mach-visws/mach_ap=
ic.h
--- linux-2.6.19-rc2.vanilla/include/asm-i386/mach-visws/mach_apic.h	2006-0=
1-03 06:21:10.000000000 +0300
+++ linux-2.6.19-rc2/include/asm-i386/mach-visws/mach_apic.h	2006-10-22 14:=
16:53.000000000 +0400
@@ -51,6 +51,11 @@ static inline void clustered_apic_check(
 {
 }
=20
+static inline int apicid_to_node(int logical_apicid)
+{
+	return 0;
+}
+
 /* Mapping from cpu number to logical apicid */
 static inline int cpu_to_logical_apicid(int cpu)
 {

--GRPZ8SYKNexpdSJ7--

--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFPKg2PjHNUy6paxMRAn9cAKCWDsNVdBFi7/6okdES7fgntqWc5ACguc9Z
IeHH4J9uGG1FPSHxcdwLRXs=
=e4m7
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--
