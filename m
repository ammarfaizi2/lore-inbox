Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268170AbUHKSqC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268170AbUHKSqC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 14:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268167AbUHKSpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 14:45:51 -0400
Received: from gate.perex.cz ([82.113.61.162]:31652 "EHLO mail.perex.cz")
	by vger.kernel.org with ESMTP id S268164AbUHKSpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 14:45:47 -0400
Date: Wed, 11 Aug 2004 20:42:05 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Stefan Schweizer <sschweizer@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix for ALSA AC'97 Init not working in post 2.6.7
 mm-kernels
In-Reply-To: <e7963922040811111655dc228e@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0408112041090.1788@pnote.perex-int.cz>
References: <e7963922040811111655dc228e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2004, Stefan Schweizer wrote:

> Hi,
> 
> I noticed that my soundcad stopped working in the mm-kernels after 2.6.7.
> The kernel log produces this message:
> 
> AC'97 0 does not respond - RESET
> 
> I grepped for it in the mm-patch and reverted the mm-changes there,
> that fixed it for me.

Could you try this patch?

Index: ac97_codec.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_codec.c,v
retrieving revision 1.143
diff -u -r1.143 ac97_codec.c
--- ac97_codec.c	10 Aug 2004 11:19:16 -0000	1.143
+++ ac97_codec.c	11 Aug 2004 18:43:00 -0000
@@ -1898,7 +1898,7 @@
 		else {
 			err = ac97_reset_wait(ac97, HZ/2, 0);
 			if (err < 0)
-				err = ac97_reset_wait(ac97, 0, 1);
+				err = ac97_reset_wait(ac97, HZ/2, 1);
 		}
 		if (err < 0) {
 			snd_printk(KERN_WARNING "AC'97 %d does not respond - RESET\n", ac97->num);

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
