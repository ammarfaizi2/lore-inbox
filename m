Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWH3WTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWH3WTA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWH3WSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:18:34 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:4561 "EHLO calculon.skynet.ie")
	by vger.kernel.org with ESMTP id S932175AbWH3WR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:17:57 -0400
Date: Wed, 30 Aug 2006 23:17:55 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [FOR 2.6.18 FIX][PATCH]  drm: radeon flush TCL VAP for vertex program
 enable/disable
Message-ID: <Pine.LNX.4.64.0608302314360.21600@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can we get this into 2.6.18? it fixes a lockup condition in r200 vertex 
programs.

From: Roland Scheidegger <rscheidegger_lists@hispeed.ch>

The radeon requires a VAP state flush when enabling/disabling
vertex programs on the r200 cards.

Signed-off-by: Dave Airlie <airlied@linux.ie>
---
  drivers/char/drm/radeon_state.c |    9 ++++++++-
  1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/char/drm/radeon_state.c b/drivers/char/drm/radeon_state.c
index 5bb2234..5a08a23 100644
--- a/drivers/char/drm/radeon_state.c
+++ b/drivers/char/drm/radeon_state.c
@@ -175,6 +175,14 @@ static __inline__ int radeon_check_and_f
  		}
  		break;

+	case R200_EMIT_VAP_CTL:{
+			RING_LOCALS;
+			BEGIN_RING(2);
+			OUT_RING_REG(RADEON_SE_TCL_STATE_FLUSH, 0);
+			ADVANCE_RING();
+		}
+		break;
+
  	case RADEON_EMIT_RB3D_COLORPITCH:
  	case RADEON_EMIT_RE_LINE_PATTERN:
  	case RADEON_EMIT_SE_LINE_WIDTH:
@@ -202,7 +210,6 @@ static __inline__ int radeon_check_and_f
  	case R200_EMIT_TCL_LIGHT_MODEL_CTL_0:
  	case R200_EMIT_TFACTOR_0:
  	case R200_EMIT_VTX_FMT_0:
-	case R200_EMIT_VAP_CTL:
  	case R200_EMIT_MATRIX_SELECT_0:
  	case R200_EMIT_TEX_PROC_CTL_2:
  	case R200_EMIT_TCL_UCP_VERT_BLEND_CTL:
-- 
1.4.1.gd3ba6

