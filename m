Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263791AbTI2REi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbTI2REi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:04:38 -0400
Received: from mail-4.tiscali.it ([195.130.225.150]:57057 "EHLO
	mail-4.tiscali.it") by vger.kernel.org with ESMTP id S263791AbTI2REe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:04:34 -0400
Date: Mon, 29 Sep 2003 19:04:37 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: perex@suse.cz
Subject: [2.6.0-test6] Troubles with ALSA via82xx
Message-ID: <20030929170437.GA805@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have trouble with linux-2.6.0-test6 and via82xx. With default
parameters I'm unable to play sound. I've tracked down the problem to
this change:

   - use dxs_support=3 (48k fixed) as default, since there are so many
     problems with dxs_support=0.

Loading module I see this:

via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 option and report if it works on your machine.
PCI: Setting latency timer of device 0000:00:11.5 to 64
         
and when I try to play anything the player locks and I see the
following messages:

ALSA sound/core/pcm_lib.c:2156: playback write error (DMA or IRQ trouble?)
ALSA sound/core/pcm_lib.c:2156: playback write error (DMA or IRQ trouble?)
ALSA sound/core/pcm_lib.c:2156: playback write error (DMA or IRQ trouble?)

dxs_support=1 doesn't help since I  have a VT8233A. dxs_support=2 is ok.
Looking at  the code I see  that VT8233A (without dsx)  and VT8233 (with
dsx) are selected  using dxs_support parameter. Is this the  only way to
do it? 2.6.0-t5 worked for me, not sure  that this is a bug but at least
it's a regression.

This is my audio device:

00:11.5 Class 0401: 1106:3059 (rev 40)
        Subsystem: 1695:3004
        Flags: medium devsel, IRQ 5
        I/O ports at e000 [size=256]
        Capabilities: [c0] Power Management version 2
                                

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Let me make your mind, leave yourself behind
Be not afraid
