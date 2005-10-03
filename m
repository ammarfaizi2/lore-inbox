Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbVJCB3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbVJCB3I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 21:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbVJCB3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 21:29:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19394 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932111AbVJCB3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 21:29:07 -0400
Date: Sun, 2 Oct 2005 21:28:44 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: alsa-devel@alsa-project.org, James@superbug.co.uk, perex@suse.cz
Subject: Re: [ALSA] snd-emu10k1: ALSA bug#1297: Fix a error recognising the SB Live Platinum.
Message-ID: <20051003012844.GA10453@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	alsa-devel@alsa-project.org, James@superbug.co.uk, perex@suse.cz
References: <200509131907.j8DJ7hMw024010@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509131907.j8DJ7hMw024010@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 12:07:43PM -0700, Linux Kernel wrote:
 > tree b885c7a937061624c7f7e34444122b96cced5c16
 > parent 1b44c28dc180f4d0ea109e1fe4339b3403c2d530
 > author James Courtier-Dutton <James@superbug.co.uk> Sat, 10 Sep 2005 10:24:10 +0200
 > committer Jaroslav Kysela <perex@suse.cz> Mon, 12 Sep 2005 10:48:32 +0200
 > 
 > [ALSA] snd-emu10k1: ALSA bug#1297: Fix a error recognising the SB Live Platinum.
 > 
 > EMU10K1/EMU10K2 driver
 > The card does not have an AC97 chip.
 > .subsystem = 0x80611102
 > 
 > Signed-off-by: James Courtier-Dutton <James@superbug.co.uk>
 > 
 >  sound/pci/emu10k1/emu10k1_main.c |    5 ++---
 >  1 files changed, 2 insertions(+), 3 deletions(-)
 > 
 > diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
 > --- a/sound/pci/emu10k1/emu10k1_main.c
 > +++ b/sound/pci/emu10k1/emu10k1_main.c
 > @@ -754,12 +754,11 @@ static emu_chip_details_t emu_chip_detai
 >  	 .emu10k1_chip = 1,
 >  	 .ac97_chip = 1,
 >  	 .sblive51 = 1} ,
 > -	/* Tested by alsa bugtrack user "hus" 12th Sept 2005 */
 > +	/* Tested by alsa bugtrack user "hus" bug #1297 12th Aug 2005 */
 >  	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80611102,
 > -	 .driver = "EMU10K1", .name = "SBLive! Player 5.1 [SB0060]", 
 > +	 .driver = "EMU10K1", .name = "SBLive! Platinum 5.1 [SB0060]", 
 >  	 .id = "Live",
 >  	 .emu10k1_chip = 1,
 > -	 .ac97_chip = 1,
 >  	 .sblive51 = 1} ,
 >  	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80511102,
 >  	 .driver = "EMU10K1", .name = "SBLive! Value [CT4850]", 

That last line change reverts..

tree efc4e418c80bf61beb2e1cfd1b2db405b471111f
parent 9970dce56686d7b71310388025d8925d3d29e6ec
author Takashi Iwai <tiwai@suse.de> Fri, 26 Aug 2005 17:26:40 +0200
committer Jaroslav Kysela <perex@suse.cz> Tue, 30 Aug 2005 08:47:46 +0200

[ALSA] emu10k1 - Add missing ac97 support on SBLive! Player 5.1

EMU10K1/EMU10K2 driver
Added the missing ac97 support on SBLive! Player 5.1.

And makes peoples volume sliders disappear, which tends to upset folks.
See https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=169152
for reference.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.13/sound/pci/emu10k1/emu10k1_main.c~	2005-10-02 21:26:40.000000000 -0400
+++ linux-2.6.13/sound/pci/emu10k1/emu10k1_main.c	2005-10-02 21:26:57.000000000 -0400
@@ -759,6 +759,7 @@ static emu_chip_details_t emu_chip_detai
 	 .driver = "EMU10K1", .name = "SBLive! Platinum 5.1 [SB0060]", 
 	 .id = "Live",
 	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80511102,
 	 .driver = "EMU10K1", .name = "SBLive! Value [CT4850]", 

