Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267517AbUHJQin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267517AbUHJQin (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267511AbUHJQgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:36:40 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:28636 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S267556AbUHJQZE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:25:04 -0400
Date: Tue, 10 Aug 2004 10:16:30 -0500
From: Michael Halcrow <lkml@halcrow.us>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] BSD Secure Levels LSM (3/3)
Message-ID: <20040810151630.GC4993@halcrow.us>
Reply-To: Michael Halcrow <lkml@halcrow.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pyE8wggRBhVBcj8z"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pyE8wggRBhVBcj8z
Content-Type: multipart/mixed; boundary="maH1Gajj2nflutpK"
Content-Disposition: inline


--maH1Gajj2nflutpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch includes documentation for the BSD Secure Levels module.

Mike
=2E___________________________________________________________________.
                         Michael A. Halcrow                         =20
       Security Software Engineer, IBM Linux Technology Center      =20
GnuPG Fingerprint: 05B5 08A8 713A 64C1 D35D  2371 2D3C FDDA 3EB6 601D
--maH1Gajj2nflutpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="seclvl_doc_2.6.8-rc3.diff"

--- linux-2.6.8-rc3/Documentation/seclvl.txt	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.8-rc3_seclvl/Documentation/seclvl.txt	2004-08-10 09:53:55.000000000 -0500
@@ -0,0 +1,97 @@
+BSD Secure Levels Linux Security Module
+Michael A. Halcrow <mike@halcrow.us>
+
+
+Introduction
+
+Under the BSD Secure Levels security model, sets of policies are
+associated with levels. Levels range from -1 to 2, with -1 being the
+weakest and 2 being the strongest. These security policies are
+enforced at the kernel level, so not even the superuser is able to
+disable or circumvent them. This hardens the machine against attackers
+who gain root access to the system.
+
+
+Levels and Policies
+
+Level -1 (Permanently Insecure):
+ - Cannot increase the secure level
+
+Level 0 (Insecure):
+ - Cannot ptrace the init process
+
+Level 1 (Default):
+ - /dev/mem and /dev/kmem are read-only
+ - IMMUTABLE and APPEND extended attributes, if set, may not be unset
+ - Cannot load or unload kernel modules
+ - Cannot write directly to a mounted block device
+ - Cannot perform raw I/O operations
+ - Cannot perform network administrative tasks
+ - Cannot setuid any file
+
+Level 2 (Secure):
+ - Cannot decrement the system time
+ - Cannot write to any block device, whether mounted or not
+ - Cannot unmount any mounted filesystems
+
+
+Compilation
+
+To compile the BSD Secure Levels LSM, seclvl.ko, enable the
+SECURITY_SECLVL configuration option.  This is found under Security
+options -> BSD Secure Levels in the kernel configuration menu.
+
+
+Basic Usage
+
+Once the machine is in a running state, with all the necessary modules
+loaded and all the filesystems mounted, you can load the seclvl.ko
+module:
+
+# insmod seclvl.ko
+
+The module defaults to secure level 1, except when compiled directly
+into the kernel, in which case it defaults to secure level 0. To raise
+the secure level to 2, the administrator writes ``2'' to the
+seclvl/seclvl file under the sysfs mount point (assumed to be /sys in
+these examples):
+
+# echo -n "2" > /sys/seclvl/seclvl
+
+Alternatively, you can initialize the module at secure level 2 with
+the initlvl module parameter:
+
+# insmod seclvl.ko initlvl=2
+
+At this point, it is impossible to remove the module or reduce the
+secure level.  If the administrator wishes to have the option of doing
+so, he must provide a module parameter, sha1_passwd, that specifies
+the SHA1 hash of the password that can be used to reduce the secure
+level to 0.
+
+To generate this SHA1 hash, the administrator can use OpenSSL:
+
+# echo -n "boogabooga" | openssl sha1
+abeda4e0f33defa51741217592bf595efb8d289c
+
+In order to use password-instigated secure level reduction, the SHA1
+crypto module must be loaded or compiled into the kernel:
+
+# insmod sha1.ko
+
+The administrator can then insmod the seclvl module, including the
+SHA1 hash of the password:
+
+# insmod seclvl.ko
+         sha1_passwd=abeda4e0f33defa51741217592bf595efb8d289c
+
+To reduce the secure level, write the password to seclvl/passwd under
+your sysfs mount point:
+
+# echo -n "boogabooga" > /sys/seclvl/passwd
+
+The September 2004 edition of Sys Admin Magazine has an article about
+the BSD Secure Levels LSM.  I encourage you to refer to that article
+for a more in-depth treatment of this security module:
+
+http://www.samag.com/documents/s=9304/sam0409a/0409a.htm

--maH1Gajj2nflutpK--

--pyE8wggRBhVBcj8z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBGObOLTz92j62YB0RArMMAJ0d7OckGAalwogqwrJz6/Wf6kNcsQCg26pX
Ya67wg5kWaOljTzsAs0leGA=
=VHyP
-----END PGP SIGNATURE-----

--pyE8wggRBhVBcj8z--
