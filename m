Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbTDUEdu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 00:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbTDUEdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 00:33:50 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:19912
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263760AbTDUEds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 00:33:48 -0400
Message-ID: <3EA3775C.6060703@redhat.com>
Date: Sun, 20 Apr 2003 21:45:16 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030420
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: oops with bk version as of 20030420T20:00:00-0700
References: <3EA369B7.5070905@redhat.com>
In-Reply-To: <3EA369B7.5070905@redhat.com>
X-Enigmail-Version: 0.74.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2B1E3880B9C2FBFADF90F748"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2B1E3880B9C2FBFADF90F748
Content-Type: multipart/mixed;
 boundary="------------060804010101070508070300"

This is a multi-part message in MIME format.
--------------060804010101070508070300
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ulrich Drepper wrote:
> I got this oops right at startup time.  The machine is a UP P4 HT
> (Northwood core).
> [...]

Cured by this patch.  Arnaldo Carvalho de Melo pointed me to the lkml
thread.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

--------------060804010101070508070300
Content-Type: text/plain;
 name="d-kernel-rtc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="d-kernel-rtc"

--- drivers/char/rtc.c-save	2003-04-20 21:43:11.000000000 -0700
+++ drivers/char/rtc.c	2003-04-20 21:40:23.000000000 -0700
@@ -180,7 +180,7 @@ static const unsigned char days_in_mo[] 
  *	(See ./arch/XXXX/kernel/time.c for the set_rtc_mmss() function.)
  */
 
-static void rtc_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t rtc_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	/*
 	 *	Can be an alarm interrupt, update complete interrupt,
@@ -208,6 +208,7 @@ static void rtc_interrupt(int irq, void 
 	wake_up_interruptible(&rtc_wait);	
 
 	kill_fasync (&rtc_async_queue, SIGIO, POLL_IN);
+	return IRQ_HANDLED;
 }
 #endif
 

--------------060804010101070508070300--

--------------enig2B1E3880B9C2FBFADF90F748
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+o3dc2ijCOnn/RHQRAtwrAKDMuDiHkk7xq69r7tA2ptaMQ1vCDQCePkVw
8+9SGE9+4xWSCsvh5iQY8N8=
=uyp/
-----END PGP SIGNATURE-----

--------------enig2B1E3880B9C2FBFADF90F748--

