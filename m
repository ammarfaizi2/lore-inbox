Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132415AbRAIX4J>; Tue, 9 Jan 2001 18:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132117AbRAIX4A>; Tue, 9 Jan 2001 18:56:00 -0500
Received: from typhoon.mail.pipex.net ([158.43.128.27]:61101 "HELO
	typhoon.mail.pipex.net") by vger.kernel.org with SMTP
	id <S132415AbRAIXzr>; Tue, 9 Jan 2001 18:55:47 -0500
From: Chris Rankin <rankinc@zip.com.au>
Message-Id: <200101092346.f09Nkp212258@wittsend.ukgateway.net>
Subject: Set ownership correctly for MPU401 synth operations
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Date: Tue, 9 Jan 2001 23:46:50 +0000 (GMT)
Reply-To: rankinc@zip.com.au
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="%--multipart-mixed-boundary-1.12249.979084010--%"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--%--multipart-mixed-boundary-1.12249.979084010--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

This patch makes the mpu401_synth_operations structure respect
attach_mpu401()'s "owner" parameter. This should prevent more sound
module from being accidentally unloaded.

Cheers,
Chris

--%--multipart-mixed-boundary-1.12249.979084010--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Description: ASCII text
Content-Disposition: attachment; filename="mpu401-3.diff"

--- linux-vanilla/drivers/sound/mpu401.c	Fri Jan  5 23:14:08 2001
+++ linux-2.4.0-ac3/drivers/sound/mpu401.c	Tue Jan  9 23:41:43 2001
@@ -1030,6 +1030,8 @@
 			(char *) &mpu401_synth_proto,
 			 sizeof(struct synth_operations));
 	}
+	if (owner)
+		mpu401_synth_operations[m]->owner = owner;
 
 	memcpy((char *) &mpu401_midi_operations[m],
 	       (char *) &mpu401_midi_proto,

--%--multipart-mixed-boundary-1.12249.979084010--%--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
