Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317011AbSFWLnt>; Sun, 23 Jun 2002 07:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317010AbSFWLns>; Sun, 23 Jun 2002 07:43:48 -0400
Received: from smtp1.wanadoo.nl ([194.134.35.136]:11995 "EHLO smtp1.wanadoo.nl")
	by vger.kernel.org with ESMTP id <S317008AbSFWLnr>;
	Sun, 23 Jun 2002 07:43:47 -0400
Message-Id: <5.1.0.14.0.20020623120538.00a01160@mail.science.uva.nl>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 23 Jun 2002 13:43:32 +0200
To: "Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>Dave Jones" <davej@suse.de>
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Subject: build failure for 2.5.24-dj1
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

upgraded in the usual way:
- store .config
- make mrproper
- put .config back
- make oldconfig
- make dep
- make KBUILD_VERBOSE= KBUILD_MODULES=1 bzImage

but this time the build failed due to undefined references to `key_maps', 
`keymap_count', `func_table', `funcbufsize', `funcbufleft', `funcbufptr', 
`accent_table_size', `accent_table' and `plain_map'

this is related to this warning during the build:
set -e ; loadkeys --mktable defkeymap.map | sed -e 's/^static *//' > 
defkeymap.c
/bin/sh: loadkeys: command not found
as all of these functions should be in defkeymap.c

upon inspection I found that with 'make mrproper' drivers/char/defkeymap.c 
is removed which it did not do in earlier kernels.
on my system 'loadkeys' is not installed because i did not have the kdb 
package installed (I did not need it). looking in Documentation/Changes of 
2.5.24-dj1 I could not find any reference to kdb so I think it should be 
added in the list of neccesary software since it is now!

	Rudmer

proposal (add it to the list of minimal requirements):

diff -u linux-2.5.24-dj1/Documentation/Changes.orig 
linux-2.5.24-dj1/Documentation/Changes
--- linux-2.5.24-dj1/Documentation/Changes.orig Sun Jun 23 13:34:26 2002
+++ linux-2.5.24-dj1/Documentation/Changes      Sun Jun 23 13:38:13 2002
@@ -59,7 +59,8 @@
  o  pcmcia-cs              3.1.21                  # cardmgr -V
  o  PPP                    2.4.0                   # pppd --version
  o  isdn4k-utils           3.1pre1                 # isdnctrl 2>&1|grep 
version
-
+o  kdb                    1.06                    # loadkeys --version
+
  Kernel compilation
  ==================

