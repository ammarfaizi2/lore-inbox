Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266353AbUHCNOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266353AbUHCNOd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 09:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266380AbUHCNOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 09:14:33 -0400
Received: from mail022.syd.optusnet.com.au ([211.29.132.100]:60608 "EHLO
	mail022.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266353AbUHCNOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 09:14:24 -0400
Message-ID: <410F8F86.8060700@kolivas.org>
Date: Tue, 03 Aug 2004 23:13:42 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dominik.karall@gmx.net
Subject: Re: 2.6.8-rc2-mm2
References: <20040802015527.49088944.akpm@osdl.org>
In-Reply-To: <20040802015527.49088944.akpm@osdl.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig73D01188E7D210999EF21962"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig73D01188E7D210999EF21962
Content-Type: multipart/mixed;
 boundary="------------030400070904050105040206"

This is a multi-part message in MIME format.
--------------030400070904050105040206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> - Added Con's staircase CPU scheduler.

Somehow my sysctls ended in /proc/sys/fs/

Thanks dominik for noting you couldn't find them ;)

This patch puts them back in /proc/sys/kernel/ where I had intended them 
to be.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

  sysctl.c |   32 ++++++++++++++++----------------
  1 files changed, 16 insertions(+), 16 deletions(-)

--------------030400070904050105040206
Content-Type: text/plain;
 name="fix-staircase-proc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-staircase-proc"

Index: linux-2.6.8-rc2-mm2/kernel/sysctl.c
===================================================================
--- linux-2.6.8-rc2-mm2.orig/kernel/sysctl.c	2004-08-03 01:29:29.000000000 +1000
+++ linux-2.6.8-rc2-mm2/kernel/sysctl.c	2004-08-03 23:01:42.572962387 +1000
@@ -636,6 +636,22 @@
 		.proc_handler   = &proc_unknown_nmi_panic,
 	},
 #endif
+	{
+		.ctl_name	= KERN_INTERACTIVE,
+		.procname	= "interactive",
+		.data		= &sched_interactive,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= KERN_COMPUTE,
+		.procname	= "compute",
+		.data		= &sched_compute,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 	{ .ctl_name = 0 }
 };
 
@@ -927,22 +943,6 @@
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
-	{
-		.ctl_name	= KERN_INTERACTIVE,
-		.procname	= "interactive",
-		.data		= &sched_interactive,
-		.maxlen		= sizeof (int),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
-	},
-	{
-		.ctl_name	= KERN_COMPUTE,
-		.procname	= "compute",
-		.data		= &sched_compute,
-		.maxlen		= sizeof (int),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
-	},
 	{ .ctl_name = 0 }
 };
 

--------------030400070904050105040206--

--------------enig73D01188E7D210999EF21962
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBD4+JZUg7+tp6mRURAuoXAJ9essjYkzLqfnPvfmJVXevM4TeR4ACffvsE
iDbJbZU3krS+WfSkAto/lCM=
=oBGb
-----END PGP SIGNATURE-----

--------------enig73D01188E7D210999EF21962--
