Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWCVV6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWCVV6L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWCVV6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:58:11 -0500
Received: from a1ihome1.kph.uni-mainz.de ([134.93.134.75]:21892 "EHLO
	a1ihome1.kph.uni-mainz.de") by vger.kernel.org with ESMTP
	id S932084AbWCVV6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:58:09 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Phillip Susi <psusi@cfl.rr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: VFAT: Can't create file named 'aux.h'?
References: <1142890822.5007.18.camel@localhost.localdomain>
	<20060320134533.febb0155.rdunlap@xenotime.net>
	<dvn835$lvo$1@terminus.zytor.com>
	<Pine.LNX.4.61.0603211840020.21376@yvahk01.tjqt.qr>
	<44203B86.5000003@zytor.com>
	<Pine.LNX.4.61.0603211854150.21376@yvahk01.tjqt.qr>
	<442050C8.1020200@zytor.com> <44205BC5.9040200@cfl.rr.com>
	<44206E1C.6090808@zytor.com>
Date: Wed, 22 Mar 2006 22:57:53 +0100
From: ulm@kph.uni-mainz.de (Ulrich Mueller)
Message-ID: <uveu62lcu@a1ihome1.kph.uni-mainz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> H. Peter Anvin wrote:

> Sounds like they should be able to be legitimately created.  If the
> shortnames are mangled, even DOS or Win9x could access them using the
> shortname.

This looks like a mount option is needed. Actually, FAT already has an
option "check={relaxed,normal,strict}".

For example, creation of these files could be enabled in case of
"check=relaxed" (the following is untested):

--- linux-2.6.16/fs/msdos/namei.c~	2006-03-20 12:32:03.000000000 +0100
+++ linux-2.6.16/fs/msdos/namei.c	2006-03-22 22:37:46.000000000 +0100
@@ -127,7 +127,7 @@
 	}
 	while (walk - res < MSDOS_NAME)
 		*walk++ = ' ';
-	if (!opts->atari)
+	if (!opts->atari && opts->name_check != 'r')
 		/* GEMDOS is less stupid and has no reserved names */
 		for (reserved = reserved_names; *reserved; reserved++)
 			if (!strncmp(res, *reserved, 8))

Cheers
Uli
