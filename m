Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268900AbRHKWvn>; Sat, 11 Aug 2001 18:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268898AbRHKWvc>; Sat, 11 Aug 2001 18:51:32 -0400
Received: from [24.64.63.13] ([24.64.63.13]:62449 "EHLO
	smail-cal.shawcable.com") by vger.kernel.org with ESMTP
	id <S268897AbRHKWvZ>; Sat, 11 Aug 2001 18:51:25 -0400
Date: Sat, 11 Aug 2001 15:25:57 -0700 (PDT)
From: Daniel Bertrand <d.bertrand@ieee.org>
Subject: Re: [Emu10k1-devel] [PATCH] EMU10K1: Juha Rjola's AC3 Passthrough for
 SMP kernels (against 2.4.8+Rui)
In-Reply-To: <Pine.A41.4.21L1.0108111506190.39342-200000@login3.isis.unc.edu>
X-X-Sender: <d_bertra@kilrogg>
To: "Daniel T. Chen" <crimsun@email.unc.edu>
Cc: linux-kernel@vger.kernel.org,
        emu10k1-devel <emu10k1-devel@opensource.creative.com>
Message-id: <Pine.LNX.4.33.0108111518130.959-100000@kilrogg>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For non-ac97 volume controls to work, the following needs to be added to
ac97_codec.c (or else the codec gets reset as the module tries to write a
volume to 0x00):


--- ac97_codec.c-orig	Sat Aug 11 15:13:20 2001
+++ ac97_codec.c	Sat Aug 11 15:17:15 2001
@@ -299,6 +299,9 @@
 	int scale;
 	struct ac97_mixer_hw *mh = &ac97_hw[oss_channel];

+	if (!mh->offset)
+		return;
+
 #ifdef DEBUG
 	printk("ac97_codec: wrote OSS mixer %2d (%s ac97 register 0x%02x), "
 	       "left vol:%2d, right vol:%2d:",




On Sat, 11 Aug 2001, Daniel T. Chen wrote:

> I've rediffed Juha's patch against 2.4.8+Rui's patch.
>
> ---
> Dan Chen                 crimsun@email.unc.edu
> GPG key: www.cs.unc.edu/~chenda/pubkey.gpg.asc
>

-- 
Daniel Bertrand

