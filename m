Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291839AbSBNTlh>; Thu, 14 Feb 2002 14:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291846AbSBNTl1>; Thu, 14 Feb 2002 14:41:27 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:3800 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S291839AbSBNTlS>; Thu, 14 Feb 2002 14:41:18 -0500
Message-ID: <3C6C12DC.7030406@linuxhq.com>
Date: Thu, 14 Feb 2002 14:41:16 -0500
From: John Weber <john.weber@linuxhq.com>
Organization: Linux Headquarters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020206
X-Accept-Language: en-us
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] YMFPCI Patches
In-Reply-To: <3C6BDE9A.4070906@linuxhq.com> <20020214125904.A2591@devserv.devel.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------010305000002050805070208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010305000002050805070208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Pete Zaitcev wrote:
>>Here's a patch (against 2.5.4) that makes a little change to 
>>sound/Config.in that makes my kernel link (and my YMF sound work :).
>>
> 
> Your mailer corrupted both of them

I am using Mozilla, so I don't know what it did to the patches.
I've sent them as attachments this time.

-- 
(o- j o h n   e   w e b e r
//\  http://www.linuxhq.com/people/weber/
v_/_ john.weber@linuxhq.com

--------------010305000002050805070208
Content-Type: text/plain;
 name="sound-2.5.4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sound-2.5.4.patch"

--- linux-2.5.4/drivers/sound/Config.in	Sun Feb 10 20:50:10 2002
+++ linux-2.5.5/drivers/sound/Config.in	Thu Feb 14 10:48:28 2002
@@ -103,6 +103,9 @@
 dep_tristate '  VIA 82C686 Audio Codec' CONFIG_SOUND_VIA82CXXX $CONFIG_PCI
 dep_mbool    '  VIA 82C686 MIDI' CONFIG_MIDI_VIA82CXXX $CONFIG_SOUND_VIA82CXXX
 
+dep_tristate '  Yamaha YMF7xx PCI audio (native mode)' CONFIG_SOUND_YMFPCI $CONFIG_PCI
+dep_mbool '      Yamaha PCI legacy ports support' CONFIG_SOUND_YMFPCI_LEGACY $CONFIG_SOUND_YMFPCI
+
 dep_tristate '  OSS sound modules' CONFIG_SOUND_OSS $CONFIG_SOUND
 
 if [ "$CONFIG_SOUND_OSS" = "y" -o "$CONFIG_SOUND_OSS" = "m" ]; then
@@ -164,8 +167,6 @@
    dep_tristate '    Yamaha FM synthesizer (YM3812/OPL-3) support' CONFIG_SOUND_YM3812 $CONFIG_SOUND_OSS
    dep_tristate '    Yamaha OPL3-SA1 audio controller' CONFIG_SOUND_OPL3SA1 $CONFIG_SOUND_OSS
    dep_tristate '    Yamaha OPL3-SA2 and SA3 based PnP cards' CONFIG_SOUND_OPL3SA2 $CONFIG_SOUND_OSS
-   dep_tristate '    Yamaha YMF7xx PCI audio (native mode)' CONFIG_SOUND_YMFPCI $CONFIG_SOUND_OSS $CONFIG_PCI
-   dep_mbool '      Yamaha PCI legacy ports support' CONFIG_SOUND_YMFPCI_LEGACY $CONFIG_SOUND_YMFPCI
    dep_tristate '    6850 UART support' CONFIG_SOUND_UART6850 $CONFIG_SOUND_OSS
   
    dep_tristate '    Gallant Audio Cards (SC-6000 and SC-6600 based)' CONFIG_SOUND_AEDSP16 $CONFIG_SOUND_OSS

--------------010305000002050805070208
Content-Type: text/plain;
 name="sound-2.5.5-pre1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sound-2.5.5-pre1.patch"

--- linux-2.5.4/sound/oss/Config.in	Thu Feb 14 11:00:32 2002
+++ linux-2.5.5/sound/oss/Config.in	Thu Feb 14 11:01:46 2002
@@ -103,6 +103,9 @@
 dep_tristate '  VIA 82C686 Audio Codec' CONFIG_SOUND_VIA82CXXX $CONFIG_PCI
 dep_mbool    '  VIA 82C686 MIDI' CONFIG_MIDI_VIA82CXXX $CONFIG_SOUND_VIA82CXXX
 
+dep_tristate '  Yamaha YMF7xx PCI audio (native mode)' CONFIG_SOUND_YMFPCI $CONFIG_PCI
+dep_mbool '    Yamaha PCI legacy ports support' CONFIG_SOUND_YMFPCI_LEGACY $CONFIG_SOUND_YMFPCI
+
 dep_tristate '  OSS sound modules' CONFIG_SOUND_OSS $CONFIG_SOUND
 
 if [ "$CONFIG_SOUND_OSS" = "y" -o "$CONFIG_SOUND_OSS" = "m" ]; then
@@ -164,8 +167,6 @@
    dep_tristate '    Yamaha FM synthesizer (YM3812/OPL-3) support' CONFIG_SOUND_YM3812 $CONFIG_SOUND_OSS
    dep_tristate '    Yamaha OPL3-SA1 audio controller' CONFIG_SOUND_OPL3SA1 $CONFIG_SOUND_OSS
    dep_tristate '    Yamaha OPL3-SA2 and SA3 based PnP cards' CONFIG_SOUND_OPL3SA2 $CONFIG_SOUND_OSS
-   dep_tristate '    Yamaha YMF7xx PCI audio (native mode)' CONFIG_SOUND_YMFPCI $CONFIG_SOUND_OSS $CONFIG_PCI
-   dep_mbool '      Yamaha PCI legacy ports support' CONFIG_SOUND_YMFPCI_LEGACY $CONFIG_SOUND_YMFPCI
    dep_tristate '    6850 UART support' CONFIG_SOUND_UART6850 $CONFIG_SOUND_OSS
   
    dep_tristate '    Gallant Audio Cards (SC-6000 and SC-6600 based)' CONFIG_SOUND_AEDSP16 $CONFIG_SOUND_OSS

--------------010305000002050805070208--

