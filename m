Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288047AbSBNPjK>; Thu, 14 Feb 2002 10:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291718AbSBNPjB>; Thu, 14 Feb 2002 10:39:01 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:21197 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S291717AbSBNPin>; Thu, 14 Feb 2002 10:38:43 -0500
Message-ID: <3C6BDA01.7050906@linuxhq.com>
Date: Thu, 14 Feb 2002 10:38:41 -0500
From: John Weber <john.weber@linuxhq.com>
Organization: Linux Headquarters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020206
X-Accept-Language: en-us
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.5-pre1 OSS YMFPCI
In-Reply-To: <mailman.1013655425.19267.linux-kernel2news@redhat.com> <200202140718.g1E7I0P02575@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
>>The ALSA YMFPCI driver doesn't seem to be functioning.
>>
> 
> Just curious... Can you enable the old OSS driver in the
> 2.5.5-pre1 kernel?
> 

I actually have been using the old OSS driver since I discovered that 
the ALSA driver wasn't working.

So, provided that I move the CONFIG_SOUND_YMFPCI option out from inside 
the 'OSS Sound Modules' section (which takes care of the link error 
caused by dmabuf.c use of virt_to_bus -- which occurs even when I 
disable persitent dma buffers), the OSS YMFPCI driver works perfectly.

Here's what I did to 2.5.5-pre1:

--- linux-2.5.4/sound/oss/Config.in     Thu Feb 14 10:32:40 2002
+++ linux-2.5.5/sound/oss/Config.in     Wed Feb 13 21:48:57 2002
@@ -103,6 +103,8 @@
  dep_tristate '  VIA 82C686 Audio Codec' CONFIG_SOUND_VIA82CXXX $CONFIG_PCI
  dep_mbool    '  VIA 82C686 MIDI' CONFIG_MIDI_VIA82CXXX 
$CONFIG_SOUND_VIA82CXXX

+dep_tristate '  Yamaha YMF7xx PCI audio (native mode)' 
CONFIG_SOUND_YMFPCI $CON
FIG_PCI
+
  dep_tristate '  OSS sound modules' CONFIG_SOUND_OSS $CONFIG_SOUND

  if [ "$CONFIG_SOUND_OSS" = "y" -o "$CONFIG_SOUND_OSS" = "m" ]; then
@@ -164,7 +166,6 @@
     dep_tristate '    Yamaha FM synthesizer (YM3812/OPL-3) support' 
CONFIG_SOUND
_YM3812 $CONFIG_SOUND_OSS
     dep_tristate '    Yamaha OPL3-SA1 audio controller' 
CONFIG_SOUND_OPL3SA1 $CO
NFIG_SOUND_OSS
     dep_tristate '    Yamaha OPL3-SA2 and SA3 based PnP cards' 
CONFIG_SOUND_OPL3
SA2 $CONFIG_SOUND_OSS
-   dep_tristate '    Yamaha YMF7xx PCI audio (native mode)' 
CONFIG_SOUND_YMFPCI
  $CONFIG_SOUND_OSS $CONFIG_PCI
     dep_mbool '      Yamaha PCI legacy ports support' 
CONFIG_SOUND_YMFPCI_LEGACY
  $CONFIG_SOUND_YMFPCI
     dep_tristate '    6850 UART support' CONFIG_SOUND_UART6850 
$CONFIG_SOUND_OSS



(o- j o h n   e   w e b e r
//\  http://www.linuxhq.com/people/weber/
v_/_ john.weber@linuxhq.com

