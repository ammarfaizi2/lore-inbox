Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262702AbSJRBWB>; Thu, 17 Oct 2002 21:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262707AbSJRBWB>; Thu, 17 Oct 2002 21:22:01 -0400
Received: from [61.149.33.25] ([61.149.33.25]:59396 "HELO bj.soulinfo.com")
	by vger.kernel.org with SMTP id <S262702AbSJRBV7>;
	Thu, 17 Oct 2002 21:21:59 -0400
Date: Fri, 18 Oct 2002 09:25:21 +0800
From: Hu Gang <hugang@soulinfo.com>
To: EricAltendorf@orst.edu, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bug: swsusp in 2.5.42: "Scheduling while atomic"
Message-Id: <20021018092521.3180fd42.hugang@soulinfo.com>
In-Reply-To: <200210171636.13669.EricAltendorf@orst.edu>
References: <200210171636.13669.EricAltendorf@orst.edu>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.8.2claws28 (GTK+ 1.2.10; i386-linux-debian-i386-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.Q,6VpZu6u5/WD'"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.Q,6VpZu6u5/WD'
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Oct 2002 16:36:13 -0700
Eric Altendorf <EricAltendorf@orst.edu> wrote:

|
|[1.] One line summary of the problem: 
|
|Scheduling while atomic debug message during swsusp
|
|[2.] Full description of the problem/report:
|
|While swsusp'ing to disk, vast quantities of error messages are echoed to the
|console, along the lines of the following pulled from /var/log/messages:

This Problem is net lay resume recall problem. Try this patch, From my test it can works in net card device, but it can not work in sound card device.
-------------------------
--- linus-2.5/kernel/suspend.c	Fri Oct 18 09:22:36 2002
+++ linus-2.5-suspend/kernel/suspend.c	Thu Oct 17 20:42:08 2002
@@ -627,7 +627,7 @@
 /* Make disk drivers accept operations, again */
 static void drivers_unsuspend(void)
 {
-	device_resume(RESUME_RESTORE_STATE);
+	/* device_resume(RESUME_RESTORE_STATE); */
 	device_resume(RESUME_ENABLE);
 }
 
@@ -655,7 +655,7 @@
 static void drivers_resume(int flags)
 {
 	if (flags & RESUME_PHASE1) {
-		device_resume(RESUME_RESTORE_STATE);
+		/* device_resume(RESUME_RESTORE_STATE); */
 		device_resume(RESUME_ENABLE);
 	}
   	if (flags & RESUME_PHASE2) {


-- 
		- Hu Gang

--=.Q,6VpZu6u5/WD'
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9r2MDPM4uCy7bAJgRAjCOAJ43sQs85IXbTwJxCx8o3DUDtUQsUgCfS4a+
A4mgOVs70lWI/U/7DBX4sC4=
=S9x1
-----END PGP SIGNATURE-----

--=.Q,6VpZu6u5/WD'--
