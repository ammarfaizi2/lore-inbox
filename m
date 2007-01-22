Return-Path: <linux-kernel-owner+w=401wt.eu-S1751920AbXAVEec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbXAVEec (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 23:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbXAVEec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 23:34:32 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:52817 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920AbXAVEeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 23:34:31 -0500
From: Mike Frysinger <vapier@gentoo.org>
Organization: wh0rd.org
To: a.zummo@towertech.it
Subject: [patch] some rtc documentation updates
Date: Sun, 21 Jan 2007 23:34:36 -0500
User-Agent: KMail/1.9.5
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_d7DtFWigXtS/a+G"
Message-Id: <200701212334.37396.vapier@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_d7DtFWigXtS/a+G
Content-Type: multipart/signed;
  boundary="nextPart16955314.pXxOYuQnp3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart16955314.pXxOYuQnp3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

find attached a patch to update the rtc documentation a bit.  i fixed a typ=
o,=20
added a bunch of helpful pointers (thanks to Paul Mundt and the linux/sh gu=
ys=20
for holding my hand :D), and improved a bunch of the error messages in the=
=20
test program

hope this helps
=2Dmike

--nextPart16955314.pXxOYuQnp3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iQIVAwUARbQ+3UFjO5/oN/WBAQIwsBAAgv/seG4Iz9aGyLmuwvPEoQvBaIs2sJgd
WRRQnSfGiB028ceACs+dfxndylBbTjShzUSAEygYAiEIs+V7ecH9vd+U0ljnH+ej
W91PllEi81RDb99sAfa+xXMBISo4nwUxLs3je3HBECodXok95Ryi8m7B1pWXJnVD
sZV9IhNF+Iq6iJlGbpWIi8BuBvktngmnMlq45Cl0nq8WQEEZs/Mx4XS1y50vEF3z
JnAzRKSe7GwyYP1fcADZdGN2/HbTGgg9KaR0fHSI+1ZI1FKRHAHIYZKbu4EYDtgO
xg5CAcRibjM98RQKV/EyHt/euKlLCH6LRigJgJElgTrZ06L+QebjW4RZY8dh1iKj
Q3G63I9txE+AZp38oYldNY1nJxPQin6RDvc0+OWugC5Zvv0EVoZpVbCt/3cm6dJW
96p2TuQvoDbFgir6sz2qdqqSK2UCm2vpap3ecbKdnyMTOiinx54Ussz4vyhAPqia
M4F87MosDUH1/8ae99DTaIkXbYK9xWFGramUJLH8Zh9tYnydwbb6Pk3GMpxMEBgF
sueBq/5ME3jhNDsQDpGOsEPPcKXhbO/pstw1joNX/K2FgRwje7K9aw3W8eENtr9J
A9tbZuBHOPX+zQejU7vtK0iVePRQBe66IodpMekb6AGl1DWoXGIL27AF8NQDUXvp
jKKr8s7WGqo=
=XiFT
-----END PGP SIGNATURE-----

--nextPart16955314.pXxOYuQnp3--

--Boundary-00=_d7DtFWigXtS/a+G
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-rtc-doc-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="linux-rtc-doc-update.patch"

Fix typo when describing RTC_WKALM.  Add some helpful pointers to people
developing their own RTC driver.  Change a bunch of the error messages in the
test program to be a bit more helpful.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>

diff --git a/Documentation/rtc.txt b/Documentation/rtc.txt
index 7cf1ec5..1ef6bb8 100644
--- a/Documentation/rtc.txt
+++ b/Documentation/rtc.txt
@@ -149,7 +149,7 @@ RTC class framework, but can't be supported by the older driver.
 	is connected to an IRQ line, it can often issue an alarm IRQ up to
 	24 hours in the future.
 
-    *	RTC_WKALM_SET, RTC_WKALM_READ ... RTCs that can issue alarms beyond
+    *	RTC_WKALM_SET, RTC_WKALM_RD ... RTCs that can issue alarms beyond
 	the next 24 hours use a slightly more powerful API, which supports
 	setting the longer alarm time and enabling its IRQ using a single
 	request (using the same model as EFI firmware).
@@ -167,6 +167,28 @@ Linux out of a low power sleep state (or hibernation) back to a fully
 operational state.  For example, a system could enter a deep power saving
 state until it's time to execute some scheduled tasks.
 
+Note that many of these ioctls need not actually be implemented by your
+driver.  The common rtc-dev interface handles many of these nicely if your
+driver returns ENOIOCTLCMD.  Some common examples:
+
+    *	RTC_RD_TIME, RTC_SET_TIME: the read_time/set_time functions will be
+	called with appropriate values.
+
+    *	RTC_ALM_SET, RTC_ALM_READ, RTC_WKALM_SET, RTC_WKALM_RD: the
+	set_alarm/read_alarm functions will be called.  To differentiate
+	between the ALM and WKALM, check the larger fields of the rtc_wkalrm
+	struct (like tm_year).  These will be set to -1 when using ALM and
+	will be set to proper values when using WKALM.
+
+    *	RTC_IRQP_SET, RTC_IRQP_READ: the irq_set_freq function will be called
+	to set the frequency while the framework will handle the read for you
+	since the frequency is stored in the irq_freq member of the rtc_device
+	structure.  Also make sure you set the max_user_freq member in your
+	initialization routines so the framework can sanity check the user
+	input for you.
+
+If all else fails, check out the rtc-test.c driver!
+
 
 -------------------- 8< ---------------- 8< -----------------------------
 
@@ -237,7 +259,7 @@ int main(int argc, char **argv)
 				"\n...Update IRQs not supported.\n");
 			goto test_READ;
 		}
-		perror("ioctl");
+		perror("RTC_UIE_ON ioctl");
 		exit(errno);
 	}
 
@@ -284,7 +306,7 @@ int main(int argc, char **argv)
 	/* Turn off update interrupts */
 	retval = ioctl(fd, RTC_UIE_OFF, 0);
 	if (retval == -1) {
-		perror("ioctl");
+		perror("RTC_UIE_OFF ioctl");
 		exit(errno);
 	}
 
@@ -292,7 +314,7 @@ test_READ:
 	/* Read the RTC time/date */
 	retval = ioctl(fd, RTC_RD_TIME, &rtc_tm);
 	if (retval == -1) {
-		perror("ioctl");
+		perror("RTC_RD_TIME ioctl");
 		exit(errno);
 	}
 
@@ -320,14 +342,14 @@ test_READ:
 				"\n...Alarm IRQs not supported.\n");
 			goto test_PIE;
 		}
-		perror("ioctl");
+		perror("RTC_ALM_SET ioctl");
 		exit(errno);
 	}
 
 	/* Read the current alarm settings */
 	retval = ioctl(fd, RTC_ALM_READ, &rtc_tm);
 	if (retval == -1) {
-		perror("ioctl");
+		perror("RTC_ALM_READ ioctl");
 		exit(errno);
 	}
 
@@ -337,7 +359,7 @@ test_READ:
 	/* Enable alarm interrupts */
 	retval = ioctl(fd, RTC_AIE_ON, 0);
 	if (retval == -1) {
-		perror("ioctl");
+		perror("RTC_AIE_ON ioctl");
 		exit(errno);
 	}
 
@@ -355,7 +377,7 @@ test_READ:
 	/* Disable alarm interrupts */
 	retval = ioctl(fd, RTC_AIE_OFF, 0);
 	if (retval == -1) {
-		perror("ioctl");
+		perror("RTC_AIE_OFF ioctl");
 		exit(errno);
 	}
 
@@ -368,7 +390,7 @@ test_PIE:
 			fprintf(stderr, "\nNo periodic IRQ support\n");
 			return 0;
 		}
-		perror("ioctl");
+		perror("RTC_IRQP_READ ioctl");
 		exit(errno);
 	}
 	fprintf(stderr, "\nPeriodic IRQ rate is %ldHz.\n", tmp);
@@ -387,7 +409,7 @@ test_PIE:
 					"\n...Periodic IRQ rate is fixed\n");
 				goto done;
 			}
-		        perror("ioctl");
+		        perror("RTC_IRQP_SET ioctl");
 		        exit(errno);
 		}
 
@@ -397,7 +419,7 @@ test_PIE:
 		/* Enable periodic interrupts */
 		retval = ioctl(fd, RTC_PIE_ON, 0);
 		if (retval == -1) {
-		        perror("ioctl");
+		        perror("RTC_PIE_ON ioctl");
 		        exit(errno);
 		}
 
@@ -416,7 +438,7 @@ test_PIE:
 		/* Disable periodic interrupts */
 		retval = ioctl(fd, RTC_PIE_OFF, 0);
 		if (retval == -1) {
-		        perror("ioctl");
+		        perror("RTC_PIE_OFF ioctl");
 		        exit(errno);
 		}
 	}

--Boundary-00=_d7DtFWigXtS/a+G--
