Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132637AbRAFSSd>; Sat, 6 Jan 2001 13:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132630AbRAFSSX>; Sat, 6 Jan 2001 13:18:23 -0500
Received: from monsoon.mail.pipex.net ([158.43.128.69]:63987 "HELO
	monsoon.mail.pipex.net") by vger.kernel.org with SMTP
	id <S132623AbRAFSSH>; Sat, 6 Jan 2001 13:18:07 -0500
From: Chris Rankin <rankinc@zip.com.au>
Message-Id: <200101061813.f06ID3L07517@wittsend.ukgateway.net>
Subject: ENSONIQ SoundScape PNP - small patch
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Date: Sat, 6 Jan 2001 18:13:03 +0000 (GMT)
Reply-To: rankinc@zip.com.au
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="%--multipart-mixed-boundary-1.7509.978804783--%"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--%--multipart-mixed-boundary-1.7509.978804783--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

I have made further tweaks to the sscape module:
- removed two redundant calls to release_region()
- set the default MIDI volume(s?) to 100. These volume settings aren't
  accessible from any mixer I have. Therefore set them to "maximum" and
  use the volume control on the speaker instead.

Chris

--%--multipart-mixed-boundary-1.7509.978804783--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Description: C program text
Content-Disposition: attachment; filename="sscape-3.diff"

--- linux-vanilla/drivers/sound/sscape.c	Sun Nov 12 02:33:14 2000
+++ linux-2.4.0/drivers/sound/sscape.c	Sat Jan  6 17:58:03 2001
@@ -671,7 +673,7 @@
 		return;
 	}
 	
-	if (sscape_is_pnp == 0) {
+	if (!sscape_is_pnp) {
 	
 	    save_flags(flags);
 	    cli();
@@ -1087,8 +1089,8 @@
 		sscape_pnp_write_codec( devc, 10, (sscape_pnp_read_codec(devc, 10) & 0x7f) |
 		 ( sscape_mic_enable == 0 ? 0x00 : 0x80) );
 	}
-	sscape_write_host_ctrl2( devc, 0x84, 0x32 );
-	sscape_write_host_ctrl2( devc, 0x86, 0x32 );
+	sscape_write_host_ctrl2( devc, 0x84, 0x64 );  /* MIDI volume */
+	sscape_write_host_ctrl2( devc, 0x86, 0x64 );  /* MIDI volume?? */
 	sscape_write_host_ctrl2( devc, 0x8A, sscape_ext_midi);
 
 	sscape_pnp_write_codec ( devc, 6, 0x3f ); //WAV_VOL
@@ -1239,10 +1241,7 @@
 
 	sscape_pnp_write_codec( devc, 0, sscape_pnp_read_codec( devc, 0) | 0x20);
 	sscape_pnp_write_codec( devc, 0, sscape_pnp_read_codec( devc, 1) | 0x20);
-	
-	release_region(devc->codec, 2);
-	release_region(devc->base, 8);		
-		
+
 	return 1;	
 }
 

--%--multipart-mixed-boundary-1.7509.978804783--%--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
