Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262463AbVAJUL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbVAJUL2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbVAJTrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 14:47:07 -0500
Received: from mail.tyan.com ([66.122.195.4]:12549 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S262458AbVAJT3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 14:29:33 -0500
Message-ID: <3174569B9743D511922F00A0C94314230729139F@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>
Cc: "'Mikael Pettersson'" <mikpe@csd.uu.se>, jamesclv@us.ibm.com,
       Matt_Domsch@dell.com, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com
Subject: RE: 256 apic id for amd64
Date: Mon, 10 Jan 2005 11:41:02 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C4F74C.513CF0E0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C4F74C.513CF0E0
Content-Type: text/plain

Please refer the patch.

Regards

YH


------_=_NextPart_000_01C4F74C.513CF0E0
Content-Type: application/octet-stream;
	name="x86_64_phy_proc_id.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="x86_64_phy_proc_id.patch"

664a665=0A=
> 	unsigned int n;=0A=
687c688,690=0A=
< 	if (c->cpuid_level >=3D 0x80000008) {=0A=
---=0A=
> 	n =3D cpuid_eax(0x80000000);=0A=
> =0A=
> 	if (n >=3D 0x80000008) {=0A=
698c701=0A=
< 			int cpu =3D c->x86_apicid;=0A=
---=0A=
> 			int cpu =3D c->x86_apicid; // that is initial apicid=0A=
725,749c728,730=0A=
< 		index_lsb =3D 0;=0A=
< 		index_msb =3D 31;=0A=
< 		/*=0A=
< 		 * At this point we only support two siblings per=0A=
< 		 * processor package.=0A=
< 		 */=0A=
< 		if (smp_num_siblings > NR_CPUS) {=0A=
< 			printk(KERN_WARNING "CPU: Unsupported number of the siblings %d", =
smp_num_siblings);=0A=
< 			smp_num_siblings =3D 1;=0A=
< 			return;=0A=
< 		}=0A=
< 		tmp =3D smp_num_siblings;=0A=
< 		while ((tmp & 1) =3D=3D 0) {=0A=
< 			tmp >>=3D1 ;=0A=
< 			index_lsb++;=0A=
< 		}=0A=
< 		tmp =3D smp_num_siblings;=0A=
< 		while ((tmp & 0x80000000 ) =3D=3D 0) {=0A=
< 			tmp <<=3D1 ;=0A=
< 			index_msb--;=0A=
< 		}=0A=
< 		if (index_lsb !=3D index_msb )=0A=
< 			index_msb++;=0A=
< 		phys_proc_id[cpu] =3D phys_pkg_id(index_msb);=0A=
< 		=0A=
---=0A=
> =0A=
> 		phys_proc_id[cpu] =3D  c->x86_apicid >> hweight32(c->x86_num_cores =
- 1);=0A=
> =0A=
1067c1048=0A=
< 		seq_printf(m, "cpu cores\t: %d\n", c->x86_num_cores);=0A=
---=0A=
> 		seq_printf(m, "\ncpu cores\t: %d\n", c->x86_num_cores);=0A=

------_=_NextPart_000_01C4F74C.513CF0E0--
