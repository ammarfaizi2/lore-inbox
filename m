Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWAJMl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWAJMl0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 07:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWAJMl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 07:41:26 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:2533 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750815AbWAJMlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 07:41:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=VnzWgPCnK01C7lcTP1Hy4Df7Lqsw8kpSGN4L3M+sokPpQ6B/lPHGzmjUGu6ybOjDF/QRaXds8e6MNGsbsD24/UuEI25zKm2vWYAOu7qeJ8sP+5Frl4VT65qmmL18vwmIJyUNgDwIgKo3UZDpm5U60vn79vP7W5w7hkkJ3zYoUkE=
Message-ID: <81083a450601100441s7675d584jd10db5a8e6ccaf58@mail.gmail.com>
Date: Tue, 10 Jan 2006 18:11:24 +0530
From: Ashutosh Naik <ashutosh.naik@gmail.com>
To: linux-scsi@vger.kernel.org, James.Bottomley@steeleye.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi/arm/ecoscsi.c Handle scsi_add_host failure
Cc: linux@arm.linux.org.uk
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_124_2415053.1136896884096"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_124_2415053.1136896884096
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Add scsi_add_host() failure handling for ecoscsi driver.

Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>

------=_Part_124_2415053.1136896884096
Content-Type: text/plain; name=ecoscsi.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ecoscsi.txt"

diff -Naurp linux-2.6.15-git5-vanilla/drivers/scsi/arm/ecoscsi.c linux-2.6.15-git5/drivers/scsi/arm/ecoscsi.c
--- linux-2.6.15-git5-vanilla/drivers/scsi/arm/ecoscsi.c	2006-01-03 08:51:10.000000000 +0530
+++ linux-2.6.15-git5/drivers/scsi/arm/ecoscsi.c	2006-01-10 17:59:21.000000000 +0530
@@ -203,7 +203,13 @@ static int __init ecoscsi_init(void)
 	NCR5380_print_options(host);
 	printk("\n");
 
-	scsi_add_host(host, NULL); /* XXX handle failure */
+	retval = scsi_add_host(host, NULL);
+	if (retval) {
+		printk(KERN_WARNING "ecoscsi: scsi_add_host failed\n");
+		scsi_host_put(host);
+		return retval;
+	}
+
 	scsi_scan_host(host);
 	return 0;
 

------=_Part_124_2415053.1136896884096--
