Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbTKVIjv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 03:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbTKVIjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 03:39:51 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:9491 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S261752AbTKVIjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 03:39:49 -0500
Date: Sat, 22 Nov 2003 19:39:12 +1100
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [I810_AUDIO] 5/x: Fixed partial DMA transfers
Message-ID: <20031122083912.GA27884@gondor.apana.org.au>
References: <20031122070931.GA27231@gondor.apana.org.au> <20031122071345.GA27303@gondor.apana.org.au> <20031122071935.GA27371@gondor.apana.org.au> <20031122082227.GA27692@gondor.apana.org.au> <20031122082635.GA27752@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <20031122082635.GA27752@gondor.apana.org.au>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch fixes SETTRIGGER with playback so that the LVI is always
set and the DAC is always started.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p6

Index: kernel-source-2.4/drivers/sound/i810_audio.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/sound/i810_audio.c,v
retrieving revision 1.13
diff -u -r1.13 i810_audio.c
--- kernel-source-2.4/drivers/sound/i810_audio.c	22 Nov 2003 08:26:51 -0000	1.13
+++ kernel-source-2.4/drivers/sound/i810_audio.c	22 Nov 2003 08:36:07 -0000
@@ -2218,10 +2218,10 @@
 				dmabuf->swptr = dmabuf->hwptr;
 				dmabuf->count = i810_get_free_write_space(state);
 				dmabuf->swptr = (dmabuf->swptr + dmabuf->count) % dmabuf->dmasize;
-				__i810_update_lvi(state, 0);
 				spin_unlock_irqrestore(&state->card->lock, flags);
-			} else
-				start_dac(state);
+			}
+			i810_update_lvi(state, 0);
+			start_dac(state);
 		}
 		if((file->f_mode & FMODE_READ) && (val & PCM_ENABLE_INPUT) && !(dmabuf->enable & ADC_RUNNING)) {
 			if (!dmabuf->read_channel) {

--qDbXVdCdHGoSgWSk--
