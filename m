Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272130AbRIMVSt>; Thu, 13 Sep 2001 17:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272163AbRIMVSj>; Thu, 13 Sep 2001 17:18:39 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:55549 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S272130AbRIMVSZ>; Thu, 13 Sep 2001 17:18:25 -0400
Date: Thu, 13 Sep 2001 22:18:34 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, dri-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>,
        mharris@redhat.com
Subject: Radeon lockup fix
Message-ID: <20010913221834.E29816@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've also been seeing the AMD-761 + radeon total lockup when X starts,
as described in

http://sourceforge.net/tracker/index.php?func=detail&aid=221904&group_id=387&atid=100387

The X server fixes from ATI seem to fix this when running without dri,
but in dri mode, I still see the lockups 75% of the time.  However,
the fix described above and appended below appears to be a complete
cure for me so far.

I'd like the opinion of the DRI folks about whether this should be in
the mainline kernel DRM, or if this is just a workaround for a problem
that still needs fixed elsewhere, but it certainly appears to work
fine for me.

--Stephen

--- linux/drivers/char/drm/radeon_cp.c.~1~	Wed Sep 12 15:14:40 2001
+++ linux/drivers/char/drm/radeon_cp.c	Wed Sep 12 15:16:00 2001
@@ -543,8 +543,7 @@
 						RADEON_SOFT_RESET_RE |
 						RADEON_SOFT_RESET_PP |
 						RADEON_SOFT_RESET_E2 |
-						RADEON_SOFT_RESET_RB |
-						RADEON_SOFT_RESET_HDP ) );
+						RADEON_SOFT_RESET_RB ) );
 	RADEON_READ( RADEON_RBBM_SOFT_RESET );
 	RADEON_WRITE( RADEON_RBBM_SOFT_RESET, ( rbbm_soft_reset &
 						~( RADEON_SOFT_RESET_CP |
@@ -553,8 +552,7 @@
 						   RADEON_SOFT_RESET_RE |
 						   RADEON_SOFT_RESET_PP |
 						   RADEON_SOFT_RESET_E2 |
-						   RADEON_SOFT_RESET_RB |
-						   RADEON_SOFT_RESET_HDP ) ) );
+						   RADEON_SOFT_RESET_RB ) ) );
 	RADEON_READ( RADEON_RBBM_SOFT_RESET );
 
 
