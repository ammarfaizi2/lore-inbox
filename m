Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263373AbSJFKgx>; Sun, 6 Oct 2002 06:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263374AbSJFKgw>; Sun, 6 Oct 2002 06:36:52 -0400
Received: from nl-ams-slo-l4-02-pip-4.chellonetwork.com ([213.46.243.20]:39520
	"EHLO amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id <S263373AbSJFKgw>; Sun, 6 Oct 2002 06:36:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jos Hulzink <josh@stack.nl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.40: ALSA menuconfig bug traced
Date: Sun, 6 Oct 2002 12:42:23 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021006104223.QOUN1314.amsfep11-int.chello.nl@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The ALSA Menuconfig bug leads back to sound/Config.in

When you remove the entire if...fi block of CONFIG_SPARC64 or CONFIG_SPARC32 
of the ALSA submenu, everything seems to work. 

It seems to have nothing to do with the SPARC drivers though, for when I 
duplicate the if ... fi block of CONFIG_ISA (so there are two ISA entries in 
the submenu) after removing the SPARC(32, 64) block, the problems occur again.

Disabling CONFIG_ISA or CONFIG_PCI (the only options set "y" on my system) 
didn't help anything.

I checked the Config.in file for odd characters with a binary editor, but 
nothing was found.

Below you can find a "patch" that makes it work again. It is no solution 
though...

I don't understand it... All I can think of is that the parser goes crazy...

Jos

37,39c37,39
< if [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC64" = "y" ]; then
<   source sound/sparc/Config.in
< fi
---
> #if [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC64" = "y" ]; then
> #  source sound/sparc/Config.in
> #fi
[  endmenu

