Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbTFJKJL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 06:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTFJKHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 06:07:48 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:64721 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261678AbTFJKG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 06:06:58 -0400
Date: Tue, 10 Jun 2003 15:53:36 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Misc 2.5 Fixes: mem-leak-emu10k1
Message-ID: <20030610102336.GM2194@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030610100746.GC2194@in.ibm.com> <20030610100905.GD2194@in.ibm.com> <20030610100950.GE2194@in.ibm.com> <20030610101035.GF2194@in.ibm.com> <20030610101121.GG2194@in.ibm.com> <20030610101318.GH2194@in.ibm.com> <20030610101503.GI2194@in.ibm.com> <20030610101801.GJ2194@in.ibm.com> <20030610102024.GK2194@in.ibm.com> <20030610102255.GL2194@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030610102255.GL2194@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fix memory leak in emu10k1_audio_open.


 sound/oss/emu10k1/audio.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN sound/oss/emu10k1/audio.c~mem-leak-emu10k1 sound/oss/emu10k1/audio.c
--- linux-2.5.70-ds/sound/oss/emu10k1/audio.c~mem-leak-emu10k1	2003-06-08 22:55:56.000000000 +0530
+++ linux-2.5.70-ds-dipankar/sound/oss/emu10k1/audio.c	2003-06-08 22:57:33.000000000 +0530
@@ -1187,7 +1187,8 @@ match:
 
 		if ((woinst = (struct woinst *) kmalloc(sizeof(struct woinst), GFP_KERNEL)) == NULL) {
 			ERROR();
-			return -ENODEV;
+			kfree(wave_dev);
+			return -ENOMEM;
 		}
 
 		if (wave_dev->wiinst != NULL) {

_
