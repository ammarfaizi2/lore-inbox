Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbVL2VE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbVL2VE4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 16:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbVL2VEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 16:04:42 -0500
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:52239 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1750982AbVL2VEU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 16:04:20 -0500
Date: Thu, 29 Dec 2005 22:07:30 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Linus Torvalds <torvalds@osdl.org>,
       Ricardo Cerqueira <v4l@cerqueira.org>, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com
Subject: Re: Recursive dependency for SAA7134 in 2.6.15-rc7
Message-Id: <20051229220730.1c22b1a4.khali@linux-fr.org>
In-Reply-To: <200512292119.10139.zippel@linux-m68k.org>
References: <20051227215351.3d581b13.khali@linux-fr.org>
	<200512292100.27536.zippel@linux-m68k.org>
	<20051229211350.4115b799.khali@linux-fr.org>
	<200512292119.10139.zippel@linux-m68k.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

> On Thursday 29 December 2005 21:13, Jean Delvare wrote:
> 
> > No, it wouldn't produce the desired effect anymore.
> >
> > (!VIDEO_SAA7134_ALSA || (VIDEO_SAA7134_ALSA=m && m)) makes it possible
> > to compile both OSS and ALSA support as modules. Simplifying to
> > !VIDEO_SAA7134_ALSA would make it impossible.
> 
> Did you try it?

I didn't back then, just did now, and oh surprise, you are right and I
am wrong... I should have known; after all, *you* wrote kconfig, right?
I checked Documentation/kbuild/kconfig-language.txt and it all makes
sense to me now, although I have to admit the word "counterintuitive"
came to my mind at first. I guess it's just a bit hard to switch to
tristate logic when you use boolean logic all day long.

So, I'm sorry for not verifying it all before I answered to you, and
even more sorry for submitting a less-than-optimal patch for inclusion.
He comes a fix. Linus, feel free to apply it now, or after 2.6.15 is
released, at your option - it's no more a bugfix, only an optimization.

Thanks.

* * * * *

Simplify the VIDEO_SAA7134_OSS Kconfig dependency line a bit. Thanks
to Roman Zippel for the suggestion.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/media/video/saa7134/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15-rc7.orig/drivers/media/video/saa7134/Kconfig	2005-12-29 22:01:20.000000000 +0100
+++ linux-2.6.15-rc7/drivers/media/video/saa7134/Kconfig	2005-12-29 22:04:24.000000000 +0100
@@ -25,7 +25,7 @@
 
 config VIDEO_SAA7134_OSS
 	tristate "Philips SAA7134 DMA audio support (OSS, DEPRECATED)"
-	depends on VIDEO_SAA7134 && SOUND_PRIME && (!VIDEO_SAA7134_ALSA || (VIDEO_SAA7134_ALSA=m && m))
+	depends on VIDEO_SAA7134 && SOUND_PRIME && !VIDEO_SAA7134_ALSA
 	---help---
 	  This is a video4linux driver for direct (DMA) audio in
 	  Philips SAA713x based TV cards using OSS


-- 
Jean Delvare
