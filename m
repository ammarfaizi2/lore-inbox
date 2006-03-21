Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWCUA6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWCUA6A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 19:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWCUA6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 19:58:00 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:47332 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751409AbWCUA57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 19:57:59 -0500
Message-ID: <441F4F95.4070203@garzik.org>
Date: Mon, 20 Mar 2006 19:57:57 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [git patch append] sata_mv fix
Content-Type: multipart/mixed;
 boundary="------------050703040104090804020601"
X-Spam-Score: -2.2 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050703040104090804020601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


FWIW, I appended the attached changeset to the 'upstream-linus' branch 
of libata-dev.git (and also forwarded it to stable@kernel.org).

FWIW 2, except for fixes like the attached, 'upstream-linus' is a frozen 
branch, and normally isn't touched until you pull.  Development 
continues in the separate 'upstream' branch, which ensures there are no 
surprise csets when 'upstream-linus' is pulled.  'upstream-linus' is a 
branch that behaves like a tag. Most of the time.

	Jeff




--------------050703040104090804020601
Content-Type: text/plain;
 name="libata.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata.txt"

commit cd85f6e2f58282186ad720fc18482be228f0b972
Author: Jeff Garzik <jeff@garzik.org>
Date:   Mon Mar 20 19:49:54 2006 -0500

    [libata] sata_mv: fix irq port status usage

    Interrupt handler did not properly initialize a variable on a per-port
    basis, leading to incorrect behavior on ports other than port 0.

    Bug caught and fixed by Mark Lord.

    Signed-off-by: Jeff Garzik <jeff@garzik.org>


cd85f6e2f58282186ad720fc18482be228f0b972
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index aceaf56..e561281 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -1353,7 +1353,6 @@ static void mv_host_intr(struct ata_host
 	u32 hc_irq_cause;
 	int shift, port, port0, hard_port, handled;
 	unsigned int err_mask;
-	u8 ata_status = 0;
 
 	if (hc == 0) {
 		port0 = 0;
@@ -1371,6 +1370,7 @@ static void mv_host_intr(struct ata_host
 		hc,relevant,hc_irq_cause);
 
 	for (port = port0; port < port0 + MV_PORTS_PER_HC; port++) {
+		u8 ata_status = 0;
 		ap = host_set->ports[port];
 		hard_port = port & MV_PORT_MASK;	/* range 0-3 */
 		handled = 0;	/* ensure ata_status is set if handled++ */

--------------050703040104090804020601--
