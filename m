Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314571AbSEQMFo>; Fri, 17 May 2002 08:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314596AbSEQMFo>; Fri, 17 May 2002 08:05:44 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:65270 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S314571AbSEQMFn>; Fri, 17 May 2002 08:05:43 -0400
Date: Fri, 17 May 2002 14:05:31 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.15-dj2
In-Reply-To: <20020517015859.GA523@suse.de>
Message-ID: <Pine.NEB.4.44.0205171402570.18435-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

I got the following during "make oldconfig":

<--  snip  -->

...
*
* PCMCIA/CardBus support
*
PCMCIA/CardBus support (CONFIG_PCMCIA) [M/n/y/?]
  CardBus support (CONFIG_CARDBUS) [Y/n/?]
  i82092 compatible bridge support (CONFIG_I82092) [M/n/?]
  i82365 compatible bridge support (CONFIG_I82365) [M/n/?]
  Databook TCIC host bridge support (CONFIG_TCIC) [M/n/?]
scripts/Configure: [: : unary operator expected
*
* PCI Hotplug Support
*
Support for PCI Hotplug (EXPERIMENTAL) (CONFIG_HOTPLUG_PCI) [M/n/y/?]
...

<--  snip  -->


The fix is simple:


--- drivers/pcmcia/Config.in.old	Fri May 17 14:00:17 2002
+++ drivers/pcmcia/Config.in	Fri May 17 14:00:43 2002
@@ -21,7 +21,7 @@
    if [ "$CONFIG_ARM" = "y" ]; then
      dep_tristate '  SA1100 support' CONFIG_PCMCIA_SA1100 $CONFIG_ARCH_SA1100 $CONFIG_PCMCIA
    fi
-   if [ "$CONFIG_8xx" ="y" ]; then
+   if [ "$CONFIG_8xx" = "y" ]; then
      tristate ' M8xx support' CONFIG_PCMCIA_M8XX
    fi
 fi


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

