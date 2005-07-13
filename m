Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVGMR3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVGMR3t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVGMR2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:28:20 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:24810 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261693AbVGMR01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:26:27 -0400
Date: Wed, 13 Jul 2005 19:26:25 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Kconfig: lxdialog: Enable UTF8
In-Reply-To: <1121274450.2975.12.camel@spirit>
Message-ID: <Pine.LNX.4.61.0507131916060.9023@yvahk01.tjqt.qr>
References: <1121273456.2975.3.camel@spirit> <1121274450.2975.12.camel@spirit>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


utf-8 enabled vc consoles (/dev/tty1) usually show line drawing 
graphics with the ascii set, e.g. + - and | for lxdialog (and many other apps 
btw)

The following patch brings back the real graphics for lxdialog, which are 
normally present in these cases:
- non-utf8 vc
- xterm (u8 / non-u8)

I've just exchanged -lncurses with -lncursesw and I got the linegraphs back. 
This simple trick can only be used with lxdialog, for some reason(?)

Patch notes: There seems to be no change or impact for non-UTF8 users; but 
someone using non-utf8 for vc please verify this.
Valid for many kernels in the 2.6.x series, including the "recent" 
2.6.13-rc1-git3-someBigNumber I use.


Signed-off-by: Jan Engelhardt <jengelh@linux01.gwdg.de>

diff -Pdpru S0706/scripts/lxdialog/Makefile AS17/scripts/lxdialog/Makefile
--- S0706/scripts/lxdialog/Makefile	2005-07-07 20:53:51.000000000 +0200
+++ AS17/scripts/lxdialog/Makefile	2005-07-09 11:31:08.000000000 +0200
@@ -2,7 +2,7 @@ HOST_EXTRACFLAGS := -DLOCALE 
 ifeq ($(shell uname),SunOS)
 HOST_LOADLIBES   := -lcurses
 else
-HOST_LOADLIBES   := -lncurses
+HOST_LOADLIBES   := -lncursesw
 endif
 
 ifeq (/usr/include/ncurses/ncurses.h, $(wildcard /usr/include/ncurses/ncurses.h))
