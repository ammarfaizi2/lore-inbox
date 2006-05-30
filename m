Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWE3USS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWE3USS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 16:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWE3USR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 16:18:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:49858 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932460AbWE3USR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 16:18:17 -0400
X-Authenticated: #704063
Subject: [Patch] NULL pointer dereference in sound/synth/emux/soundfont.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: tiwai@suse.de
Content-Type: text/plain
Date: Tue, 30 May 2006 22:18:16 +0200
Message-Id: <1149020296.29430.4.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this is about coverity id #100.
It seems the if statement is negated, since the else branch calls
remove_info() with sflist->currsf as a parameter where it gets
dereferenced.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-rc4-git2/sound/synth/emux/soundfont.c.orig	2006-05-30 22:08:40.000000000 +0200
+++ linux-2.6.17-rc4-git2/sound/synth/emux/soundfont.c	2006-05-30 22:08:51.000000000 +0200
@@ -195,7 +195,7 @@ snd_soundfont_load(struct snd_sf_list *s
 		break;
 	case SNDRV_SFNT_REMOVE_INFO:
 		/* patch must be opened */
-		if (sflist->currsf) {
+		if (!sflist->currsf) {
 			snd_printk("soundfont: remove_info: patch not opened\n");
 			rc = -EINVAL;
 		} else {


