Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265539AbTF2DOs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 23:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265538AbTF2DOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 23:14:48 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:31236 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265536AbTF2DOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 23:14:45 -0400
Subject: Re: 2.5.73-mm1 falling over in SDET
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@digeo.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20030628170235.51ee2f69.akpm@digeo.com>
References: <45120000.1056810681@[10.10.2.4]>
	<49400000.1056814561@[10.10.2.4]>  <20030628170235.51ee2f69.akpm@digeo.com>
Content-Type: multipart/mixed; boundary="=-Gw0SDRjMbWXjBi0gn4B/"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 28 Jun 2003 22:28:57 -0500
Message-Id: <1056857338.2514.4.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Gw0SDRjMbWXjBi0gn4B/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2003-06-28 at 19:02, Andrew Morton wrote:
> Yes, isplinux_queuecommand() returns non-zero and the scsi generic layer
> cheerfully goes infinitely recursive.

Sigh, certain persons need to be more careful when doing logic
alterations.

Try the attached.

James


--=-Gw0SDRjMbWXjBi0gn4B/
Content-Disposition: attachment; filename=tmp.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=tmp.diff; charset=ISO-8859-1

=3D=3D=3D=3D=3D drivers/scsi/hosts.c 1.79 vs edited =3D=3D=3D=3D=3D
--- 1.79/drivers/scsi/hosts.c	Thu Jun 26 22:51:24 2003
+++ edited/drivers/scsi/hosts.c	Sat Jun 28 22:14:12 2003
@@ -194,7 +194,7 @@
 	shost->use_blk_tcq =3D sht->use_blk_tcq;
 	shost->highmem_io =3D sht->highmem_io;
=20
-	if (!sht->max_host_blocked)
+	if (sht->max_host_blocked)
 		shost->max_host_blocked =3D sht->max_host_blocked;
 	else
 		shost->max_host_blocked =3D SCSI_DEFAULT_HOST_BLOCKED;

--=-Gw0SDRjMbWXjBi0gn4B/--

