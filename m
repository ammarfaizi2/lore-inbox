Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129878AbRAaKz4>; Wed, 31 Jan 2001 05:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130105AbRAaKzq>; Wed, 31 Jan 2001 05:55:46 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:64014 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129878AbRAaKzf>; Wed, 31 Jan 2001 05:55:35 -0500
Date: Wed, 31 Jan 2001 04:55:20 -0600
To: Arjan van de Ven <arjan@fenrus.demon.nl>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.1 -- Unresolved symbols in radio-miropcm20.o
Message-ID: <20010131045520.B32636@cadcamlab.org>
In-Reply-To: <3A772D3C.CB62DD4F@megapath.net> <m14NsuB-000OZJC@amadeus.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <m14NsuB-000OZJC@amadeus.home.nl>; from arjan@fenrus.demon.nl on Wed, Jan 31, 2001 at 09:46:19AM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Arjan van de Ven]
> Unfortionatly, this is impossible. The miropcm config question is
> asked before the "sound" question, and the aci question is asked
> after that (all in ake config).

"Impossible" is perhaps a poor choice of terms.  "Awkward" and "ugly"
are, however, quite descriptive. (:

Peter

diff -urk~ 2.4.1/drivers/sound/Config.in
--- 2.4.1/drivers/sound/Config.in~	Tue Jan 30 14:46:39 2001
+++ 2.4.1/drivers/sound/Config.in	Wed Jan 31 04:52:19 2001
@@ -91,7 +91,7 @@
    fi
    dep_tristate '    Aztech Sound Galaxy (non-PnP) cards' CONFIG_SOUND_SGALAXY $CONFIG_SOUND_OSS
    dep_tristate '    Adlib Cards' CONFIG_SOUND_ADLIB $CONFIG_SOUND_OSS
-   dep_tristate '    ACI mixer (miroPCM12)' CONFIG_SOUND_ACI_MIXER $CONFIG_SOUND_OSS
+   dep_tristate '    ACI mixer (miroPCM12)' CONFIG_SOUND_WANT_ACI_MIXER $CONFIG_SOUND_OSS
    dep_tristate '    Crystal CS4232 based (PnP) cards' CONFIG_SOUND_CS4232 $CONFIG_SOUND_OSS
    dep_tristate '    Ensoniq SoundScape support' CONFIG_SOUND_SSCAPE $CONFIG_SOUND_OSS
    dep_tristate '    Gravis Ultrasound support' CONFIG_SOUND_GUS $CONFIG_SOUND_OSS
@@ -179,3 +179,12 @@
 fi
 
 dep_tristate '  TV card (bt848) mixer support' CONFIG_SOUND_TVMIXER $CONFIG_SOUND $CONFIG_I2C
+
+# hack, hack
+if [ "$CONFIG_SOUND_WANT_ACI_MIXER" = "y" -o "$CONFIG_RADIO_MIROPCM20" = "y" ]; then
+   define_tristate CONFIG_SOUND_ACI_MIXER y
+else
+   if [ "$CONFIG_SOUND_WANT_ACI_MIXER" = "m" -o "$CONFIG_RADIO_MIROPCM20" = "m" ]; then
+      define_tristate CONFIG_SOUND_ACI_MIXER m
+   fi
+fi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
