Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWH3WmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWH3WmE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWH3WmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:42:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56462 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932177AbWH3WmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:42:02 -0400
Date: Wed, 30 Aug 2006 15:41:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Airlie <airlied@linux.ie>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [FOR 2.6.18 FIX][PATCH]  drm: radeon flush TCL VAP for vertex
 program enable/disable
Message-Id: <20060830154152.9ac71753.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608302314360.21600@skynet.skynet.ie>
References: <Pine.LNX.4.64.0608302314360.21600@skynet.skynet.ie>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006 23:17:55 +0100 (IST)
Dave Airlie <airlied@linux.ie> wrote:

> 
> Can we get this into 2.6.18? it fixes a lockup condition in r200 vertex 
> programs.
> 
> From: Roland Scheidegger <rscheidegger_lists@hispeed.ch>
> 
> The radeon requires a VAP state flush when enabling/disabling
> vertex programs on the r200 cards.
> 
> Signed-off-by: Dave Airlie <airlied@linux.ie>
> ---
>   drivers/char/drm/radeon_state.c |    9 ++++++++-
>   1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/char/drm/radeon_state.c b/drivers/char/drm/radeon_state.c
> index 5bb2234..5a08a23 100644
> --- a/drivers/char/drm/radeon_state.c
> +++ b/drivers/char/drm/radeon_state.c
> @@ -175,6 +175,14 @@ static __inline__ int radeon_check_and_f
>   		}
>   		break;
> 
> +	case R200_EMIT_VAP_CTL:{
> +			RING_LOCALS;
> +			BEGIN_RING(2);
> +			OUT_RING_REG(RADEON_SE_TCL_STATE_FLUSH, 0);
> +			ADVANCE_RING();
> +		}
> +		break;
> +
>   	case RADEON_EMIT_RB3D_COLORPITCH:
>   	case RADEON_EMIT_RE_LINE_PATTERN:
>   	case RADEON_EMIT_SE_LINE_WIDTH:
> @@ -202,7 +210,6 @@ static __inline__ int radeon_check_and_f
>   	case R200_EMIT_TCL_LIGHT_MODEL_CTL_0:
>   	case R200_EMIT_TFACTOR_0:
>   	case R200_EMIT_VTX_FMT_0:
> -	case R200_EMIT_VAP_CTL:
>   	case R200_EMIT_MATRIX_SELECT_0:
>   	case R200_EMIT_TEX_PROC_CTL_2:
>   	case R200_EMIT_TCL_UCP_VERT_BLEND_CTL:

That's a somewhat weird-looking patch.  It adds code which is quite
dissimilar from all the other cases in that switch statement.

Are you sure??
