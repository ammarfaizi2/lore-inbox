Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267459AbTANGFr>; Tue, 14 Jan 2003 01:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbTANGFr>; Tue, 14 Jan 2003 01:05:47 -0500
Received: from h80ad26f3.async.vt.edu ([128.173.38.243]:51074 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267459AbTANGFp>; Tue, 14 Jan 2003 01:05:45 -0500
Message-Id: <200301140614.h0E6EVqZ024755@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: Weird sound problems on Dell Latitude C840 resolved..
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-548250289P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Jan 2003 01:14:31 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-548250289P
Content-Type: text/plain; charset=us-ascii

A while back, I reported nasty sound distortion/echoing problems
on a C840.  Well, this is a follow-up that I found the cause of the
problem...

I was also running gkrellm, with it's APM monitor activated.  Whenever
it read from /proc/apm, this would cause a call to the BIOS down in
apm_get_power_status().  As near as I can tell, on this particular Dell,
calling the APM drops interrupts on the floor even if you run with
CONFIG_APM_ALLOW_INTS.  Another effect of this was a badly drifting
clock (which is how I found this in the first place) - doing a
a 'grep timer /proc/interrupts', waiting 4 or 5 minutes of wall clock
time, doing it again, and doing the math showed only 980 or so interrupts
per second.  The clock drift exhibits itself under 2.4.18 as well,
but it wasn't breaking audio.

My guess is that the 2.4 driver for the i810 audio is a bit more tolerant
of the occasional dropped interrupt (it seems to like to keep a lot of
data already queued in the ring buffer), but the 2.5 driver runs in much
more 'just in time' mode.  As a result, if the kernel gets suspended while
we monkey around in the BIOS, we get a data underrun, causing my problems.

For what it's worth, the i8k plugin for gkrellm also causes clock drift,
but doesn't seem to upset the audio driver.

(OK, so it's not as glorious as debugging APIC issues on a NUMAQ system.
On the other hand, there's probably a lot more Latitudes out there than
NUMAQ boxes, and more importantly to *me*, I have to deal with this particular
Latitude 8-10 hours a day.  And somebody made a comment about open source
being driven to scratch itches... ;)

/Valdis


--==_Exmh_-548250289P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+I6rGcC3lWbTT17ARAmzEAJ9gvD5VNBpg8g7ftrEm2T3kkbU8lgCg9COf
waHBvsDgymZFAHPPRVzrfK8=
=Fxef
-----END PGP SIGNATURE-----

--==_Exmh_-548250289P--
