Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTKWACQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 19:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbTKWACP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 19:02:15 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:7687 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S262188AbTKWACO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 19:02:14 -0500
Date: Sun, 23 Nov 2003 11:02:02 +1100
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [I810_AUDIO] 9/x: Fix drain_dac loop when signals_allowed == 0
Message-ID: <20031123000202.GA9424@gondor.apana.org.au>
References: <20031122070931.GA27231@gondor.apana.org.au> <20031122071345.GA27303@gondor.apana.org.au> <20031122071935.GA27371@gondor.apana.org.au> <20031122082227.GA27692@gondor.apana.org.au> <20031122082635.GA27752@gondor.apana.org.au> <20031122083912.GA27884@gondor.apana.org.au> <20031122235101.GA9276@gondor.apana.org.au> <20031122235323.GA9326@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20031122235323.GA9326@gondor.apana.org.au>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch fixes another bug in the drain_dac wait loop when it is
called with signals_allowed == 0.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p9

Index: kernel-source-2.4/drivers/sound/i810_audio.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/sound/i810_audio.c,v
retrieving revision 1.16
diff -u -r1.16 i810_audio.c
--- kernel-source-2.4/drivers/sound/i810_audio.c	22 Nov 2003 23:53:34 -0000	1.16
+++ kernel-source-2.4/drivers/sound/i810_audio.c	22 Nov 2003 23:55:57 -0000
@@ -1281,7 +1281,8 @@
 		 * instead of actually sleeping and waiting for an
 		 * interrupt to wake us up!
 		 */
-		__set_current_state(TASK_INTERRUPTIBLE);
+		__set_current_state(signals_allowed ?
+				    TASK_INTERRUPTIBLE : TASK_UNINTERRUPTIBLE);
 		spin_unlock_irqrestore(&state->card->lock, flags);
 
 		if (count <= 0)

--XsQoSWH+UP9D9v3l--
