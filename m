Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbTLRJbv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 04:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264968AbTLRJbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 04:31:51 -0500
Received: from mail.gmx.de ([213.165.64.20]:50316 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264966AbTLRJbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 04:31:48 -0500
Date: Thu, 18 Dec 2003 10:31:47 +0100 (MET)
From: "Martin Krohn" <martin.krohn@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: PCI-DMA problems
X-Priority: 3 (Normal)
X-Authenticated: #10158500
Message-ID: <22641.1071739907@www41.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am working on a non-standard platform and tried to enable
the PCI-Bus for this platform. The PCI bus is connected
via a PCI-V320USC bridge (quicklogic, formerly v-cubed)
to the local bus. The on-board SDRAM is connected to the
bridge and to the CPU. 
I used the existing bridge driver from the sh architechture
in kernel 2.4.22. Starting point for all other modification was kernel
2.4.16.

I used the 8139too.c driver (0.9.22) to test, what works.
I already did enable PCI-MEM-, PCI-I/O- and PCI-Configure-Space.
Now to my problem:
When the 8139 is doing a DMA-transfer at reception it is working only for a
few
frames. I enabled debugging and a 'normal' frame looks like this:
01 20 40 00 ff ff ff ff ff ff 00 60 08 57 5a a7 08 06 00 01 08 00 06 04 00
01 00 60 08 57 5a a7 c0 a8
00 1e 00 00 00 00 00 00 c0 a8 00 28 00 28 00 28 00 28 00 28 00 28 00 28 00
28 00 28 00 28 fe c1 ee 4b 00 00
For now I disabled the answer to the arp request, so the same frame is
received again and again.
After some (the number differs from time to time) frames a 'broken' frame
shows up:
01 20 40 00 ff ff ff ff ff ff 00 60 08 57 5a a7 08 06 00 01 08 00 06 04 00
01 00 60 08 57 5a a7 c0 a8
00 1e 00 00 00 00 00 00 c0 a8 00 28 00 28 00 28 00 28 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00
Here some padding bytes are zero. After this frame, the 8139 does not
produce Rx- IRQs anymore.
In the moment, when I pull the cable off the 8139-C is requesting an IRQ.
Also the Rx-Overflow IRQ is still working!
If I try lower burst sizes (RX_DMA_BURST) then I get lesser 'normal' frames.
At first I had problems, when I did not enable the internal V320USC-SDRAM
controller. The 8139-C always
answered with a Master-Abort. (This behavior was reasonable of course).

Now I also tried a es1371 based sound card. The problem here could be
similar. 
I am using version 0.31, also taken from 2.4.16. When I playback
a short sound (1 second @ 11025Hz samplerate) it plays correctly for the
first time.
It occours no interrupt, so the card won't stop playing. Finally the driver
waits forever in drain_dac2.


By the way, I did a successfull test with an old 8029 (wich is without
busmastering support.)
Where can I start my search? I must admit I don't have a PCI bus analyser.

Regards, 
 Martin Krohn.

-- 
+++ GMX - die erste Adresse für Mail, Message, More +++
Neu: Preissenkung für MMS und FreeMMS! http://www.gmx.net


