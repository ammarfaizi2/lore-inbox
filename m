Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422882AbWJFTAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422882AbWJFTAM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 15:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422877AbWJFTAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 15:00:11 -0400
Received: from natlemon.rzone.de ([81.169.145.170]:10412 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S1422845AbWJFS7v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:59:51 -0400
Date: Fri, 6 Oct 2006 20:53:10 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Dmitry Torokhov <dtor@mail.ru>, Greg KH <greg@kroah.com>,
       David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] fix mesh compile errors after irq changes
Message-ID: <20061006185310.GA6757@aepfle.de>
References: <20061002132116.2663d7a3.akpm@osdl.org> <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> <18975.1160058127@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0610051632250.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610051632250.3952@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


drivers/scsi/mesh.c:469: error: too many arguments to function 'mesh_interrupt'
drivers/scsi/mesh.c:507: error: too many arguments to function 'mesh_interrupt'

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 drivers/scsi/mesh.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/scsi/mesh.c
===================================================================
--- linux-2.6.orig/drivers/scsi/mesh.c
+++ linux-2.6/drivers/scsi/mesh.c
@@ -466,7 +466,7 @@ static void mesh_start_cmd(struct mesh_s
 				dlog(ms, "intr b4 arb, intr/exc/err/fc=%.8x",
 				     MKWORD(mr->interrupt, mr->exception,
 					    mr->error, mr->fifo_count));
-				mesh_interrupt(0, (void *)ms, NULL);
+				mesh_interrupt(0, (void *)ms);
 				if (ms->phase != arbitrating)
 					return;
 			}
@@ -504,7 +504,7 @@ static void mesh_start_cmd(struct mesh_s
 		dlog(ms, "intr after disresel, intr/exc/err/fc=%.8x",
 		     MKWORD(mr->interrupt, mr->exception,
 			    mr->error, mr->fifo_count));
-		mesh_interrupt(0, (void *)ms, NULL);
+		mesh_interrupt(0, (void *)ms);
 		if (ms->phase != arbitrating)
 			return;
 		dlog(ms, "after intr after disresel, intr/exc/err/fc=%.8x",
