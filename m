Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131625AbRC0Vbh>; Tue, 27 Mar 2001 16:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131626AbRC0Vb1>; Tue, 27 Mar 2001 16:31:27 -0500
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:39159 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131625AbRC0VbW>; Tue, 27 Mar 2001 16:31:22 -0500
Date: Tue, 27 Mar 2001 22:30:35 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [patch] 2.4.3-pre8: another parport fix
Message-ID: <20010327223035.O21068@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a printing bug that only seems to show up with some
chipsets.  Please apply.

Thanks,
Tim.
*/

2001-03-27  Tim Waugh  <twaugh@redhat.com>

	* parport_pc: Fix save/restore_state to take account of the soft
	control port.
	* ChangeLog: Updated.

--- linux/drivers/parport/parport_pc.c.restorestate	Tue Mar 27 15:03:05 2001
+++ linux/drivers/parport/parport_pc.c	Tue Mar 27 15:05:41 2001
@@ -347,7 +347,7 @@
 void parport_pc_save_state(struct parport *p, struct parport_state *s)
 {
 	const struct parport_pc_private *priv = p->physport->private_data;
-	s->u.pc.ctr = inb (CONTROL (p));
+	s->u.pc.ctr = priv->ctr;
 	if (priv->ecr)
 		s->u.pc.ecr = inb (ECONTROL (p));
 }
@@ -356,6 +356,7 @@
 {
 	const struct parport_pc_private *priv = p->physport->private_data;
 	outb (s->u.pc.ctr, CONTROL (p));
+	priv->ctr = s->u.pc.ctr;
 	if (priv->ecr)
 		outb (s->u.pc.ecr, ECONTROL (p));
 }
*** linux/drivers/parport/ChangeLog.restorestate	Tue Mar 27 15:03:04 2001
--- linux/drivers/parport/ChangeLog	Tue Mar 27 15:04:51 2001
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
