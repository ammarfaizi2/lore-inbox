Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262650AbVCJPG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbVCJPG2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 10:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbVCJPG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 10:06:28 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:2486 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262650AbVCJPGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 10:06:19 -0500
Subject: [patch 1/1] SELinux AVC audit log ipaddr field support (for
	task_struct->curr_ip)
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: selinux@tycho.nsa.gov
X-IMP: AR MAPS ORDB: 0.00,AR AHBL: 0.00,AR CBL: 0.00,AR SBL: 0.00,AR SORBS:
	0.00,AR SPAMCOP: 0.00,AR XBL: 0.00,AV NONE,CLOUDMARK: 0.00
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-e87FcoiNfDlRfWmDqNvP"
Date: Thu, 10 Mar 2005 16:05:40 +0100
Message-Id: <1110467140.9190.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.6 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-e87FcoiNfDlRfWmDqNvP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Provides support for a new field ipaddr within the SELinux
AVC audit log, relying in task_struct->curr_ip (ipv4 only)
provided by the task-curr_ip or grSecurity patch to be applied
before.It was first implemented by Joshua Brindle (a.k.a Method)
from the Hardened Gentoo project.

An example of the audit messages with ipaddr field:
audit(1110432234.161:0): avc:  denied  { search } for  pid=3D19057
exe=3D/usr/bin/wget name=3Dportage dev=3Dhda3 ino=3D1024647 ipaddr=3D192.16=
8.1.30
scontext=3Droot:sysadm_r:portage_fetch_t tcontext=3Dsystem_u:object_r:porta=
ge_tmp_t tclass=3Ddir

It's also available at http://pearls.tuxedo-es.org/patches/selinux-avc_audi=
t-log-curr_ip.patch

Signed-off-by: Lorenzo Hernandez Garcia-Hierro <lorenzo@gnu.org>
---

 linux-2.6.11-lorenzo/security/selinux/avc.c |    6 ++++++
 1 files changed, 6 insertions(+)

diff -puN security/selinux/avc.c~selinux-avc_audit-log-curr_ip security/sel=
inux/avc.c
--- linux-2.6.11/security/selinux/avc.c~selinux-avc_audit-log-curr_ip	2005-=
03-10 15:52:12.810227040 +0100
+++ linux-2.6.11-lorenzo/security/selinux/avc.c	2005-03-10 15:52:12.8172259=
76 +0100
@@ -205,6 +205,12 @@ void avc_dump_query(struct audit_buffer=20
 	char *scontext;
 	u32 scontext_len;
=20
+/* CONFIG_GRKERNSEC_PROC_IPADDR if grSecurity is present */
+#ifdef CONFIG_PROC_IPADDR
+	if (current->curr_ip)
+		audit_log_format(ab, "ipaddr=3D%u.%u.%u.%u ", NIPQUAD(current->curr_ip))=
;
+#endif /* CONFIG_PROC_IPADDR */
+
  	rc =3D security_sid_to_context(ssid, &scontext, &scontext_len);
 	if (rc)
 		audit_log_format(ab, "ssid=3D%d", ssid);
_
Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-e87FcoiNfDlRfWmDqNvP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCMGJEDcEopW8rLewRAuraAKDA923lf9w29aUpcVvB1TsByQfkjgCdFRpM
mfmsP1HDaB/cP14huN8d3fc=
=C5b3
-----END PGP SIGNATURE-----

--=-e87FcoiNfDlRfWmDqNvP--

