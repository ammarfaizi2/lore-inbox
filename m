Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293079AbSBWB44>; Fri, 22 Feb 2002 20:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293082AbSBWB4s>; Fri, 22 Feb 2002 20:56:48 -0500
Received: from u212-239-157-160.goplanet.pi.be ([212.239.157.160]:9478 "EHLO
	jebril.pi.be") by vger.kernel.org with ESMTP id <S293079AbSBWB4d>;
	Fri, 22 Feb 2002 20:56:33 -0500
Message-Id: <200202230155.g1N1tdYb032032@jebril.pi.be>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: [PATCH] making aha152x.c *really* compile in 2.5.5
Date: Sat, 23 Feb 2002 02:55:39 +0100
From: "Michel Eyckmans (MCE)" <mce@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oops, I posted the wrong version of that patch. This is the one
that actually compiles. Sorry. It obviously is time to go catch 
some sleep.

    MCE

=======================================================================
--- drivers/scsi/aha152x.c.old	Wed Jan 30 23:15:24 2002
+++ drivers/scsi/aha152x.c	Sat Feb 23 02:30:37 2002
@@ -1494,7 +1494,7 @@
 	   SCp.phase            : current state of the command */
 	if (SCpnt->use_sg) {
 		SCpnt->SCp.buffer           = (struct scatterlist *) SCpnt->request_buffer;
-		SCpnt->SCp.ptr              = SCpnt->SCp.buffer->address;
+		SCpnt->SCp.ptr              = page_address(SCpnt->SCp.buffer->page) + SCpnt->SCp.buffer->offset;
 		SCpnt->SCp.this_residual    = SCpnt->SCp.buffer->length;
 		SCpnt->SCp.buffers_residual = SCpnt->use_sg - 1;
 	} else {
@@ -2681,7 +2681,7 @@
                                		/* advance to next buffer */
                                		CURRENT_SC->SCp.buffers_residual--;
                                		CURRENT_SC->SCp.buffer++;
-                               		CURRENT_SC->SCp.ptr           = CURRENT_SC->SCp.buffer->address;
+                               		CURRENT_SC->SCp.ptr           = page_address(CURRENT_SC->SCp.buffer->page) + CURRENT_SC->SCp.buffer->offset;
                                		CURRENT_SC->SCp.this_residual = CURRENT_SC->SCp.buffer->length;
 				} 
                 	}
@@ -2791,7 +2791,7 @@
 			/* advance to next buffer */
 			CURRENT_SC->SCp.buffers_residual--;
 			CURRENT_SC->SCp.buffer++;
-			CURRENT_SC->SCp.ptr           = CURRENT_SC->SCp.buffer->address;
+			CURRENT_SC->SCp.ptr           = page_address(CURRENT_SC->SCp.buffer->page) + CURRENT_SC->SCp.buffer->offset;
 			CURRENT_SC->SCp.this_residual = CURRENT_SC->SCp.buffer->length;
 		}
 
@@ -2821,13 +2821,13 @@
 		CURRENT_SC->resid += data_count;
 
 		if(CURRENT_SC->use_sg) {
-			data_count -= CURRENT_SC->SCp.ptr - CURRENT_SC->SCp.buffer->address;
+			data_count -= CURRENT_SC->SCp.ptr - (char*) (page_address(CURRENT_SC->SCp.buffer->page) + CURRENT_SC->SCp.buffer->offset);
 			while(data_count>0) {
 				CURRENT_SC->SCp.buffer--;
 				CURRENT_SC->SCp.buffers_residual++;
 				data_count -= CURRENT_SC->SCp.buffer->length;
 			}
-			CURRENT_SC->SCp.ptr           = CURRENT_SC->SCp.buffer->address - data_count;
+			CURRENT_SC->SCp.ptr           = page_address(CURRENT_SC->SCp.buffer->page) + CURRENT_SC->SCp.buffer->offset - data_count;
 			CURRENT_SC->SCp.this_residual = CURRENT_SC->SCp.buffer->length + data_count;
 		} else {
 			CURRENT_SC->SCp.ptr           -= data_count;


-- 
========================================================================
M. Eyckmans (MCE)          Code of the Geeks v3.1       mce-at-pi-dot-be
GCS d+ s+:- a36 C+++$ UHLUASO+++$ P+ L+++ E--- W++ N+++ !o K w--- !O M--
 V-- PS+ PE+ Y+ PGP- t--- !5 !X R- tv- b+ DI++ D-- G++ e+++ h+(*) !r y?
========================================================================

