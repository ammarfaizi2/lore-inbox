Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131657AbRC0WFR>; Tue, 27 Mar 2001 17:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131673AbRC0WFK>; Tue, 27 Mar 2001 17:05:10 -0500
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:6924 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131657AbRC0WEv>; Tue, 27 Mar 2001 17:04:51 -0500
Date: Tue, 27 Mar 2001 23:04:03 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [take 2] [patch] 2.4.3-pre8: another parport bug
Message-ID: <20010327230403.Q21068@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, the last patch isn't the one I meant to send.  Here is the right
one.

Tim.
*/

2001-03-27  Tim Waugh  <twaugh@redhat.com>

	* parport_pc: Fix save/restore_state to take account of the soft
	control port.
	* ChangeLog: Updated.

--- linux/drivers/parport/parport_pc.c.restorestate	Tue Mar 27 23:00:18 2001
+++ linux/drivers/parport/parport_pc.c	Tue Mar 27 23:00:50 2001
@@ -347,15 +347,16 @@
 void parport_pc_save_state(struct parport *p, struct parport_state *s)
 {
 	const struct parport_pc_private *priv = p->physport->private_data;
-	s->u.pc.ctr = inb (CONTROL (p));
+	s->u.pc.ctr = priv->ctr;
 	if (priv->ecr)
 		s->u.pc.ecr = inb (ECONTROL (p));
 }
 
 void parport_pc_restore_state(struct parport *p, struct parport_state *s)
 {
-	const struct parport_pc_private *priv = p->physport->private_data;
+	struct parport_pc_private *priv = p->physport->private_data;
 	outb (s->u.pc.ctr, CONTROL (p));
+	priv->ctr = s->u.pc.ctr;
 	if (priv->ecr)
 		outb (s->u.pc.ecr, ECONTROL (p));
 }
*** linux/drivers/parport/ChangeLog.restorestate	Tue Mar 27 23:00:18 2001
--- linux/drivers/parport/ChangeLog	Tue Mar 27 23:00:38 2001
***************
*** 0 ****
--- 1,7 ----
+ 2001-03-27  Tim Waugh  <twaugh@redhat.com>
+ 
+       * parport_pc.c (parport_pc_save_state): Read from the soft copy of
+       the control port.
+       (parport_pc_restore_state): Update the soft copy of the control
+       port.
+ 
