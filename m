Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbTKOVsJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 16:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbTKOVsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 16:48:09 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:48658 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S262061AbTKOVsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 16:48:07 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: ramon.rey@hispalinux.es, linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test9-BK20] [ALSA] Unable to handle kernel paging request	at virtual address d08a7000
Organization: Core
In-Reply-To: <1068928939.1127.2.camel@debian>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.2-20031002 ("Berneray") (UNIX) (Linux/2.4.22-1-686-smp (i686))
Message-Id: <E1AL8Gk-0000Nr-00@gondolin.me.apana.org.au>
Date: Sun, 16 Nov 2003 08:47:50 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram?n Rey Vicente <rrey@ranty.pantax.net> wrote:
> 
> Running mplayer, I get this:
> 
> Unable to handle kernel paging request at virtual address d08a7000
> printing eip:
> d0947964
> *pde = 013f0067
> *pte = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<d0947964>]    Not tainted
> EFLAGS: 00210202
> EIP is at resample_expand+0x2e4/0x320 [snd_pcm_oss]

It's a gcc bug.  Until that's fixed, apply this patch.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
Index: kernel-source-2.5/sound/core/oss/Makefile
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/sound/core/oss/Makefile,v
retrieving revision 1.1.1.3
retrieving revision 1.2
diff -u -r1.1.1.3 -r1.2
--- kernel-source-2.5/sound/core/oss/Makefile	24 Feb 2003 19:05:06 -0000	1.1.1.3
+++ kernel-source-2.5/sound/core/oss/Makefile	11 Nov 2003 10:30:10 -0000	1.2
@@ -10,3 +10,5 @@
 
 obj-$(CONFIG_SND_MIXER_OSS) += snd-mixer-oss.o
 obj-$(CONFIG_SND_PCM_OSS) += snd-pcm-oss.o
+
+CFLAGS_rate.o := -fno-omit-frame-pointer
