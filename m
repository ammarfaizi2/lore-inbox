Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315573AbSECG4g>; Fri, 3 May 2002 02:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315576AbSECG4f>; Fri, 3 May 2002 02:56:35 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:61679 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315573AbSECG4e>; Fri, 3 May 2002 02:56:34 -0400
Date: Fri, 3 May 2002 08:52:09 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: bjorn_helgaas@hp.com, Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] CONFIG_AGP_HP_ZX1 should only be available on ia64
Message-ID: <Pine.NEB.4.44.0205030848230.2605-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.4.19-pre8 adds the CONFIG_AGP_HP_ZX1 config option that should only be
available on ia64 but it was selectable on i386. The problem seems to be
that IIRC the dependency on a symbol in dep_bool doesn't work if the
symbol is neither set or unset.

The following patch should fix this (tested only on i386):


--- drivers/char/Config.in.old	Fri May  3 08:47:42 2002
+++ drivers/char/Config.in	Fri May  3 08:49:04 2002
@@ -260,7 +260,9 @@
    bool '  Generic SiS support' CONFIG_AGP_SIS
    bool '  ALI chipset support' CONFIG_AGP_ALI
    bool '  Serverworks LE/HE support' CONFIG_AGP_SWORKS
-   dep_bool '  HP ZX1 AGP support' CONFIG_AGP_HP_ZX1 $CONFIG_IA64
+   if [ "$CONFIG_IA64" = "y" ]; then
+      bool '  HP ZX1 AGP support' CONFIG_AGP_HP_ZX1
+   fi
 fi

 bool 'Direct Rendering Manager (XFree86 DRI support)' CONFIG_DRM


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

