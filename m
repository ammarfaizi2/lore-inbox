Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263923AbUACT37 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 14:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263927AbUACT36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 14:29:58 -0500
Received: from mail.actcom.net.il ([192.114.47.15]:26240 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S263923AbUACT3i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 14:29:38 -0500
Date: Sat, 3 Jan 2004 21:29:19 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Eugene Teo <eugene.teo@eugeneteo.net>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Muli Ben-Yehuda <mulix@mulix.org>
Subject: [PATCH trident] cleanup: use pr_debug instead of home-brewed TRDBG
Message-ID: <20040103192918.GT1718@actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zfSPj0+0wxNpTjLN"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zfSPj0+0wxNpTjLN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Howdy,=20

Yet another sound/oss/trident cleanup patch. This one replace the
TRDBG debugging macro with the standard pr_debug. Patch is from Eugene
Teo <eugene.teo@eugeneteo.net>, slightly modified by me to apply
against 2.6.0-rc1-mm1 with the other cleanup patches applied. =20

Patch compiles and tested. Please apply. No whitespace has been added
in the creation of this patch (I hope).=20

Incidentally, I had a patch to do this in 2.5, and then someone
"synched the driver with 2.4" and restored the TRDBG macro. I was too
amused to fix it at the time, but now is a good time to do it. I
wonder if we can kill it this time...=20

Cheers,
Muli=20

diff -Naur -X /home/muli/w/dontdiff 2.6.0-rc1-mm1/sound/oss/trident.c 2.6.0=
-trident/sound/oss/trident.c
--- 2.6.0-rc1-mm1/sound/oss/trident.c	Sat Jan  3 21:13:18 2004
+++ 2.6.0-trident/sound/oss/trident.c	Sat Jan  3 21:25:01 2004
@@ -37,6 +37,10 @@
  *	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
  *  History
+ *  v0.14.10j
+ *  	January 3 2004 Eugene Teo <eugeneteo@eugeneteo.net>
+ *  	minor cleanup to use pr_debug instead of TRDBG since it is already
+ *  	defined in linux/kernel.h.
  *  v0.14.10i=20
  *      December 29 2003 Muli Ben-Yehuda <mulix@mulix.org>=20
  *      major cleanup for 2.6, fix a few error patch buglets=20
@@ -223,7 +227,7 @@
=20
 #include "trident.h"
=20
-#define DRIVER_VERSION "0.14.10i-2.6"
+#define DRIVER_VERSION "0.14.10j-2.6"
=20
 /* magic numbers to protect our data structures */
 #define TRIDENT_CARD_MAGIC	0x5072696E	/* "Prin" */
@@ -550,8 +554,8 @@
=20
 	outl(global_control, TRID_REG(card, T4D_LFO_GC_CIR));
=20
-	TRDBG("trident: Enable Loop Interrupts, globctl =3D 0x%08X\n",=20
-	      inl(TRID_REG(card, T4D_LFO_GC_CIR)));
+	pr_debug("trident: Enable Loop Interrupts, globctl =3D 0x%08X\n",
+		 inl(TRID_REG(card, T4D_LFO_GC_CIR)));
=20
 	return 1;
 }
@@ -565,8 +569,8 @@
 	global_control &=3D ~(ENDLP_IE | MIDLP_IE);
 	outl(global_control, TRID_REG(card, T4D_LFO_GC_CIR));
=20
-	TRDBG("trident: Disabled Loop Interrupts, globctl =3D 0x%08X\n",=20
-	      global_control);
+	pr_debug("trident: Disabled Loop Interrupts, globctl =3D 0x%08X\n",
+		 global_control);
=20
 	return 1;
 }
@@ -584,9 +588,9 @@
=20
 #ifdef DEBUG
 	reg =3D inl(TRID_REG(card, addr));
-	TRDBG("trident: enabled IRQ on channel %d, %s =3D 0x%08x(addr:%X)\n",=20
-	      channel, addr =3D=3D T4D_AINTEN_B ? "AINTEN_B" : "AINTEN_A",=20
-	      reg, addr);
+	pr_debug("trident: enabled IRQ on channel %d, %s =3D 0x%08x(addr:%X)\n",
+		 channel, addr =3D=3D T4D_AINTEN_B ? "AINTEN_B" : "AINTEN_A",
+		 reg, addr);
 #endif /* DEBUG */
 }
=20
@@ -606,9 +610,9 @@
=20
 #ifdef DEBUG
 	reg =3D inl(TRID_REG(card, addr));
-	TRDBG("trident: disabled IRQ on channel %d, %s =3D 0x%08x(addr:%X)\n",=20
-	      channel, addr =3D=3D T4D_AINTEN_B ? "AINTEN_B" : "AINTEN_A",=20
-	      reg, addr);
+	pr_debug("trident: disabled IRQ on channel %d, %s =3D 0x%08x(addr:%X)\n",
+		 channel, addr =3D=3D T4D_AINTEN_B ? "AINTEN_B" : "AINTEN_A",
+		 reg, addr);
 #endif /* DEBUG */
 }
=20
@@ -627,9 +631,9 @@
=20
 #ifdef DEBUG
 	reg =3D inl(TRID_REG(card, addr));
-	TRDBG("trident: start voice on channel %d, %s =3D 0x%08x(addr:%X)\n",=20
-	      channel, addr =3D=3D T4D_START_B ? "START_B" : "START_A",=20
-	      reg, addr);
+	pr_debug("trident: start voice on channel %d, %s =3D 0x%08x(addr:%X)\n",
+		 channel, addr =3D=3D T4D_START_B ? "START_B" : "START_A",
+		 reg, addr);
 #endif /* DEBUG */
 }
=20
@@ -648,9 +652,9 @@
=20
 #ifdef DEBUG
 	reg =3D inl(TRID_REG(card, addr));
-	TRDBG("trident: stop voice on channel %d, %s =3D 0x%08x(addr:%X)\n",=20
-	      channel, addr =3D=3D T4D_STOP_B ? "STOP_B" : "STOP_A",=20
-	      reg, addr);
+	pr_debug("trident: stop voice on channel %d, %s =3D 0x%08x(addr:%X)\n",
+		 channel, addr =3D=3D T4D_STOP_B ? "STOP_B" : "STOP_A",
+		 reg, addr);
 #endif /* DEBUG */
 }
=20
@@ -670,8 +674,9 @@
=20
 #ifdef DEBUG
 	if (reg & mask)
-		TRDBG("trident: channel %d has interrupt, %s =3D 0x%08x\n",
-		      channel, reg =3D=3D T4D_AINT_B ? "AINT_B" : "AINT_A", reg);
+		pr_debug("trident: channel %d has interrupt, %s =3D 0x%08x\n",
+			 channel, reg =3D=3D T4D_AINT_B ? "AINT_B" : "AINT_A",
+			 reg);
 #endif /* DEBUG */=20
 	return (reg & mask) ? 1 : 0;
 }
@@ -689,8 +694,8 @@
=20
 #ifdef DEBUG
 	reg =3D inl(TRID_REG(card, T4D_AINT_B));
-	TRDBG("trident: Ack channel %d interrupt, AINT_B =3D 0x%08x\n",=20
-	      channel, reg);
+	pr_debug("trident: Ack channel %d interrupt, AINT_B =3D 0x%08x\n",
+		 channel, reg);
 #endif /* DEBUG */
 }
=20
@@ -950,7 +955,7 @@
=20
 	trident_write_voice_regs(state);
=20
-	TRDBG("trident: called trident_set_dac_rate : rate =3D %d\n", rate);
+	pr_debug("trident: called trident_set_dac_rate : rate =3D %d\n", rate);
=20
 	return rate;
 }
@@ -971,7 +976,7 @@
=20
 	trident_write_voice_regs(state);
=20
-	TRDBG("trident: called trident_set_adc_rate : rate =3D %d\n", rate);
+	pr_debug("trident: called trident_set_adc_rate : rate =3D %d\n", rate);
=20
 	return rate;
 }
@@ -1018,9 +1023,9 @@
 		/* stereo */
 		channel->control |=3D CHANNEL_STEREO;
=20
-	TRDBG("trident: trident_play_setup, LBA =3D 0x%08x, Delta =3D 0x%08x, "
-	      "ESO =3D 0x%08x, Control =3D 0x%08x\n", channel->lba,=20
-	      channel->delta, channel->eso, channel->control);
+	pr_debug("trident: trident_play_setup, LBA =3D 0x%08x, Delta =3D 0x%08x, "
+		 "ESO =3D 0x%08x, Control =3D 0x%08x\n", channel->lba,
+		 channel->delta, channel->eso, channel->control);
=20
 	trident_write_voice_regs(state);
 }
@@ -1105,9 +1110,9 @@
 		/* stereo */
 		channel->control |=3D CHANNEL_STEREO;
=20
-	TRDBG("trident: trident_rec_setup, LBA =3D 0x%08x, Delat =3D 0x%08x, "
-	      "ESO =3D 0x%08x, Control =3D 0x%08x\n", channel->lba,=20
-	      channel->delta, channel->eso, channel->control);
+	pr_debug("trident: trident_rec_setup, LBA =3D 0x%08x, Delat =3D 0x%08x, "
+		 "ESO =3D 0x%08x, Control =3D 0x%08x\n", channel->lba,
+		 channel->delta, channel->eso, channel->control);
=20
 	trident_write_voice_regs(state);
 }
@@ -1141,8 +1146,8 @@
 		return 0;
 	}
=20
-	TRDBG("trident: trident_get_dma_addr: chip reported channel: %d, "=20
-	      "cso =3D 0x%04x\n", dmabuf->channel->num, cso);
+	pr_debug("trident: trident_get_dma_addr: chip reported channel: %d, "
+		 "cso =3D 0x%04x\n", dmabuf->channel->num, cso);
=20
 	/* ESO and CSO are in units of Samples, convert to byte offset */
 	cso <<=3D sample_shift[dmabuf->fmt];
@@ -1268,8 +1273,8 @@
 					    &dmabuf->dma_handle)))
 		return -ENOMEM;
=20
-	TRDBG("trident: allocated %ld (order =3D %d) bytes at %p\n",
-	      PAGE_SIZE << order, order, rawbuf);
+	pr_debug("trident: allocated %ld (order =3D %d) bytes at %p\n",
+		 PAGE_SIZE << order, order, rawbuf);
=20
 	dmabuf->ready =3D dmabuf->mapped =3D 0;
 	dmabuf->rawbuf =3D rawbuf;
@@ -1415,11 +1420,11 @@
 		/* set the ready flag for the dma buffer */
 		dmabuf->ready =3D 1;
=20
-		TRDBG("trident: prog_dmabuf(%d), sample rate =3D %d, "
-		      "format =3D %d, numfrag =3D %d, fragsize =3D %d "
-		      "dmasize =3D %d\n", dmabuf->channel->num,=20
-		      dmabuf->rate, dmabuf->fmt, dmabuf->numfrag,=20
-		      dmabuf->fragsize, dmabuf->dmasize);
+		pr_debug("trident: prog_dmabuf(%d), sample rate =3D %d, "
+			 "format =3D %d, numfrag =3D %d, fragsize =3D %d "
+			 "dmasize =3D %d\n", dmabuf->channel->num,
+			 dmabuf->rate, dmabuf->fmt, dmabuf->numfrag,
+			 dmabuf->fragsize, dmabuf->dmasize);
 	}
 	unlock_set_fmt(state);
 	return 0;
@@ -1791,7 +1796,7 @@
 	/* FIXED: read interrupt status only once */
 	irq_status =3D inl(TRID_REG(card, T4D_AINT_A));
=20
-	TRDBG("cyber_address_interrupt: irq_status 0x%X\n", irq_status);
+	pr_debug("cyber_address_interrupt: irq_status 0x%X\n", irq_status);
=20
 	for (i =3D 0; i < NR_HW_CH; i++) {
 		channel =3D 31 - i;
@@ -1799,7 +1804,7 @@
 			/* clear bit by writing a 1, zeroes are ignored */
 			outl((1 << channel), TRID_REG(card, T4D_AINT_A));
=20
-			TRDBG("cyber_interrupt: channel %d\n", channel);
+			pr_debug("cyber_interrupt: channel %d\n", channel);
=20
 			if ((state =3D card->states[i]) !=3D NULL) {
 				trident_update_ptr(state);
@@ -1823,7 +1828,8 @@
 	spin_lock(&card->lock);
 	event =3D inl(TRID_REG(card, T4D_MISCINT));
=20
-	TRDBG("trident: trident_interrupt called, MISCINT =3D 0x%08x\n", event);
+	pr_debug("trident: trident_interrupt called, MISCINT =3D 0x%08x\n",
+		 event);
=20
 	if (event & ADDRESS_IRQ) {
 		card->address_interrupt(card);
@@ -1864,7 +1870,7 @@
 	unsigned swptr;
 	int cnt;
=20
-	TRDBG("trident: trident_read called, count =3D %d\n", count);
+	pr_debug("trident: trident_read called, count =3D %d\n", count);
=20
 	VALIDATE_STATE(state);
 	if (ppos !=3D &file->f_pos)
@@ -1921,10 +1927,10 @@
 			   which results in a (potential) buffer overrun. And worse, there is
 			   NOTHING we can do to prevent it. */
 			if (!interruptible_sleep_on_timeout(&dmabuf->wait, tmo)) {
-				TRDBG(KERN_ERR "trident: recording schedule timeout, "
-				      "dmasz %u fragsz %u count %i hwptr %u swptr %u\n",=20
-				      dmabuf->dmasize, dmabuf->fragsize, dmabuf->count,=20
-				      dmabuf->hwptr, dmabuf->swptr);
+				pr_debug(KERN_ERR "trident: recording schedule timeout, "
+					 "dmasz %u fragsz %u count %i hwptr %u swptr %u\n",
+					 dmabuf->dmasize, dmabuf->fragsize, dmabuf->count,
+					 dmabuf->hwptr, dmabuf->swptr);
=20
 				/* a buffer overrun, we delay the recovery until next time the
 				   while loop begin and we REALLY have space to record */
@@ -1982,7 +1988,7 @@
 	unsigned int copy_count;
 	int lret; /* for lock_set_fmt */=20
=20
-	TRDBG("trident: trident_write called, count =3D %d\n", count);
+	pr_debug("trident: trident_write called, count =3D %d\n", count);
=20
 	VALIDATE_STATE(state);
 	if (ppos !=3D &file->f_pos)
@@ -2054,11 +2060,11 @@
 			/* buffer underrun. And worse, there is NOTHING we */=20
 			/* can do to prevent it. */
 			if (!interruptible_sleep_on_timeout(&dmabuf->wait, tmo)) {
-				TRDBG(KERN_ERR "trident: playback schedule "
-				      "timeout, dmasz %u fragsz %u count %i "
-				      "hwptr %u swptr %u\n", dmabuf->dmasize,=20
-				      dmabuf->fragsize, dmabuf->count,=20
-				      dmabuf->hwptr, dmabuf->swptr);
+				pr_debug(KERN_ERR "trident: playback schedule "
+					 "timeout, dmasz %u fragsz %u count %i "
+					 "hwptr %u swptr %u\n", dmabuf->dmasize,
+					 dmabuf->fragsize, dmabuf->count,
+					 dmabuf->hwptr, dmabuf->swptr);
=20
 				/* a buffer underrun, we delay the recovery */=20
 				/* until next time the while loop begin and */=20
@@ -2249,8 +2255,8 @@
 =09
 	mapped =3D ((file->f_mode & (FMODE_WRITE | FMODE_READ)) && dmabuf->mapped=
);=20
=20
-	TRDBG("trident: trident_ioctl, command =3D %2d, arg =3D 0x%08x\n",
-	      _IOC_NR(cmd), arg ? *(int *) arg : 0);
+	pr_debug("trident: trident_ioctl, command =3D %2d, arg =3D 0x%08x\n",
+		 _IOC_NR(cmd), arg ? *(int *) arg : 0);
=20
 	switch (cmd) {
 	case OSS_GETVERSION:
@@ -2812,8 +2818,8 @@
 	state->open_mode |=3D file->f_mode & (FMODE_READ | FMODE_WRITE);
 	up(&card->open_sem);
=20
-	TRDBG("trident: open virtual channel %d, hard channel %d\n",=20
-	      state->virt, dmabuf->channel->num);
+	pr_debug("trident: open virtual channel %d, hard channel %d\n",
+		 state->virt, dmabuf->channel->num);
=20
 	return 0;
 }
@@ -2835,8 +2841,8 @@
 		drain_dac(state, file->f_flags & O_NONBLOCK);
 	}
=20
-	TRDBG("trident: closing virtual channel %d, hard channel %d\n",=20
-	      state->virt, dmabuf->channel->num);
+	pr_debug("trident: closing virtual channel %d, hard channel %d\n",
+		 state->virt, dmabuf->channel->num);
=20
 	/* stop DMA state machine and free DMA buffers/channels */
 	down(&card->open_sem);
@@ -3032,7 +3038,7 @@
 		udelay(20);
 	}
 	if (!block) {
-		TRDBG("accesscodecsemaphore: try unlock\n");
+		pr_debug("accesscodecsemaphore: try unlock\n");
 		block =3D 1;
 		goto unlock;
 	}
@@ -3115,7 +3121,7 @@
 		if (ncount <=3D 0)
 			break;
 		if (ncount-- =3D=3D 1) {
-			TRDBG("ali_ac97_read :try clear busy flag\n");
+			pr_debug("ali_ac97_read :try clear busy flag\n");
 			aud_reg =3D inl(TRID_REG(card, ALI_AC97_WRITE));
 			outl((aud_reg & 0xffff7fff),=20
 			     TRID_REG(card, ALI_AC97_WRITE));
@@ -3181,7 +3187,7 @@
 		if (ncount <=3D 0)
 			break;
 		if (ncount-- =3D=3D 1) {
-			TRDBG("ali_ac97_set :try clear busy flag!!\n");
+			pr_debug("ali_ac97_set :try clear busy flag!!\n");
 			outw(wcontrol & 0x7fff,=20
 			     TRID_REG(card, ALI_AC97_WRITE));
 		}
diff -Naur -X /home/muli/w/dontdiff 2.6.0-rc1-mm1/sound/oss/trident.h 2.6.0=
-trident/sound/oss/trident.h
--- 2.6.0-rc1-mm1/sound/oss/trident.h	Sat Jan  3 21:13:18 2004
+++ 2.6.0-trident/sound/oss/trident.h	Sat Jan  3 20:58:51 2004
@@ -355,16 +355,4 @@
 	return r;
 }
=20
-#ifdef DEBUG
-
-#define TRDBG(msg, args...) do {          \
-        printk(DEBUG msg , ##args );      \
-} while (0)
-
-#else /* !defined(DEBUG) */=20
-
-#define TRDBG(msg, args...) do { } while (0)
-
-#endif /* DEBUG */=20
-
 #endif /* __TRID4DWAVE_H */

--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

"the nucleus of linux oscillates my world" - gccbot@#offtopic


--zfSPj0+0wxNpTjLN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/9xgOKRs727/VN8sRAlnrAJ9ywQ6RCAg+OWBrmcavkj2R5YdyLQCghhbf
jvRTJXPk/9oKa/ICkfUExVY=
=t5is
-----END PGP SIGNATURE-----

--zfSPj0+0wxNpTjLN--
