Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269527AbUJLIuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269527AbUJLIuR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 04:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269536AbUJLIuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 04:50:16 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:25476 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269527AbUJLIsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 04:48:52 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1 OOPs on AMD64
Date: Tue, 12 Oct 2004 10:50:13 +0200
User-Agent: KMail/1.6.2
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
References: <1097527401.12861.383.camel@dyn318077bld.beaverton.ibm.com> <20041011153830.495b7c2d.akpm@osdl.org> <1097536210.12861.402.camel@dyn318077bld.beaverton.ibm.com>
In-Reply-To: <1097536210.12861.402.camel@dyn318077bld.beaverton.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Fr5aBMQMzL+yYYK"
Message-Id: <200410121050.13688.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Fr5aBMQMzL+yYYK
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 12 of October 2004 01:10, Badari Pulavarty wrote:
> On Mon, 2004-10-11 at 15:38, Andrew Morton wrote:
> > Andi Kleen <ak@suse.de> wrote:
> > >
> > > > Console: colour VGA+ 80x25
> > > > Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
> > > > Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
> > > > Bad page state at free_hot_cold_page (in process 'swapper', page
> > > > 000001017ac06070)
> > > > flags:0x00000000 mapping:0000000000000000 mapcount:1 count:0
> > > 
> > > Some memory corruption or confused memory allocator.
> > 
> > I'd be suspecting no-buddy-bitmap-patch-*.patch
> > 
> 
> Nope. This is not it..
> 
> Andi, do you know which is the last good -mm kernel on AMD ?
> Is it 2.6.9-rc3-mm3 ? The last I tested on AMD was 2.6.9-rc2-mm3 :(

I've been running 2.6.9-rc3-mm3 on AMD64 for quite some time without much 
problems, except that X apparently gets killed from time to time (this is not 
reproducible).  However, I had to reverse the 
optimize-profile-path-slightly.patch (attached) and I applied a couple of 
other patches (attached too).

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--Boundary-00=_Fr5aBMQMzL+yYYK
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="2.6.9-rc3-mm3-Kconfig~hpet-dependency-fix.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="2.6.9-rc3-mm3-Kconfig~hpet-dependency-fix.patch"

=46rom akpm@osdl.org Thu Oct  7 23:40:45 2004
Return-Path: <linux-kernel-owner+rjwysocki=3D40sisk.pl-S268236AbUJGVky@vger=
=2Ekernel.org>
Delivered-To: rafael@grendel.digitalservice.pl
Received: (qmail 27817 invoked from network); 8 Oct 2004 02:19:04 -0000
Received: from localhost (?aP3k60+qaf6+JSF3i6QxSh+NouiH61rg?@127.0.0.1)
  by localhost with SMTP; 8 Oct 2004 02:19:04 -0000
Received: from mail.digitalservice.pl ([127.0.0.1])
 by localhost (grendel [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 27682-04 for <rafael@grendel.digitalservice.pl>;
 Fri,  8 Oct 2004 04:18:59 +0200 (CEST)
Received: (qmail 27810 invoked by uid 529); 8 Oct 2004 02:18:59 -0000
Delivered-To: sisk-rjwysocki@sisk.pl
Received: (qmail 27807 invoked from network); 8 Oct 2004 02:18:59 -0000
Received: from vger.kernel.org (12.107.209.244)
  by grendel.digitalservice.pl with SMTP; 8 Oct 2004 02:18:59 -0000
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268236AbUJGVky (ORCPT <rfc822;rjwysocki@sisk.pl>);
	Thu, 7 Oct 2004 17:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267890AbUJGViE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:38:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:28811 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268229AbUJGVhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:37:01 -0400
Received: from akpm.pao.digeo.com (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id i97Lamf32753;
	Thu, 7 Oct 2004 14:36:48 -0700
Date:	Thu, 7 Oct 2004 14:40:45 -0700
=46rom:	Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ak@suse.de,
 linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm3: build problem on dual-Opteron w/ NUMA
Message-Id: <20041007144045.29e64ef0.akpm@osdl.org>
In-Reply-To: <200410072301.39399.rjw@sisk.pl>
References: <20041007015139.6f5b833b.akpm@osdl.org>
	<200410072301.39399.rjw@sisk.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain;
  charset=3DUS-ASCII
Content-Transfer-Encoding: 7bit
Sender:	linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-kernel@vger.kernel.org
X-Virus-Scanned: by amavisd-new at grendel.digitalservice.pl using MkS_Vir =
for Linux (beta)
Status: RO
X-Status: R
X-KMail-EncryptionState: N
X-KMail-SignatureState: N
X-KMail-MDN-Sent: =20

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> On Thursday 07 of October 2004 10:51, Andrew Morton
> >=20
> >=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2=
=2E6.9-rc3-mm3/
>=20
> It does not build on a dual-Opteron box w/ NUMA:
>=20
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/x86_64/kernel/built-in.o(.init.text+0x1fc1): In function=20
> `late_hpet_init':
> : undefined reference to `hpet_alloc'
> make: *** [.tmp_vmlinux1] Error 1
>=20
> The .config is available at:
> http://www.sisk.pl/kernel/041007/2.6.9-rc3-mm3-NUMA.config

akpm:/home/akpm> grep HPET 2.6.9-rc3-mm3-NUMA.config
CONFIG_HPET_TIMER=3Dy
CONFIG_HPET_EMULATE_RTC=3Dy
# CONFIG_HPET is not set

I'll take a punt and assume that CONFIG_HPET_TIMER requires CONFIG_HPET.


diff -puN arch/x86_64/Kconfig~hpet-dependency-fix arch/x86_64/Kconfig
=2D-- 25/arch/x86_64/Kconfig~hpet-dependency-fix	Thu Oct  7 14:38:35 2004
+++ 25-akpm/arch/x86_64/Kconfig	Thu Oct  7 14:38:50 2004
@@ -60,6 +60,7 @@ config EARLY_PRINTK
=20
 config HPET_TIMER
 	bool
+	depends on HPET
 	default y
 	help
 	  Use the IA-PC HPET (High Precision Event Timer) to manage
diff -puN arch/i386/Kconfig~hpet-dependency-fix arch/i386/Kconfig
=2D-- 25/arch/i386/Kconfig~hpet-dependency-fix	Thu Oct  7 14:39:03 2004
+++ 25-akpm/arch/i386/Kconfig	Thu Oct  7 14:39:13 2004
@@ -429,6 +429,7 @@ config X86_OOSTORE
=20
 config HPET_TIMER
 	bool "HPET Timer Support"
+	depends on HPET
 	help
 	  This enables the use of the HPET for the kernel's internal timer.
 	  HPET is the next generation timer replacing legacy 8254s.
_

=2D
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



--Boundary-00=_Fr5aBMQMzL+yYYK
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="2.6.9-rc3-mm3-prof_cpu_mask-fix.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="2.6.9-rc3-mm3-prof_cpu_mask-fix.patch"

=46rom akpm@osdl.org Fri Oct  8 00:07:08 2004
Return-Path: <linux-kernel-owner+rjwysocki=3D40sisk.pl-S269822AbUJGWGU@vger=
=2Ekernel.org>
Delivered-To: rafael@grendel.digitalservice.pl
Received: (qmail 27028 invoked from network); 8 Oct 2004 01:54:04 -0000
Received: from localhost (?5asyZye8j+GX7oIq3vqJD07cTouNrac3?@127.0.0.1)
  by localhost with SMTP; 8 Oct 2004 01:54:04 -0000
Received: from mail.digitalservice.pl ([127.0.0.1])
 by localhost (grendel [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 26840-04 for <rafael@grendel.digitalservice.pl>;
 Fri,  8 Oct 2004 03:53:58 +0200 (CEST)
Received: (qmail 27007 invoked by uid 529); 8 Oct 2004 01:53:58 -0000
Delivered-To: sisk-rjwysocki@sisk.pl
Received: (qmail 27004 invoked from network); 8 Oct 2004 01:53:57 -0000
Received: from vger.kernel.org (12.107.209.244)
  by grendel.digitalservice.pl with SMTP; 8 Oct 2004 01:53:58 -0000
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269822AbUJGWGU (ORCPT <rfc822;rjwysocki@sisk.pl>);
	Thu, 7 Oct 2004 18:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269772AbUJGWES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:04:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:6815 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269356AbUJGWDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:03:21 -0400
Received: from akpm.pao.digeo.com (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id i97M3Cf05562;
	Thu, 7 Oct 2004 15:03:12 -0700
Date:	Thu, 7 Oct 2004 15:07:08 -0700
=46rom:	Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org,
 wli@holomorphy.com,
 Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.9-rc3-mm3
Message-Id: <20041007150708.5d60e1c3.akpm@osdl.org>
In-Reply-To: <1097185597l.10532l.1l@werewolf.able.es>
References: <20041007015139.6f5b833b.akpm@osdl.org>
	<200410071041.20723.sandersn@btinternet.com>
	<20041007025007.77ec1a44.akpm@osdl.org>
	<20041007114040.GV9106@holomorphy.com>
	<1097184341l.10532l.0l@werewolf.able.es>
	<1097185597l.10532l.1l@werewolf.able.es>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain;
  charset=3DUS-ASCII
Content-Transfer-Encoding: 7bit
Sender:	linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-kernel@vger.kernel.org
X-Virus-Scanned: by amavisd-new at grendel.digitalservice.pl using MkS_Vir =
for Linux (beta)
Status: RO
X-Status: R
X-KMail-EncryptionState: =20
X-KMail-SignatureState: =20
X-KMail-MDN-Sent: =20

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> On 2004.10.07, J.A. Magallon wrote:
> >=20
> > This conflicts with kernel/irq/proc.c:
> >=20
> > 	unsigned long prof_cpu_mask =3D -1;
> >=20
> > Shouldn't this be:
> >=20
> > 	cpumask_t prof_cpu_mask =3D CPU_MASK_NONE;
> >=20
> > This will show problems when NR_CPUS > sizeof(long)....
> >=20
>=20
> Err....
>=20
> There is a problem with this -mm:

Yes, there seems to be a mingo/wli bunfight over prof_cpu_mask.

Something like this, I think:

=2D-- 25/kernel/irq/proc.c~prof-irq-mask-fixup	Thu Oct  7 15:04:14 2004
+++ 25-akpm/kernel/irq/proc.c	Thu Oct  7 15:05:30 2004
@@ -10,8 +10,6 @@
 #include <linux/proc_fs.h>
 #include <linux/interrupt.h>
=20
=2Dunsigned long prof_cpu_mask =3D -1;
=2D
 static struct proc_dir_entry *root_irq_dir, *irq_dir[NR_IRQS];
=20
 #ifdef CONFIG_SMP
@@ -65,34 +63,6 @@ static int irq_affinity_write_proc(struc
=20
 #endif
=20
=2Dstatic int prof_cpu_mask_read_proc(char *page, char **start, off_t off,
=2D				   int count, int *eof, void *data)
=2D{
=2D	int len =3D cpumask_scnprintf(page, count, *(cpumask_t *)data);
=2D
=2D	if (count - len < 2)
=2D		return -EINVAL;
=2D	len +=3D sprintf(page + len, "\n");
=2D	return len;
=2D}
=2D
=2Dstatic int prof_cpu_mask_write_proc(struct file *file,
=2D				    const char __user *buffer,
=2D				    unsigned long count, void *data)
=2D{
=2D	unsigned long full_count =3D count, err;
=2D	cpumask_t *mask =3D (cpumask_t *)data;
=2D	cpumask_t new_value;
=2D
=2D	err =3D cpumask_parse(buffer, count, new_value);
=2D	if (err)
=2D		return err;
=2D
=2D	*mask =3D new_value;
=2D
=2D	return full_count;
=2D}
=2D
 #define MAX_NAMELEN 128
=20
 void register_handler_proc(unsigned int irq, struct irqaction *action)
@@ -156,7 +126,6 @@ void unregister_handler_proc(unsigned in
=20
 void init_irq_proc(void)
 {
=2D	struct proc_dir_entry *entry;
 	int i;
=20
 	/* create /proc/irq */
@@ -164,16 +133,6 @@ void init_irq_proc(void)
 	if (!root_irq_dir)
 		return;
=20
=2D	/* create /proc/irq/prof_cpu_mask */
=2D	entry =3D create_proc_entry("prof_cpu_mask", 0600, root_irq_dir);
=2D	if (!entry)
=2D		return;
=2D
=2D	entry->nlink =3D 1;
=2D	entry->data =3D (void *)&prof_cpu_mask;
=2D	entry->read_proc =3D prof_cpu_mask_read_proc;
=2D	entry->write_proc =3D prof_cpu_mask_write_proc;
=2D
 	/*
 	 * Create entries for all existing IRQs.
 	 */
_

=2D
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



--Boundary-00=_Fr5aBMQMzL+yYYK
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="2.6.9-rc3-mm3-radeonfb-fix-warnings-about-uninitialized-variables-fix.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="2.6.9-rc3-mm3-radeonfb-fix-warnings-about-uninitialized-variables-fix.patch"

=46rom akpm@osdl.org Thu Oct  7 23:33:59 2004
Return-Path: <linux-kernel-owner+rjwysocki=3D40sisk.pl-S268079AbUJGVk4@vger=
=2Ekernel.org>
Delivered-To: rafael@grendel.digitalservice.pl
Received: (qmail 23775 invoked from network); 7 Oct 2004 21:48:48 -0000
Received: from localhost (?ebeyngtX+rDJog4oMS/oMfUR0ytakoI+?@127.0.0.1)
  by localhost with SMTP; 7 Oct 2004 21:48:48 -0000
Received: from mail.digitalservice.pl ([127.0.0.1])
 by localhost (grendel [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 23676-03 for <rafael@grendel.digitalservice.pl>;
 Thu,  7 Oct 2004 23:48:43 +0200 (CEST)
Received: (qmail 23768 invoked by uid 529); 7 Oct 2004 21:48:43 -0000
Delivered-To: sisk-rjwysocki@sisk.pl
Received: (qmail 23765 invoked from network); 7 Oct 2004 21:48:43 -0000
Received: from vger.kernel.org (12.107.209.244)
  by grendel.digitalservice.pl with SMTP; 7 Oct 2004 21:48:43 -0000
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268079AbUJGVk4 (ORCPT <rfc822;rjwysocki@sisk.pl>);
	Thu, 7 Oct 2004 17:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268080AbUJGVio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:38:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:11143 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269830AbUJGVaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:30:22 -0400
Received: from akpm.pao.digeo.com (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id i97LU3f30821;
	Thu, 7 Oct 2004 14:30:04 -0700
Date:	Thu, 7 Oct 2004 14:33:59 -0700
=46rom:	Andrew Morton <akpm@osdl.org>
To: jschopp@austin.ibm.com
Cc: linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.9-rc3-mm3
Message-Id: <20041007143359.6f11a398.akpm@osdl.org>
In-Reply-To: <4165AD8B.9020207@austin.ibm.com>
References: <20041007015139.6f5b833b.akpm@osdl.org>
	<4165AD8B.9020207@austin.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain;
  charset=3DUS-ASCII
Content-Transfer-Encoding: 7bit
Sender:	linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-kernel@vger.kernel.org
X-Virus-Scanned: by amavisd-new at grendel.digitalservice.pl using MkS_Vir =
for Linux (beta)
Status: RO
X-Status: R
X-KMail-EncryptionState: =20
X-KMail-SignatureState: =20
X-KMail-MDN-Sent: =20

Joel Schopp <jschopp@austin.ibm.com> wrote:
>
> ppc64 defconfig doesn't compile for me.
>=20
> drivers/video/aty/radeon_monitor.c: In function `radeon_parse_montype_pro=
p':
> drivers/video/aty/radeon_monitor.c:77: error: parse error before "else"

=2D-- 25/drivers/video/aty/radeon_monitor.c~radeonfb-fix-warnings-about-uni=
nitialized-variables-fix	Thu Oct  7 14:32:40 2004
+++ 25-akpm/drivers/video/aty/radeon_monitor.c	Thu Oct  7 14:32:59 2004
@@ -74,8 +74,7 @@ static int __devinit radeon_parse_montyp
 			printk(KERN_WARNING "radeonfb: Unknown OF display-type: %s\n",
 			       pmt);
 		return MT_NONE;
=2D	} else
=2D		return MT_NONE;
+	}
=20
 	for (i =3D 0; propnames[i] !=3D NULL; ++i) {
 		pedid =3D (u8 *)get_property(dp, propnames[i], NULL);
_

=2D
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



--Boundary-00=_Fr5aBMQMzL+yYYK
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="vm-fix-empty-zones.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="vm-fix-empty-zones.patch"



Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>


---

 linux-2.6-npiggin/mm/vmscan.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff -puN mm/vmscan.c~vm-fix-empty-zones mm/vmscan.c
--- linux-2.6/mm/vmscan.c~vm-fix-empty-zones	2004-10-08 12:44:14.000000000 +1000
+++ linux-2.6-npiggin/mm/vmscan.c	2004-10-08 14:28:04.000000000 +1000
@@ -851,6 +851,9 @@ shrink_caches(struct zone **zones, struc
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *zone = zones[i];
 
+		if (zone->present_pages == 0)
+			continue;
+
 		zone->temp_priority = sc->priority;
 		if (zone->prev_priority > sc->priority)
 			zone->prev_priority = sc->priority;
@@ -1003,7 +1006,7 @@ static int balance_pgdat(pg_data_t *pgda
 						priority != DEF_PRIORITY)
 					continue;
 
-				if (zone->free_pages <= zone->pages_high) {
+				if (zone->free_pages < zone->pages_high) {
 					end_zone = i;
 					goto scan;
 				}
@@ -1035,7 +1038,7 @@ scan:
 				continue;
 
 			if (nr_pages == 0) {	/* Not software suspend */
-				if (zone->free_pages <= zone->pages_high)
+				if (zone->free_pages < zone->pages_high)
 					all_zones_ok = 0;
 			}
 			zone->temp_priority = priority;
@@ -1142,7 +1145,7 @@ static int kswapd(void *p)
  */
 void wakeup_kswapd(struct zone *zone)
 {
-	if (zone->free_pages > zone->pages_low)
+	if (zone->free_pages >= zone->pages_low)
 		return;
 	if (!waitqueue_active(&zone->zone_pgdat->kswapd_wait))
 		return;

_

--Boundary-00=_Fr5aBMQMzL+yYYK
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="optimize-profile-path-slightly.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="optimize-profile-path-slightly.patch"


From: Andi Kleen <ak@muc.de>

Check first before calling profile_pc() and doing other complicated checks
if profiling is enabled.  This saves a few cycles in the profile tick and
protects the average user against potential bugs in profile_pc.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/kernel/profile.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN kernel/profile.c~optimize-profile-path-slightly kernel/profile.c
--- 25/kernel/profile.c~optimize-profile-path-slightly	Tue Oct  5 16:15:07 2004
+++ 25-akpm/kernel/profile.c	Tue Oct  5 16:15:07 2004
@@ -381,12 +381,10 @@ static int __devinit profile_cpu_callbac
 #define profile_flip_buffers()		do { } while (0)
 #define profile_discard_flip_buffers()	do { } while (0)
 
-void profile_hit(int type, void *__pc)
+inline void profile_hit(int type, void *__pc)
 {
 	unsigned long pc;
 
-	if (prof_on != type || !prof_buffer)
-		return;
 	pc = ((unsigned long)__pc - (unsigned long)_stext) >> prof_shift;
 	atomic_inc(&prof_buffer[min(pc, prof_len - 1)]);
 }
@@ -396,6 +394,8 @@ void profile_tick(int type, struct pt_re
 {
 	if (type == CPU_PROFILING)
 		profile_hook(regs);
+	if (prof_on != type || !prof_buffer)
+		return;
 	if (!user_mode(regs) && cpu_isset(smp_processor_id(), prof_cpu_mask))
 		profile_hit(type, (void *)profile_pc(regs));
 }
_

--Boundary-00=_Fr5aBMQMzL+yYYK--
