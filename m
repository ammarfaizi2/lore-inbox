Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130013AbRCJXh6>; Sat, 10 Mar 2001 18:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130253AbRCJXht>; Sat, 10 Mar 2001 18:37:49 -0500
Received: from adsl-63-200-86-10.dsl.scrm01.pacbell.net ([63.200.86.10]:19716
	"EHLO frx774.dhs.org") by vger.kernel.org with ESMTP
	id <S130013AbRCJXho>; Sat, 10 Mar 2001 18:37:44 -0500
From: Jesse Wyant <jrwyant@frx774.dhs.org>
Message-Id: <200103102336.f2ANac301221@frx774.dhs.org>
Subject: ac97_codec: AD1885 id 0x41445360 changed to 0x41445460 in 2.4.2-ac patches?
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sat, 10 Mar 2001 15:36:38 -0800 (PST)
Cc: linux-kernel@vger.kernel.org (lkml)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

Last night I moved from an old BX/PII board to an i815e/PIII
board (an Intel D815EEA with an AD1885 and onboard LAN enabled),
and in trying to set up my AC97 audio (there's an Analog Devices
AD1885 on the board), I found that the vanilla 2.4.2 kernel has
an id match for an AD1885 with a line like

  {0x41445360, "Analog Devices AD1885"  , enable_eapd},

in drivers/sound/ac97_codec.c, but in the -ac patches (I've
tried -ac16 and -ac17) that id has been changed to 0x41445460
which causes the ac97_codec module to not recognize the hardware
for the -ac series.  Here's the snippet from patch-2.4.2-ac17 which 
(the diff is on drivers/sound/ac97_codec.c) shows the change:

-----8<-----------------------------------------------------
 220108  } ac97_codec_ids[] = {
 220109 -   {0x414B4D00, "Asahi Kasei AK4540 rev 0", NULL},
 220110 -   {0x414B4D01, "Asahi Kasei AK4540 rev 1", NULL},
 220111 -   {0x41445340, "Analog Devices AD1881"  , NULL},
 220112 -   {0x41445360, "Analog Devices AD1885"  , enable_eapd},
 .
 .
 .
 220124 +   {0x41445303, "Analog Devices AD1819",   NULL},
 220125 +   {0x41445340, "Analog Devices AD1881",   NULL},
 220126 +   {0x41445348, "Analog Devices AD1881A",  NULL},
 220127 +   {0x41445460, "Analog Devices AD1885",   enable_eapd},
-----8<-----------------------------------------------------

So, in 2.4.2-ac1[67], a line like

  kernel: ac97_codec: AC97 Audio codec, id: 0x4144:0x5360 (Unknown)

shows up in '/var/log/messages', while with that ID in ac97_codec.c
changed back, I get this:

  kernel: ac97_codec: AC97 Audio codec, id: 0x4144:0x5360 (Analog Devices AD1885)

and then sound works after loading i810_audio.

My question is, why did the ID change in ac97_codec.c?  Am I
supposed to add some sort of switch to modules.conf to tell it
what chip I've got?  Is it just a typo (the AD1881 ID didn't
change)?

Thanks,

-jesse

Jesse Wyant - jrwyant@frx774.dhs.org
------------------------------------------------------------
I will not forget you.

