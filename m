Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132460AbQLQNDU>; Sun, 17 Dec 2000 08:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132610AbQLQNDK>; Sun, 17 Dec 2000 08:03:10 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:9630 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S132460AbQLQNDE>; Sun, 17 Dec 2000 08:03:04 -0500
Date: Sun, 17 Dec 2000 12:32:37 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.0-test13-pre2: better parport_pc commentary
Message-ID: <20001217123237.F19671@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is a patch to make the parport_pc comments better.  No code
change.

Tim.
*/

2000-12-17  Tim Waugh  <twaugh@redhat.com>

	* drivers/parport/parport_pc.c: Better commentary.  Patch from
	R Horn.
	* drivers/parport/ChangeLog: Updated.

--- linux-2.4.0-test12/drivers/parport/parport_pc.c.commentary	Tue Dec 12 13:03:24 2000
+++ linux-2.4.0-test12/drivers/parport/parport_pc.c	Wed Dec 13 14:11:11 2000
@@ -938,13 +938,11 @@
 			/* Can't yield the port. */
 			schedule ();
 
-		/* At this point, the FIFO may already be full.
-		 * Ideally, we'd be able to tell the port to hold on
-		 * for a second while we empty the FIFO, and we'd be
-		 * able to ensure that no data is lost.  I'm not sure
-		 * that's the case. :-(  It might be that you can play
-		 * games with STB, as in the forward case; someone should
-		 * look at a datasheet. */
+		/* At this point, the FIFO may already be full. In
+                 * that case ECP is already holding back the
+                 * peripheral (assuming proper design) with a delayed
+                 * handshake.  Work fast to avoid a peripheral
+                 * timeout.  */
 
 		if (ecrval & 0x01) {
 			/* FIFO is empty. Wait for interrupt. */
@@ -976,6 +974,10 @@
 				goto false_alarm;
 			}
 
+			/* Depending on how the FIFO threshold was
+                         * set, how long interrupt service took, and
+                         * how fast the peripheral is, we might be
+                         * lucky and have a just filled FIFO. */
 			continue;
 		}
 
@@ -987,6 +989,9 @@
 			continue;
 		}
 
+		/* FIFO not filled.  We will cycle this loop for a while
+                 * and either the peripheral will fill it faster,
+                 * tripping a fast empty with insb, or we empty it. */
 		*bufp++ = inb (fifo);
 		left--;
 	}
--- linux-2.4.0-test12/drivers/parport/ChangeLog.commentary	Wed Dec 13 14:17:10 2000
+++ linux-2.4.0-test12/drivers/parport/ChangeLog	Wed Dec 13 14:17:26 2000
@@ -0,0 +1,4 @@
+2000-12-17  R Horn  <rjh@world.std.com>
+
+	* parport_pc.c: Some commentary changes.
+
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
