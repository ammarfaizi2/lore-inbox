Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262536AbVEMUwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbVEMUwN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 16:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbVEMUvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 16:51:20 -0400
Received: from [212.45.14.9] ([212.45.14.9]:3281 "EHLO ari.home")
	by vger.kernel.org with ESMTP id S261465AbVEMUsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 16:48:03 -0400
Date: Sat, 14 May 2005 00:47:51 +0400 (MSD)
From: "Lev A. Melnikovsky" <leva@despammed.com>
To: ajoshi@kernel.crashing.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix radeonfb MAX_MAPPED_VRAM in 2.4.30
Message-ID: <Pine.LNX.4.62.0505140019290.7998@nev.ubzr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Starting from 2.4.29 (that is under 2.4.29 and 2.4.30) xorg fails to start 
fbdev driver on the top of radeonfb (ATI Radeon RV100 QY [Radeon 7000/VE]) 
and reports:

(EE) FBDEV(0): mmap fbmem: Invalid argument
(EE) FBDEV(0): Map vid mem failed

I've managed to repair it by doubling the MAX_MAPPED_VRAM define. The 
patch is attached.
-L.

--- drivers/video/radeonfb.c.orig       2005-01-19 17:10:10.000000000 +0300
+++ drivers/video/radeonfb.c    2005-05-07 17:55:03.000000000 +0400
@@ -176,7 +176,7 @@
  #define RTRACE         if(0) printk
  #endif

-#define MAX_MAPPED_VRAM (2048*2048*4)
+#define MAX_MAPPED_VRAM (2048*2048*8)
  #define MIN_MAPPED_VRAM (1024*768*1)

  enum radeon_chips {

