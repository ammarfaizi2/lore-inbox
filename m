Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbVLaQQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbVLaQQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 11:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbVLaQQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 11:16:57 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:51920 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S964998AbVLaQQ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 11:16:57 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Sat, 31 Dec 2005 17:16:35 +0100
In-reply-to: <200500919343.923456789ble@anxur.fi.muni.cz>
Subject: [PATCH 3/4] media-radio: Maestro types change
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, atlka@pg.gda.pl
Message-Id: <20051231161634.67D371E3343@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maestro types change
[depends on Maestro Lindent]

__u16 --> u16 and so on

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit a6bf47a35d16fad6207effb37532466c57d20b28
tree 52defb3f608ab7309dac7fd63717f3f811bc98b3
parent f3f0d3e94b346e181a62de564506db1be00bb8ef
author <ku@bellona.(none)> Sat, 31 Dec 2005 17:01:25 +0100
committer <ku@bellona.(none)> Sat, 31 Dec 2005 17:01:25 +0100

 drivers/media/radio/radio-maestro.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/media/radio/radio-maestro.c b/drivers/media/radio/radio-maestro.c
--- a/drivers/media/radio/radio-maestro.c
+++ b/drivers/media/radio/radio-maestro.c
@@ -103,18 +103,18 @@ static struct video_device maestro_radio
 
 struct radio_device
 {
-	__u16	io,	/* base of Maestro card radio io (GPIO_DATA)*/
+	u16	io,	/* base of Maestro card radio io (GPIO_DATA)*/
 		muted,	/* VIDEO_AUDIO_MUTE */
 		stereo,	/* VIDEO_TUNER_STEREO_ON */	
 		tuned;	/* signal strength (0 or 0xffff) */
 	struct	semaphore lock;
 };
 
-static __u32 radio_bits_get(struct radio_device *dev)
+static u32 radio_bits_get(struct radio_device *dev)
 {
-	register __u16 io=dev->io, l, rdata;
-	register __u32 data=0;
-	__u16 omask;
+	register u16 io=dev->io, l, rdata;
+	register u32 data=0;
+	u16 omask;
 
 	omask = inw(io + IO_MASK);
 	outw(~(STR_CLK | STR_WREN), io + IO_MASK);
@@ -148,10 +148,10 @@ static __u32 radio_bits_get(struct radio
 	return data & 0x3ffe;
 }
 
-static void radio_bits_set(struct radio_device *dev, __u32 data)
+static void radio_bits_set(struct radio_device *dev, u32 data)
 {
-	register __u16 io=dev->io, l, bits;
-	__u16 omask, odir;
+	register u16 io=dev->io, l, bits;
+	u16 omask, odir;
 
 	omask = inw(io + IO_MASK);
 	odir  = (inw(io + IO_DIR) & ~STR_DATA) | (STR_CLK | STR_WREN);
@@ -231,8 +231,8 @@ static inline int radio_function(struct 
 		if (v->audio)
 			return -EINVAL;
 		{
-			register __u16 io = card->io;
-			register __u16 omask = inw(io + IO_MASK);
+			register u16 io = card->io;
+			register u16 omask = inw(io + IO_MASK);
 			outw(~STR_WREN, io + IO_MASK);
 			outw((card->muted = v->flags & VIDEO_AUDIO_MUTE) ?
 				STR_WREN : 0, io);
@@ -268,11 +268,11 @@ static int radio_ioctl(struct inode *ino
 	return ret;
 }
 
-static __u16 __devinit radio_power_on(struct radio_device *dev)
+static u16 __devinit radio_power_on(struct radio_device *dev)
 {
-	register __u16 io = dev->io;
-	register __u32 ofreq;
-	__u16 omask, odir;
+	register u16 io = dev->io;
+	register u32 ofreq;
+	u16 omask, odir;
 
 	omask = inw(io + IO_MASK);
 	odir = (inw(io + IO_DIR) & ~STR_DATA) | (STR_CLK | STR_WREN);
