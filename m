Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277119AbRJZBhr>; Thu, 25 Oct 2001 21:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277143AbRJZBhh>; Thu, 25 Oct 2001 21:37:37 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:49280 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S277119AbRJZBhZ>; Thu, 25 Oct 2001 21:37:25 -0400
Date: Fri, 26 Oct 2001 10:37:53 +0900
Message-ID: <7ktjw58u.wl@nisaaru.dvs.cs.fujitsu.co.jp>
From: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
To: "Michael F. Robbins" <compumike@compumike.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SiS/Trident 4DWave sound driver oops
In-Reply-To: <1004016263.1384.15.camel@tbird.robbins>
In-Reply-To: <1004016263.1384.15.camel@tbird.robbins>
User-Agent: Wanderlust/2.7.5 (Too Funky) EMY/1.13.9 (Art is long, life is short) SLIM/1.14.7 () APEL/10.3 MULE XEmacs/21.1 (patch 14) (Cuyahoga Valley) (i586-kondara-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

At 25 Oct 2001 09:24:21 -0400,
Michael F. Robbins <compumike@compumike.com> wrote:
> 
> I just grabbed 2.4.12-ac6 and the OOPS continues.  This is with
> soundcore, ac97_codec, and trident all built as modules.
> 
> Again, like my previous report (which was on Linus' 2.4.12), I can
> 'modprobe soundcore' and 'modprobe ac97_codec' with no problems.  Once I
> do the 'modprobe trident', I get the oops.  After the oops, the system
> is still responsive, and just like Stuart Young reported, the trident
> module is stuck in "initalizing".
> 
> See below for the details including the oops report itself.
> 
> Mike Robbins
> compumike@compumike.com
> (Please also cc your reply to me.)

  Following patch may fix your oops. Please try.


diff -u -r linux-2.4.12-ac5.org/drivers/sound/ac97_codec.c linux-2.4.12-ac5/drivers/sound/ac97_codec.c
--- linux-2.4.12-ac5.org/drivers/sound/ac97_codec.c	Mon Oct 22 09:34:21 2001
+++ linux-2.4.12-ac5/drivers/sound/ac97_codec.c	Fri Oct 26 10:26:41 2001
@@ -143,7 +143,6 @@
 	{0x83847656, "SigmaTel STAC9756/57",	&sigmatel_9744_ops},
 	{0x83847684, "SigmaTel STAC9783/84?",	&null_ops},
 	{0x57454301, "Winbond 83971D",		&null_ops},
-	{0,}
 };
 
 static const char *ac97_stereo_enhancements[] =
