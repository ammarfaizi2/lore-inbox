Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277574AbRJRDXi>; Wed, 17 Oct 2001 23:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277573AbRJRDX2>; Wed, 17 Oct 2001 23:23:28 -0400
Received: from kaa.perlsupport.com ([205.245.149.25]:63243 "EHLO
	kaa.perlsupport.com") by vger.kernel.org with ESMTP
	id <S277572AbRJRDXW>; Wed, 17 Oct 2001 23:23:22 -0400
Date: Wed, 17 Oct 2001 20:23:43 -0700
From: Chip Salzenberg <chip@pobox.com>
To: jsimmons@transvirtual.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        linuxconsole-dev@lists.sourceforge.net
Subject: [PATCH] input-ps2: sprintf() params missing
Message-ID: <20011017202343.A5079@perlsupport.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The recently advertised input-ps2 patch has a minor repeated bug, in
that sprintf() calls are made without enough parameters.  I'm not sure
what the right fix is, but the attached patch at least calls sprintf()
correctly.
-- 
Chip Salzenberg               - a.k.a. -              <chip@pobox.com>
 "We have no fuel on board, plus or minus 8 kilograms."  -- NEAR tech

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=input-ps2-fixes-2


Index: drivers/char/atkbd.c
--- drivers/char/atkbd.c.old	Wed Oct 17 13:36:43 2001
+++ drivers/char/atkbd.c	Wed Oct 17 19:13:57 2001
@@ -493,5 +493,5 @@
 		sprintf(atkbd->name, "AT Set %d keyboard", atkbd->set);
 
-	sprintf(atkbd->phys, "%s/input0\n");
+	sprintf(atkbd->phys, "/dev/serio%d", serio->number);
 
 	if (atkbd->set == 3)

Index: drivers/char/psmouse.c
--- drivers/char/psmouse.c.old	Wed Oct 17 13:36:43 2001
+++ drivers/char/psmouse.c	Wed Oct 17 19:14:11 2001
@@ -609,5 +609,5 @@
 	sprintf(psmouse->devname, "%s %s %s",
 		psmouse_protocols[psmouse->type], psmouse->vendor, psmouse->name);
-	sprintf(psmouse->phys, "%s/input0\n");
+	sprintf(psmouse->phys, "/dev/serio%d", serio->number);
 
 	psmouse->dev.name = psmouse->devname;

Index: drivers/char/xtkbd.c
--- drivers/char/xtkbd.c.old	Wed Oct 17 13:36:43 2001
+++ drivers/char/xtkbd.c	Wed Oct 17 19:14:07 2001
@@ -115,5 +115,5 @@
 	clear_bit(0, xtkbd->dev.keybit);
 
-	sprintf(xtkbd->phys, "%s/input0\n");
+	sprintf(xtkbd->phys, "/dev/serio%d", serio->number);
 
 	xtkbd->dev.name = xtkbd_name;

--sm4nu43k4a2Rpi4c--
