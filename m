Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267698AbTASWDM>; Sun, 19 Jan 2003 17:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267699AbTASWDM>; Sun, 19 Jan 2003 17:03:12 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:56047 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S267698AbTASWDL>; Sun, 19 Jan 2003 17:03:11 -0500
Subject: Re: 2.4.21pre3 smp_affinity, very strange
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Hans Lambrechts <hans.lambrechts@skynet.be>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200301191645.03034.hans.lambrechts@skynet.be>
References: <200301191645.03034.hans.lambrechts@skynet.be>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8RR6t+WDlIPggTAC2xiR"
Organization: Red Hat, Inc.
Message-Id: <1043002445.1479.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 19 Jan 2003 19:54:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8RR6t+WDlIPggTAC2xiR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Did the APIC or mpparse changes cause this?
+#ifdef CONFIG_X86_CLUSTERED_APIC
+static inline int target_cpus(void)
+{
+       static int cpu;
+       switch(clustered_apic_mode){
+               case CLUSTERED_APIC_NUMAQ:
+                       /* Broadcast intrs to local quad only. */
+                       return APIC_BROADCAST_ID_APIC;
+               case CLUSTERED_APIC_XAPIC:
+                       /*round robin the interrupts*/
+                       cpu =3D (cpu+1)%smp_num_cpus;
+                       return cpu_to_physical_apicid(cpu);
+               default:
+       }
+       return cpu_online_map;
+}
+#else
+#define target_cpus() (0x01)
+#endif
(2.4.21-pre3)
that's wrong.....  0x01 -> 0xFF and it should be fixed
=20

--=-8RR6t+WDlIPggTAC2xiR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+KvRNxULwo51rQBIRAhmFAJ4x6Egb+voQeRTyfRLAuXW/739GxACdFcGI
hjVrTToOIGvRrd5E2ZzxnP0=
=Exws
-----END PGP SIGNATURE-----

--=-8RR6t+WDlIPggTAC2xiR--
