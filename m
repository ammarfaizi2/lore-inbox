Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129601AbQLMAML>; Tue, 12 Dec 2000 19:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130070AbQLMAMC>; Tue, 12 Dec 2000 19:12:02 -0500
Received: from adelphi.physics.adelaide.edu.au ([129.127.36.1]:21523 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id <S129601AbQLMALg>; Tue, 12 Dec 2000 19:11:36 -0500
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200012122345.KAA03292@bragg.physics.adelaide.edu.au>
Subject: PATCH: ALSxxx soundcard documentation update
To: linux-kernel@vger.kernel.org
Date: Wed, 13 Dec 2000 10:15:31 +1030 (CST)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

Here is a minor update to Documentation/sound/ALS which covers the PnP
issues with a little more clarity than is currently done.  It is for the
2.4.testXXX series and made against the ALS file from test10.

Regards
  jonathan

--- linux-2.4.test10-orig/Documentation/sound/ALS	Wed Apr 12 11:43:15 2000
+++ linux-2.4.test10/Documentation/sound/ALS	Tue Nov 21 09:07:04 2000
@@ -9,25 +9,42 @@
 as part of the Sound Blaster 16 driver (adding only 800 bytes to the
 SB16 driver).
 
-To use an ALS sound card under Linux, enable the following options in the
-sound configuration section of the kernel config:
+To use an ALS sound card under Linux, enable the following options as
+modules in the sound configuration section of the kernel config:
   - 100% Sound Blaster compatibles (SB16/32/64, ESS, Jazz16) support
   - FM synthesizer (YM3812/OPL-3) support 
+  - standalone MPU401 support may be required for some cards; for the
+    ALS-007, when using isapnptools, it is required
 Since the ALS-007/100/200 are PnP cards, ISAPnP support should probably be
-compiled in.
+compiled in.  If kernel level PnP support is not included, isapnptools will
+be required to configure the card before the sound modules are loaded.
 
-Alternatively, if you decide not to use kernel level ISAPnP, you can use the
-user mode isapnptools to wake up the sound card, as in 2.2.X. Set the "I/O 
-base for SB", "Sound Blaster IRQ" and "Sound Blaster DMA" (8 bit -
-either 0, 1 or 3) to the values used in your particular installation (they
-should match the values used to configure the card using isapnp).  The
-ALS-007 does NOT implement 16 bit DMA, so the "Sound Blaster 16 bit DMA"
-should be set to -1.  If you wish to use the external MPU-401 interface on
-the card, "MPU401 I/O base of SB16" and "SB MPU401 IRQ" should be set to
-the appropriate values for your installation.  (Note that the ALS-007
-requires a separate IRQ for the MPU-401, so don't specify -1 here).  (Note
-that the base port of the internal FM synth is fixed at 0x388 on the ALS007; 
-in any case the FM synth location cannot be set in the kernel configuration).
+When using kernel level ISAPnP, the kernel should correctly identify and
+configure all resources required by the card when the "sb" module is
+inserted.  Note that the ALS-007 does not have a 16 bit DMA channel and that
+the MPU401 interface on this card uses a different interrupt to the audio
+section.  This should all be correctly configured by the kernel; if problems
+with the MPU401 interface surface, try using the standalone MPU401 module,
+passing "0" as the "sb" module's "mpu_io" module parameter to prevent the
+soundblaster driver attempting to register the MPU401 itself.  The onboard
+synth device can be accessed using the "opl3" module.
+
+If isapnptools is used to wake up the sound card (as in 2.2.x), the settings
+of the card's resources should be passed to the kernel modules ("sb", "opl3"
+and "mpu401") using the module parameters.  When configuring an ALS-007, be
+sure to specify different IRQs for the audio and MPU401 sections - this card
+requires they be different.  For "sb", "io", "irq" and "dma" should be set
+to the same values used to configure the audio section of the card with
+isapnp.  "dma16" should be explicitly set to "-1" for an ALS-007 since this
+card does not have a 16 bit dma channel; if not specified the kernel will
+default to using channel 5 anyway which will cause audio not to work. 
+"mpu_io" should be set to 0.  The "io" parameter of the "opl3" module should
+also agree with the setting used by isapnp.  To get the MPU401 interface
+working on an ALS-007 card, the "mpu401" module will be required since this
+card uses separate IRQs for the audio and MPU401 sections and there is no
+parameter available to pass a different IRQ to the "sb" driver (whose
+inbuilt MPU401 driver would otherwise be fine).  Insert the mpu401 module
+passing appropriate values using the "io" and "irq" parameters.
 
 The resulting sound driver will provide the following capabilities:
   - 8 and 16 bit audio playback
@@ -45,3 +62,5 @@
 
 Modified 2000-02-26 by Dave Forrest, drf5n@virginia.edu to add ALS100/ALS200
 Modified 2000-04-10 by Paul Laufer, pelaufer@csupomona.edu to add ISAPnP info.
+Modified 2000-11-19 by Jonathan Woithe, jwoithe@physics.adelaide.edu.au
+ - updated information for kernel 2.4.x.


-- 
* Jonathan Woithe    jwoithe@physics.adelaide.edu.au                        *
*                    http://www.physics.adelaide.edu.au/~jwoithe            *
***-----------------------------------------------------------------------***
** "Time is an illusion; lunchtime doubly so"                              **
*  "...you wouldn't recognize a subtle plan if it painted itself purple     *
*   and danced naked on a harpsicord singing 'subtle plans are here again'" *
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
