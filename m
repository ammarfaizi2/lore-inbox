Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVC2UrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVC2UrI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 15:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVC2UrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 15:47:07 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:55813 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261391AbVC2Uqb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 15:46:31 -0500
Date: Tue, 29 Mar 2005 22:46:30 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: James Courtier-Dutton <James@superbug.co.uk>, Takashi Iwai <tiwai@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Alsa-devel] Re: 2.6.12-rc1-mm3, sound card lost id
Message-Id: <20050329224630.069cda56.khali@linux-fr.org>
In-Reply-To: <1112127424.5141.7.camel@mindpipe>
References: <20050325002154.335c6b0b.akpm@osdl.org>
	<20050326111945.5eb58343.khali@linux-fr.org>
	<s5hr7hyiqra.wl@alsa2.suse.de>
	<20050329195721.385717aa.khali@linux-fr.org>
	<1112127424.5141.7.camel@mindpipe>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

> I think we just have to add this PCI id to the table.  I got the same
> result before James added the SBLive! platinum detection.
> 
> What is the output of 'lspci -v | grep -1 EMU10k1'?

00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 06)
        Subsystem: Creative Labs CT4832 SBLive! Value

and the one you didn't ask for:

00:0d.0 Class 0401: 1102:0002 (rev 06)
        Subsystem: 1102:8027

This made me realize that I could still try to hack it myself. The
following patch somehow helped:

--- linux-2.6.12-rc1-mm3/sound/pci/emu10k1/emu10k1_main.c.orig	2005-03-29 20:38:12.000000000 +0200
+++ linux-2.6.12-rc1-mm3/sound/pci/emu10k1/emu10k1_main.c	2005-03-29 22:32:23.000000000 +0200
@@ -680,6 +680,10 @@
 	 .driver = "EMU10K1", .name = "E-mu APS [4001]", 
 	 .emu10k1_chip = 1,
 	 .ecard = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80271102,
+	 .driver = "EMU10K1", .name = "SB Live Player 1024", 
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80641102,
 	 .driver = "EMU10K1", .name = "SB Live 5.1", 
 	 .emu10k1_chip = 1,


Now the card will be listed as "S1024" instead of "Unknown" so that's a
change. Looks like the short name is auto-generated? Unfortunately
that's still not "Live" as before so my mixer settings are not back yet.
And I believe that "Live" was a much better name than "S1024" too.

Thanks,
-- 
Jean Delvare
