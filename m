Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129295AbRBCU0f>; Sat, 3 Feb 2001 15:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129296AbRBCU0Q>; Sat, 3 Feb 2001 15:26:16 -0500
Received: from [195.154.83.81] ([195.154.83.81]:59401 "EHLO netgem.com")
	by vger.kernel.org with ESMTP id <S129295AbRBCU0F>;
	Sat, 3 Feb 2001 15:26:05 -0500
From: Jocelyn Mayer <jocelyn.mayer@netgem.com>
To: R.A.Reitsma@wbmt.tudelft.nl, linux-kernel@vger.kernel.org
Message-ID: <3A7C6949.3070705@netgem.com>
Date: Sat, 03 Feb 2001 21:25:45 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; 0.7) Gecko/20010119
X-Accept-Language: en, fr
MIME-Version: 1.0
Subject: Fix dependencies for radio-miropcm20
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I made a very little patch to avoid
people complaining that the kernel doesn't compile
properly when trying to use radio miropcm20 driver.
(I've seen some of this in french newsgroups...)

This driver always needs the ACI mixer,
so this feature should be enabled when we select
the miropcm driver.
For this, I think we have to change: (in 2.4.0 kernel)

--- Config.in-orig      Sat Feb  3 21:12:16 2001                        
                                                                        
                             
+++ Config.in   Sat Feb  3 21:18:48 2001                                
                                                                        
                             
@@ -22,7 +22,7 @@                                                       
                                                                        
                             
   hex '    GemTek i/o port (0x20c, 0x30c, 0x24c or 0x34c)' 
CONFIG_RADIO_GEMTEK_PORT 34c                                             
                                       
fi                                                                       
                                                                        
                           
dep_tristate '  Maestro on board radio' CONFIG_RADIO_MAESTRO 
$CONFIG_VIDEO_DEV                                                       
                                       
-dep_tristate '  Miro PCM20 Radio' CONFIG_RADIO_MIROPCM20 
$CONFIG_VIDEO_DEV                                                       
                                           
+dep_tristate '  Miro PCM20 Radio' CONFIG_RADIO_MIROPCM20 
$CONFIG_VIDEO_DEV $CONFIG_SOUND_ACI_MIXER                               
                                           
dep_tristate '  SF16FMI Radio' CONFIG_RADIO_SF16FMI $CONFIG_VIDEO_DEV    
                                                                        
                           
if [ "$CONFIG_RADIO_SF16FMI" = "y" ]; then                               
                                                                        
                           
   hex '    SF16FMI I/O port (0x284 or 0x384)' CONFIG_RADIO_SF16FMI_PORT 
284                                                                     
                           

With regards.

Jocelyn Mayer
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
