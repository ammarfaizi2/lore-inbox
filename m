Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265981AbUAQD6e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 22:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265982AbUAQD6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 22:58:33 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:62215 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S265981AbUAQD6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 22:58:32 -0500
Date: Sat, 17 Jan 2004 14:58:17 +1100
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [I810_AUDIO] 11/x: Fix dead lock in drain_dac
Message-ID: <20040117035817.GA21455@gondor.apana.org.au>
References: <20031122070931.GA27231@gondor.apana.org.au> <20031122071345.GA27303@gondor.apana.org.au> <20031122071935.GA27371@gondor.apana.org.au> <20031122082227.GA27692@gondor.apana.org.au> <20031122082635.GA27752@gondor.apana.org.au> <20031122083912.GA27884@gondor.apana.org.au> <20031122235101.GA9276@gondor.apana.org.au> <20031122235323.GA9326@gondor.apana.org.au> <20031123000202.GA9424@gondor.apana.org.au> <20031123110401.GA15665@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20031123110401.GA15665@gondor.apana.org.au>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch fixes a typo in a previous change that causes the driver
to deadlock under SMP.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-2.4/drivers/sound/i810_audio.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/sound/i810_audio.c,v
retrieving revision 1.19
diff -u -r1.19 i810_audio.c
--- kernel-2.4/drivers/sound/i810_audio.c	29 Nov 2003 09:53:43 -0000	1.19
+++ kernel-2.4/drivers/sound/i810_audio.c	16 Jan 2004 22:49:54 -0000
@@ -1260,7 +1260,7 @@
 	 * any possible deadlocks.
 	 */
 	dmabuf->trigger = PCM_ENABLE_OUTPUT;
-	i810_update_lvi(state, 0);
+	__i810_update_lvi(state, 0);
 
 	spin_unlock_irqrestore(&state->card->lock, flags);
 

--RnlQjJ0d97Da+TV1--
