Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263816AbTJCQkY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 12:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbTJCQkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 12:40:24 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:28685 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S263816AbTJCQkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 12:40:19 -0400
From: Kees Bakker <kees.bakker@xs4all.nl>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [2.6.0-test6] Scratchy sound with via82xx (VT8233)
Date: Fri, 3 Oct 2003 18:40:17 +0200
User-Agent: KMail/1.5.1
References: <200309302046.47039.kees.bakker@xs4all.nl> <s5h7k3o0x8b.wl@alsa2.suse.de>
In-Reply-To: <s5h7k3o0x8b.wl@alsa2.suse.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xZaf/zX05dP1bvy"
Message-Id: <200310031840.17289.kees.bakker@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_xZaf/zX05dP1bvy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 02 October 2003 12:07, you wrote:
> At Tue, 30 Sep 2003 20:46:47 +0200,
>
> Kees Bakker wrote:
> > I saw the note about dxs_support, but I have the driver built-in. How do
> > I set dxs_support from the /proc/cmdline?
>
> pass via boot parameter:
>
>   snd-via82xx=1,0,,-1,48000,XXX
>
> where XXX is the value from 0 to 3 for dxs_support.
> see the comment in sound/via82xx.c.

Ah, I see. Well, I tested my VIA in another way. I applied this patch, which
adds it to the whitelist. So far it behaves OK. Are there any particular
tests that I can run to make sure?

Also, I want draw your attention to the fact that there DOES exist
a VIA8233-Pre in the wild. Here is my lspci output on my MSI KT266
motherboard:

iris:~ # cat /proc/asound/cards
0 [V8233Pre       ]: VIA8233 - VIA 8233-Pre
                     VIA 8233-Pre at 0xd000, irq 10

iris:~ # lspci -nv -s 00:11.5
00:11.5 Class 0401: 1106:3059 (rev 10)
        Subsystem: 1462:3800
        Flags: medium devsel, IRQ 10
        I/O ports at d000 [size=256]
        Capabilities: [c0] Power Management version 2

And in case it helps, here is the output from /proc/asound/devices:
iris:~ # cat /proc/asound/devices
  1:       : sequencer
  0: [0- 0]: ctl
 17: [0- 1]: digital audio playback
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
 33:       : timer

Let me know if you need more information.
		Kees

--Boundary-00=_xZaf/zX05dP1bvy
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="via82xx-add-kt266.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="via82xx-add-kt266.patch"

--- linux-2.6.0/sound/pci/via82xx.c.orig	2003-10-03 18:30:25.000000000 +0200
+++ linux-2.6.0/sound/pci/via82xx.c	2003-10-03 18:31:38.615792728 +0200
@@ -1969,6 +1969,7 @@
 	static struct dxs_whitelist whitelist[] = {
 		{ .vendor = 0x1019, .device = 0x0996, .action = VIA_DXS_48K },
 		{ .vendor = 0x1297, .device = 0xc160, .action = VIA_DXS_ENABLE }, /* Shuttle SK41G */
+		{ .vendor = 0x1462, .device = 0x3800, .action = VIA_DXS_ENABLE }, /* MSI KT266 */
 		{ } /* terminator */
 	};
 	struct dxs_whitelist *w;

--Boundary-00=_xZaf/zX05dP1bvy--

