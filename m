Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751272AbWFESS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWFESS3 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 14:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWFESS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 14:18:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:12941 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750744AbWFESS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 14:18:28 -0400
X-Authenticated: #704063
Subject: Re: [Patch] Check sound_alloc_mixerdev() failure in
	sound/oss/nm256_audio.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, mm@caldera.de
In-Reply-To: <20060601170445.GA7265@martell.zuzino.mipt.ru>
References: <1149155608.9452.1.camel@alice>
	 <20060601170445.GA7265@martell.zuzino.mipt.ru>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 20:18:25 +0200
Message-Id: <1149531505.15988.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

> > -    if (num_mixers >= MAX_MIXER_DEV) {
> > +    if ((num_mixers >= MAX_MIXER_DEV) || (num_mixers < 0)) {
> 					     ^^^^^^^^^^
> >  	printk ("NM256 mixer: Unable to alloc mixerdev\n");
> >  	return -1;
> >      }
> 
> But it is _still_ fails to check it.

*yuck* I hope you keep count on the numbers of beers i owe you
by now. Here is an updated patch.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-rc5/sound/oss/nm256_audio.c.orig	2006-06-05 20:15:18.000000000 +0200
+++ linux-2.6.17-rc5/sound/oss/nm256_audio.c	2006-06-05 20:16:06.000000000 +0200
@@ -974,7 +974,7 @@ nm256_install_mixer (struct nm256_info *
 	return -1;
 
     mixer = sound_alloc_mixerdev();
-    if (num_mixers >= MAX_MIXER_DEV) {
+    if ((num_mixers >= MAX_MIXER_DEV) || (mixer < 0)) {
 	printk ("NM256 mixer: Unable to alloc mixerdev\n");
 	return -1;
     }


