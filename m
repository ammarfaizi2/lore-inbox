Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285607AbRLRF6U>; Tue, 18 Dec 2001 00:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285593AbRLRF6K>; Tue, 18 Dec 2001 00:58:10 -0500
Received: from ns2.generalbroadband.com ([64.32.62.5]:18958 "EHLO
	mx1.relaypoint.net") by vger.kernel.org with ESMTP
	id <S285591AbRLRF55>; Tue, 18 Dec 2001 00:57:57 -0500
To: linux-kernel@vger.kernel.org
From: Greg Pomerantz <gmp@alumni.brown.edu>
Subject: Re: i810_audio mono troubles
MIME-Version: 1.0
Content-Type: text/plain; name="patch-i810-mono-2.4.16"; charset="us-ascii"
Content-ID: <3745.1008651478.1@wwc.com>
Date: Mon, 17 Dec 2001 23:58:08 -0500
Message-ID: <auto-000001925289@mx1.relaypoint.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+++ drivers/sound/i810_audio.c	Mon Dec 17 23:15:19 2001
@@ -609,6 +609,9 @@
 	
 	new_rate = ac97_set_dac_rate(codec, rate);
 
+	if ((dmabuf->fmt & I810_FMT_STEREO) == 0)
+		new_rate *= 2;
+
 	if(new_rate != rate) {
 		dmabuf->rate = (new_rate * 48000)/clocking;
 	}
@@ -1687,6 +1690,12 @@
 		if (dmabuf->enable & ADC_RUNNING) {
 			stop_adc(state);
 		}
+
+		if (*(int *)arg == 0)
+			dmabuf->fmt &= ~I810_FMT_STEREO;
+		else
+			dmabuf->fmt |= I810_FMT_STEREO;
+
 		return put_user(1, (int *)arg);
 
 	case SNDCTL_DSP_GETBLKSIZE:
