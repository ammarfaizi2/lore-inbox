Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbTLDOI0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 09:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbTLDOI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 09:08:26 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:9609
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S262041AbTLDOIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 09:08:22 -0500
From: Con Kolivas <kernel@kolivas.org>
To: "Tvrtko A. =?utf-8?q?Ur=C5=A1ulin?=" <tvrtko@croadria.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: 2.4.23-ck1
Date: Fri, 5 Dec 2003 01:08:15 +1100
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200312040228.44980.kernel@kolivas.org> <Pine.LNX.4.53.0312041421300.9854@gockel.physik3.uni-rostock.de> <200312041436.57450.tvrtko@croadria.com>
In-Reply-To: <200312041436.57450.tvrtko@croadria.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_P/zz/UpEabWzq+M"
Message-Id: <200312050108.15839.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_P/zz/UpEabWzq+M
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Fri, 5 Dec 2003 00:36, Tvrtko A. Ur=C5=A1ulin wrote:
> On Thursday 04 December 2003 14:31, Tim Schmielau wrote:
> > Warning: totally untested. Pretty much obvious, however.
>
> oxygene:/usr/src/linux-2.4.23-ck1 # patch --dry-run
> <../patches/2.4.23-ck1-stat-fix.patch -p1 --global-reject=3Dbla
> patching file fs/proc/proc_misc.c
> Hunk #1 FAILED at 422.
> Hunk #2 FAILED at 460.
> 2 out of 2 hunks FAILED -- saving rejects to file fs/proc/proc_misc.c.rej

Probably just a whitespace problem. Try this one. Please tell me if it work=
s;=20
I just made this based on what Tim sent (thanks muchly by the way Tim!)

Con

--Boundary-00=_P/zz/UpEabWzq+M
Content-Type: text/x-diff;
  charset="utf-8";
  name="patch-2.4.23-ck1-fix1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="patch-2.4.23-ck1-fix1"

diff -Naurp linux-2.4.23-ck1/fs/proc/proc_misc.c linux-2.4.23-ck1-fix1/fs/proc/proc_misc.c
--- linux-2.4.23-ck1/fs/proc/proc_misc.c	2003-12-02 23:17:28.000000000 +1100
+++ linux-2.4.23-ck1-fix1/fs/proc/proc_misc.c	2003-12-05 01:06:11.585672996 +1100
@@ -422,7 +422,7 @@ static int kstat_read_proc(char *page, c
 			(unsigned long long) jiffies_64_to_clock_t(user),
 			(unsigned long long) jiffies_64_to_clock_t(nice),
 			(unsigned long long) jiffies_64_to_clock_t(system),
-			(unsigned long long) jiffies_64_to_clock_t(jif - user - nice - system));
+			(unsigned long long) jif - jiffies_64_to_clock_t(user + nice + system));
 	}
 	proc_sprintf(page, &off, &len,
 		"page %u %u\n"
@@ -460,7 +460,7 @@ static int kstat_read_proc(char *page, c
 		}
 	}
 
-	do_div(jif, HZ);
+	do_div(jif, USER_HZ);
 	proc_sprintf(page, &off, &len,
 		"\nctxt %lu\n"
 		"btime %lu\n"

--Boundary-00=_P/zz/UpEabWzq+M--

