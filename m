Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWCYE0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWCYE0g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWCYE0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:26:36 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:24508
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750796AbWCYE0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:26:34 -0500
Date: Fri, 24 Mar 2006 20:26:13 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       alan@lxorguk.ukuu.org.uk,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>, Chris Wright <chrisw@sous-sol.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 01/20] sata_mv: fix irq port status usage
Message-ID: <20060325042613.GB21260@kroah.com>
References: <20060325041355.180237000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sata_mv-fix-irq-port-status-usage.patch"
In-Reply-To: <20060325042556.GA21260@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Jeff Garzik <jeff@garzik.org>

Interrupt handler did not properly initialize a variable on a per-port
basis, leading to incorrect behavior on ports other than port 0.

Bug caught and fixed by Mark Lord.

Signed-off-by: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/scsi/sata_mv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.orig/drivers/scsi/sata_mv.c
+++ linux-2.6.16/drivers/scsi/sata_mv.c
@@ -1192,7 +1192,6 @@ static void mv_host_intr(struct ata_host
 	u32 hc_irq_cause;
 	int shift, port, port0, hard_port, handled;
 	unsigned int err_mask;
-	u8 ata_status = 0;
 
 	if (hc == 0) {
 		port0 = 0;
@@ -1210,6 +1209,7 @@ static void mv_host_intr(struct ata_host
 		hc,relevant,hc_irq_cause);
 
 	for (port = port0; port < port0 + MV_PORTS_PER_HC; port++) {
+		u8 ata_status = 0;
 		ap = host_set->ports[port];
 		hard_port = port & MV_PORT_MASK;	/* range 0-3 */
 		handled = 0;	/* ensure ata_status is set if handled++ */

--
