Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261694AbTCNJrX>; Fri, 14 Mar 2003 04:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261696AbTCNJrX>; Fri, 14 Mar 2003 04:47:23 -0500
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:46596 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP
	id <S261694AbTCNJrU>; Fri, 14 Mar 2003 04:47:20 -0500
From: "Ryan Underwood" <nemesis-lists@icequake.net>
To: linux-kernel@vger.kernel.org
Subject: matroxfb_maven not being built in 2.4.21-pre5
Date: Fri, 14 Mar 2003 09:58:06 +0000
X-Mailer: Pyne 0.6.9 (Linux)
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <20030314095807.C3CD5757B5@mail.icequake.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I compiled a fresh 2.4.21-pre5 yesterday after using make oldconfig
on my old .config.  Everything went smoothly for the most part,
except the matroxfb_maven.o and matroxfb_crtc2.o were not built.

The following changes to the Makefile are relevant:

< obj-$(CONFIG_FB_MATROX_MAVEN)     += matroxfb_maven.o matroxfb_crtc2.o
< obj-$(CONFIG_FB_MATROX_G450)    += matroxfb_g450.o matroxfb_crtc2.o
---
> ifeq ($(CONFIG_FB_MATROX_MAVEN),y)
>   obj-$(CONFIG_FB_MATROX)     += matroxfb_maven.o matroxfb_crtc2.o
> endif
> ifeq ($(CONFIG_FB_MATROX_G450),y)
>   obj-$(CONFIG_FB_MATROX)       += matroxfb_g450.o matroxfb_crtc2.o
> endif
> obj-$(CONFIG_FB_MATROX_PROC)    += matroxfb_proc.o

I think the problem stems from the fact that if maven is compiled as a module,
only CONFIG_FB_MATROX_MAVEN_MODULE is defined, not CONFIG_FB_MATROX_MAVEN.
In any case, if I explicitly add the objects to be compiled, they compile
and work fine.  So it looks like the conditional might need a little change.

Also, there does not seem to be a menuconfig entry for CONFIG_FB_MATROX_PROC.
Should there be?

-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253
