Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTH0Phw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 11:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263474AbTH0Phw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 11:37:52 -0400
Received: from mxrelay.osnanet.de ([212.95.97.103]:10939 "EHLO
	mxrelay.osnanet.de") by vger.kernel.org with ESMTP id S263464AbTH0Phe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 11:37:34 -0400
Message-ID: <3F4CCF85.1020502@lilymarleen.de>
Date: Wed, 27 Aug 2003 17:34:29 +0200
From: LGW <large@lilymarleen.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030711 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: porting driver to 2.6, still unknown relocs... :(
References: <3F4CB452.2060207@lilymarleen.de> <20030827081312.7563d8f9.rddunlap@osdl.org>
In-Reply-To: <20030827081312.7563d8f9.rddunlap@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

>On Wed, 27 Aug 2003 15:38:26 +0200 LGW <large@lilymarleen.de> wrote:
>
>| Now I wonder, what would be an relocation type 0? The printk should also 
>| print the type in clear text I think, but it just prints 0. 0 also does 
>| not look very much like a valid value at all, or does it?
>
>Maybe g++ generates something different?
>Are parts of your driver in c++?
>
I think the g++ is the problem, but I'm not sure what it is.

The driver is mostly a wrapper around a generic driver released by the 
manufacturer, and that's written in C++. But it worked like this for the 
2.4.x kernel series, so I think it has something todo with the new 
module loader code. Possibly ld misses something when linking the object 
specific stuff like constructors?

I don't think there are any other errors in the module (like 
incompatible MODULE_stuff or missing statements), as it has been copied 
from a patched alsa-0.9.6, and I diff'd the other drivers, not finding 
much differences (if any).

Any ld parameters I could try? I already tried -Ur, but that lead to 
nothing :(

thanks,
  Lars

>| // for the c++ helper files:
>| g++ -fno-rtti -Wall -Wstrict-prototypes -Wno-trigraphs -O2 
>| -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=athlon 
>| -Iinclude/asm-i386/mach-default -D__KERNEL__ -Iinclude  -Wall 
>| -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -nostdinc 
>| -iwithprefix include -DMODULE -Isound/pci/echoaudio/DSP 
>| -Isound/pci/echoaudio/ASIC -DGINA_20 -DECHO_LINUX -DECHOGALS_FAMILY  
>| -DKBUILD_BASENAME=echoaudio -DKBUILD_MODNAME=snd_echoaudio 
>| -I/usr/include -o $@.o $@.cpp
>| 
>| // linking echoaudio.o
>| ld -m elf_i386  -r -o sound/pci/echoaudio/snd-echoaudio.o 
>| sound/pci/echoaudio/echoaudio.o sound/pci/echoaudio/OsSupportLinux.o 
>| sound/pci/echoaudio/CDaffyDuck.o sound/pci/echoaudio/CEchoGals_info.o
>| sound/pci/echoaudio/CEchoGals_transport.o 
>| sound/pci/echoaudio/CPipeOutCtrl.o sound/pci/echoaudio/CEchoGals_mixer.o 
>| sound/pci/echoaudio/CMidiInQ.o sound/pci/echoaudio/CEchoGals_midi.o 
>| sound/pci/echoaudio/CEchoGals_power.o sound/pci/echoaudio/CEchoGals.o 
>| sound/pci/echoaudio/CLineLevel.o sound/pci/echoaudio/CMonitorCtrlL.o 
>| sound/pci/echoaudio/CChannelMask.o 
>| sound/pci/echoaudio/CGdDspCommObject.o 
>| sound/pci/echoaudio/CDspCommObject.o 
>| sound/pci/echoaudio/CGinaDspCommObject.o sound/pci/echoaudio/CGina.o
>| 
>| // linking snd-echoaudio.o
>| ld -m elf_i386  -r -o sound/pci/echoaudio/snd-echoaudio.o 
>| sound/pci/echoaudio/echoaudio.o sound/pci/echoaudio/OsSupportLinux.o 
>| sound/pci/echoaudio/CDaffyDuck.o sound/pci/echoaudio/CEchoGals_info.o
>| sound/pci/echoaudio/CEchoGals_transport.o 
>| sound/pci/echoaudio/CPipeOutCtrl.o sound/pci/echoaudio/CEchoGals_mixer.o 
>| sound/pci/echoaudio/CMidiInQ.o sound/pci/echoaudio/CEchoGals_midi.o 
>| sound/pci/echoaudio/CEchoGals_power.o sound/pci/echoaudio/CEchoGals.o 
>| sound/pci/echoaudio/CLineLevel.o sound/pci/echoaudio/CMonitorCtrlL.o 
>| sound/pci/echoaudio/CChannelMask.o 
>| sound/pci/echoaudio/CGdDspCommObject.o 
>| sound/pci/echoaudio/CDspCommObject.o 
>| sound/pci/echoaudio/CGinaDspCommObject.o sound/pci/echoaudio/CGina.o
>| 
>| // linking snd-echoaudio.ko
>| ld -m elf_i386 -r -o sound/pci/echoaudio/snd-echoaudio.ko 
>| sound/pci/echoaudio/snd-echoaudio.o sound/pci/echoaudio/snd-echoaudio.mod.o
>  
>

