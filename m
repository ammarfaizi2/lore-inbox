Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbUKMQiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbUKMQiJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 11:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbUKMQiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 11:38:09 -0500
Received: from hera.cwi.nl ([192.16.191.8]:40942 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261866AbUKMQiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 11:38:05 -0500
Date: Sat, 13 Nov 2004 17:38:00 +0100 (MET)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <200411131638.iADGc0p09242@apps.cwi.nl>
To: akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] __devinit in sound/oss/es1371.c
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is forbidden to refer from __devinit to __init.
(Unless one argues that in the given situation hotplugging is
actually impossible. Too ugly.)
However, es1371_probe() is __devinit and referred to __initdata initvol[]
and to __init src_init().

diff -uprN -X /linux/dontdiff a/sound/oss/es1371.c b/sound/oss/es1371.c
--- a/sound/oss/es1371.c	2004-08-26 22:05:52.000000000 +0200
+++ b/sound/oss/es1371.c	2004-11-13 17:11:31.000000000 +0100
@@ -637,7 +637,7 @@ static void set_dac2_rate(struct es1371_
 
 /* --------------------------------------------------------------------- */
 
-static void __init src_init(struct es1371_state *s)
+static void __devinit src_init(struct es1371_state *s)
 {
         unsigned int i;
 
@@ -2754,7 +2754,7 @@ MODULE_LICENSE("GPL");
 static struct initvol {
 	int mixch;
 	int vol;
-} initvol[] __initdata = {
+} initvol[] __devinitdata = {
 	{ SOUND_MIXER_WRITE_LINE, 0x4040 },
 	{ SOUND_MIXER_WRITE_CD, 0x4040 },
 	{ MIXER_WRITE(SOUND_MIXER_VIDEO), 0x4040 },
