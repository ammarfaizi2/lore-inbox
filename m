Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTKVHN4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 02:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbTKVHN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 02:13:56 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:50194 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S262063AbTKVHNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 02:13:54 -0500
Date: Sat, 22 Nov 2003 18:13:45 +1100
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [I810_AUDIO] 2/x: Fix wait queue race in drain_dac
Message-ID: <20031122071345.GA27303@gondor.apana.org.au>
References: <20031122070931.GA27231@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20031122070931.GA27231@gondor.apana.org.au>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

This patch fixes the value of swptr in case of an underrun/overrun.

Overruns/underruns probably won't occur at all when the driver is
fixed properly, but this doesn't hurt.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p2

Index: kernel-source-2.4/drivers/sound/i810_audio.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/sound/i810_audio.c,v
retrieving revision 1.9
diff -u -r1.9 i810_audio.c
--- kernel-source-2.4/drivers/sound/i810_audio.c	22 Nov 2003 07:05:27 -0000	1.9
+++ kernel-source-2.4/drivers/sound/i810_audio.c	22 Nov 2003 07:11:25 -0000
@@ -1445,8 +1445,8 @@
                         }
                         continue;
                 }
-		swptr = dmabuf->swptr;
 		cnt = i810_get_available_read_data(state);
+		swptr = dmabuf->swptr;
 		// this is to make the copy_to_user simpler below
 		if(cnt > (dmabuf->dmasize - swptr))
 			cnt = dmabuf->dmasize - swptr;
@@ -1589,8 +1589,8 @@
                         continue;
                 }
 
-		swptr = dmabuf->swptr;
 		cnt = i810_get_free_write_space(state);
+		swptr = dmabuf->swptr;
 		/* Bound the maximum size to how much we can copy to the
 		 * dma buffer before we hit the end.  If we have more to
 		 * copy then it will get done in a second pass of this

--EVF5PPMfhYS0aIcm--
