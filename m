Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263423AbTDNPBX (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 11:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbTDNPBW (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 11:01:22 -0400
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:16388 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id S263423AbTDNPBV (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 11:01:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
Message-Id: <200304141707.45601@gandalf>
To: Bill Huey (Hui) <billh@gnuppy.monkey.org>, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.67-mm3
Date: Mon, 14 Apr 2003 17:13:05 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030414015313.4f6333ad.akpm@digeo.com> <20030414110326.GA19003@gnuppy.monkey.org>
In-Reply-To: <20030414110326.GA19003@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 April 2003 13:03, Bill Huey (Hui) wrote:
> On Mon, Apr 14, 2003 at 01:53:13AM -0700, Andrew Morton wrote:
> > A bunch of new fixes, and a framebuffer update.  This should work a bit
> > better than -mm2.
> 
> make -f scripts/Makefile.build obj=arch/i386/boot arch/i386/boot/bzImage
>   ld -m elf_i386  -Ttext 0x0 -s --oformat binary -e begtext
>   arch/i386/boot/setup.o -o arch/i386/boot/setup 
>   arch/i386/boot/setup.o(.text+0x9a4): In function `video':
>   /tmp/ccyhvWWu.s:2925: undefined reference to `store_edid'
>   make[1]: *** [arch/i386/boot/setup] Error 1
>   make: *** [bzImage] Error 2
> 
> ---------------------------------------

got this also.
store_edid is only used when CONFIG_VIDEO_SELECT is set but the call to it is 
outside the #ifdef...

this patch fixes it. Maybe it is better to move the call to store_edid up 
inside the already avilable #ifdef but I'm not sure if that is possible

	Rudmer

--- linux-2.5.67-mm3/arch/i386/boot/video.S.orig	2003-04-14 
17:07:24.000000000 +0200
+++ linux-2.5.67-mm3/arch/i386/boot/video.S	2003-04-14 17:03:08.000000000 
+0200
@@ -135,7 +135,9 @@
 #endif /* CONFIG_VIDEO_RETAIN */
 #endif /* CONFIG_VIDEO_SELECT */
 	call	mode_params			# Store mode parameters
+#ifdef CONFIG_VIDEO_SELECT
 	call	store_edid
+#endif /* CONFIG_VIDEO_SELECT */
 	popw	%ds				# Restore original DS
 	ret
 

