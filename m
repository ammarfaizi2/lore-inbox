Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUIOHUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUIOHUk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 03:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUIOHUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 03:20:40 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:15303 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261602AbUIOHUi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 03:20:38 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 15 Sep 2004 09:08:41 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Peter Osterlund <petero2@telia.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc2
Message-ID: <20040915070841.GA29586@bytesex>
References: <Pine.LNX.4.58.0409130937050.4094@ppc970.osdl.org> <m3ekl5de7b.fsf@telia.com> <20040914094928.GF27258@bytesex> <m33c1kxz3f.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m33c1kxz3f.fsf@telia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I found the change that crashes my computer. This patch is enough to
> fix it for me:
> 
> -			if (!yoffset)
> -				chroma = (line & 1) == 0;
> -			else
> -				chroma = (line & 1) == 1;

Does the one below work as well?

  Gerd

RCS file: /home/cvsroot/video4linux/bttv-risc.c,v
retrieving revision 1.4
diff -u -p -r1.4 bttv-risc.c
--- bttv-risc.c	23 Aug 2004 10:38:54 -0000	1.4
+++ bttv-risc.c	15 Sep 2004 07:05:44 -0000
@@ -154,15 +154,15 @@ bttv_risc_planar(struct bttv *btv, struc
 			break;
 		case 1:
 			if (!yoffset)
-				chroma = (line & 1) == 0;
+				chroma = ((line & 1) == 0);
 			else
-				chroma = (line & 1) == 1;
+				chroma = ((line & 1) == 1);
 			break;
 		case 2:
 			if (!yoffset)
-				chroma = (line & 3) == 0;
+				chroma = ((line & 3) == 0);
 			else
-				chroma = (line & 3) == 2;
+				chroma = ((line & 3) == 2);
 			break;
 		default:
 			chroma = 0;
