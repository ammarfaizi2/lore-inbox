Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266958AbTAKBOc>; Fri, 10 Jan 2003 20:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266972AbTAKBOc>; Fri, 10 Jan 2003 20:14:32 -0500
Received: from havoc.daloft.com ([64.213.145.173]:32726 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S266958AbTAKBOb>;
	Fri, 10 Jan 2003 20:14:31 -0500
Date: Fri, 10 Jan 2003 20:23:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: PATCH 2.4.21-pre: sb_mixer fix
Message-ID: <20030111012312.GA24847@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While writing als4000.c (SB16++ on PCI), I was using sb_mixer.c
[now... don't laugh].  I found what I think is a silly.

When building the recmask, the code loops from zero to
SOUND_MIXER_NRDEVICES, building up a bitmask to then write to the card.
Due to what I feel is an obvious scoping error, the present[buggy] code
writes the left and right recmask SOUND_MIXER_NRDEVICES times!  And with
an ever-changing bitmask, too...

Since the bitmask is eventually correct, this code works, but is really
stupid.  This patch corrects the scoping error.  Completely untested.


===== drivers/sound/sb_mixer.c 1.3 vs edited =====
--- 1.3/drivers/sound/sb_mixer.c	Tue Feb  5 02:49:26 2002
+++ edited/drivers/sound/sb_mixer.c	Wed Jan  8 17:31:25 2003
@@ -479,9 +479,9 @@
 						regimageL |= sb16_recmasks_L[i];
 						regimageR |= sb16_recmasks_R[i];
 					}
-					sb_setmixer (devc, SB16_IMASK_L, regimageL);
-					sb_setmixer (devc, SB16_IMASK_R, regimageR);
 				}
+				sb_setmixer (devc, SB16_IMASK_L, regimageL);
+				sb_setmixer (devc, SB16_IMASK_R, regimageR);
 			}
 			break;
 	}
