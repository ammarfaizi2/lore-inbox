Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267787AbRGRCfN>; Tue, 17 Jul 2001 22:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267792AbRGRCfD>; Tue, 17 Jul 2001 22:35:03 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:48500 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S267787AbRGRCeq>; Tue, 17 Jul 2001 22:34:46 -0400
Date: Wed, 18 Jul 2001 04:35:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, dpicard@rcn.com, axboe@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH for Corrupted IO on all block devices
Message-ID: <20010718043506.B32411@athlon.random>
In-Reply-To: <3B54E85E.6E917925@psind.com> <Pine.LNX.4.33.0107171840550.1175-100000@penguin.transmeta.com> <15188.61164.315022.913819@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15188.61164.315022.913819@pizda.ninka.net>; from davem@redhat.com on Tue, Jul 17, 2001 at 07:05:32PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2001 at 07:05:32PM -0700, David S. Miller wrote:
> 
> Linus Torvalds writes:
>  > What filesystem do you see the bug with?
> 
> His report did specifically mention "databases".  But my initial
> impression was the same as yours, that this is a bug in the user.

it is:

--- corruption.c.orig	Wed Jul 18 04:14:15 2001
+++ corruption.c	Wed Jul 18 04:31:29 2001
@@ -22,7 +22,7 @@
                 int i, buffer[RD_BUFF_SZ];
 		fflush(fp);
                 fseek(fp, o, SEEK_SET);
-                fread(buffer, sizeof(int), sizeof(buffer), fp);
+                fread(buffer, 1, sizeof(buffer), fp);
                 printf("Validating end of file writes\n");
                 for(i = (RD_BUFF_SZ - 1); i >= 0; i--) {
                     assert(buffer[i] == --j) ;

Andrea
