Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbUC1L5Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 06:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbUC1L5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 06:57:24 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:60681 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261225AbUC1L5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 06:57:22 -0500
Date: Sun, 28 Mar 2004 13:57:18 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH-2.4.26] cmpci cleanup
Message-ID: <20040328115718.GB24421@pcw.home.local>
References: <20040328042608.GA17969@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328042608.GA17969@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

compiling cmpci in 2.4.26-rc1 complains :

cmpci.c: In function `cm_probe':
cmpci.c:3308: warning: unused variable `reg_mask'

Here is the patch. Please apply,
Willy

--- ./drivers/sound/cmpci.c.orig	Sun Mar 28 11:19:12 2004
+++ ./drivers/sound/cmpci.c	Sun Mar 28 11:19:44 2004
@@ -3305,7 +3305,6 @@
 	struct cm_state *s;
 	mm_segment_t fs;
 	int i, val, ret;
-	unsigned char reg_mask = 0;
 	struct {
 		unsigned short	deviceid;
 		char		*devicename;
@@ -3381,6 +3380,7 @@
 		printk(KERN_ERR "cmpci: io ports %#x-%#x in use\n", s->iomidi, s->iomidi+CM_EXTENT_MIDI-1);
 		s->iomidi = 0;
 	    } else {
+		unsigned char reg_mask = 0;
 		/* set IO based at 0x330 */
 		switch (s->iomidi) {
 		    case 0x330:
@@ -3415,6 +3415,7 @@
 		printk(KERN_ERR "cmpci: io ports %#x-%#x in use\n", s->iosynth, s->iosynth+CM_EXTENT_SYNTH-1);
 		s->iosynth = 0;
 	    } else {
+		unsigned char reg_mask = 0;
 		/* set IO based at 0x388 */
 		switch (s->iosynth) {
 		    case 0x388:
