Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262495AbVAJUDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262495AbVAJUDJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbVAJUAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:00:10 -0500
Received: from mail.tyan.com ([66.122.195.4]:21769 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S262511AbVAJT6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 14:58:20 -0500
Message-ID: <3174569B9743D511922F00A0C9431423072913A4@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>
Cc: "'Mikael Pettersson'" <mikpe@csd.uu.se>, jamesclv@us.ibm.com,
       Matt_Domsch@dell.com, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com
Subject: RE: 256 apic id for amd64
Date: Mon, 10 Jan 2005 12:09:48 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C4F750.561AD560"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C4F750.561AD560
Content-Type: text/plain

Try this one.

-----Original Message-----
From: Andi Kleen [mailto:ak@muc.de] 
Sent: Monday, January 10, 2005 11:44 AM
To: YhLu
Cc: 'Mikael Pettersson'; jamesclv@us.ibm.com; Matt_Domsch@dell.com;
discuss@x86-64.org; linux-kernel@vger.kernel.org; suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64

On Mon, Jan 10, 2005 at 11:41:02AM -0800, YhLu wrote:
> Please refer the patch.

That's unreadable. Can you generate against a recent BK snapshot
(2.6.10 + latest from ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/)

and use diff -u  ? 

-Andi


------_=_NextPart_000_01C4F750.561AD560
Content-Type: application/octet-stream;
	name="x86_64_phy_proc_id.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="x86_64_phy_proc_id.patch"

--- linux-2.6.10/arch/x86_64/kernel/setup.c	2005-01-10 =
12:26:21.414190368 -0800=0A=
+++ linux-2.6.10.new.x86_64/arch/x86_64/kernel/setup.c	2005-01-10 =
12:30:53.656803200 -0800=0A=
@@ -738,7 +738,6 @@=0A=
 {=0A=
 #ifdef CONFIG_SMP=0A=
 	u32 	eax, ebx, ecx, edx;=0A=
-	int 	index_lsb, index_msb, tmp;=0A=
 	int 	cpu =3D smp_processor_id();=0A=
 	=0A=
 	if (!cpu_has(c, X86_FEATURE_HT))=0A=
@@ -750,8 +749,6 @@=0A=
 	if (smp_num_siblings =3D=3D 1) {=0A=
 		printk(KERN_INFO  "CPU: Hyper-Threading is disabled\n");=0A=
 	} else if (smp_num_siblings > 1) {=0A=
-		index_lsb =3D 0;=0A=
-		index_msb =3D 31;=0A=
 		/*=0A=
 		 * At this point we only support two siblings per=0A=
 		 * processor package.=0A=
@@ -761,19 +758,8 @@=0A=
 			smp_num_siblings =3D 1;=0A=
 			return;=0A=
 		}=0A=
-		tmp =3D smp_num_siblings;=0A=
-		while ((tmp & 1) =3D=3D 0) {=0A=
-			tmp >>=3D1 ;=0A=
-			index_lsb++;=0A=
-		}=0A=
-		tmp =3D smp_num_siblings;=0A=
-		while ((tmp & 0x80000000 ) =3D=3D 0) {=0A=
-			tmp <<=3D1 ;=0A=
-			index_msb--;=0A=
-		}=0A=
-		if (index_lsb !=3D index_msb )=0A=
-			index_msb++;=0A=
-		phys_proc_id[cpu] =3D phys_pkg_id(index_msb);=0A=
+=0A=
+		phys_proc_id[cpu] =3D c->x86_apicid >> hweight32(c->x86_num_cores - =
1);=0A=
 		=0A=
 		printk(KERN_INFO  "CPU: Physical Processor ID: %d\n",=0A=
 		       phys_proc_id[cpu]);=0A=

------_=_NextPart_000_01C4F750.561AD560--
