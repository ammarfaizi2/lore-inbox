Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWFAJxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWFAJxb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 05:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWFAJxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 05:53:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:5563 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964834AbWFAJxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 05:53:31 -0400
X-Authenticated: #704063
Subject: [Patch] Check sound_alloc_mixerdev() failure in
	sound/oss/nm256_audio.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: mm@caldera.de
Content-Type: text/plain
Date: Thu, 01 Jun 2006 11:53:28 +0200
Message-Id: <1149155608.9452.1.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this was spotted by coverity, bug id #395.
When sound_alloc_mixerdev() fails it returns a
negative value, which the driver fails to check.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-rc5/sound/oss/nm256_audio.c.orig	2006-06-01 11:49:23.000000000 +0200
+++ linux-2.6.17-rc5/sound/oss/nm256_audio.c	2006-06-01 11:49:57.000000000 +0200
@@ -974,7 +974,7 @@ nm256_install_mixer (struct nm256_info *
 	return -1;
 
     mixer = sound_alloc_mixerdev();
-    if (num_mixers >= MAX_MIXER_DEV) {
+    if ((num_mixers >= MAX_MIXER_DEV) || (num_mixers < 0)) {
 	printk ("NM256 mixer: Unable to alloc mixerdev\n");
 	return -1;
     }


