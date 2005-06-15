Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVFOLPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVFOLPf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 07:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVFOLPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 07:15:35 -0400
Received: from styx.suse.cz ([82.119.242.94]:56014 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261405AbVFOLPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 07:15:22 -0400
Date: Wed, 15 Jun 2005 13:15:20 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] ALPS: fix enabling hardware tapping
Message-ID: <20050615111520.GB18773@ucw.cz>
References: <200506150138.49880.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506150138.49880.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 01:38:49AM -0500, Dmitry Torokhov wrote:
> Hi Linus, Vojtech,
> 
> It looks like logic for enabling hardware tapping in ALPS driver was
> inverted and we enable it only if it was already enabled by BIOS or
> firmware.
> 
> I have a confirmation from one user that the patch below fixes the
> problem for him and it might be beneficial if we could get it into
> 2.6.12.

Linus, Andrew, please include this patch. I don't have a git tree setup
yet for pulls, and it won't be ready before 2.6.12, however this patch
should definitely go in.

Thanks,
	Vojtech

> Thanks!
> 
> -- 
> Dmitry
> 
> ===================================================================
> 
> Input: ALPS - try enabling tap mode if it was disabled, not if
>        it is already enabled.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
>  drivers/input/mouse/alps.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> Index: work/drivers/input/mouse/alps.c
> ===================================================================
> --- work.orig/drivers/input/mouse/alps.c
> +++ work/drivers/input/mouse/alps.c
> @@ -364,7 +364,7 @@ static int alps_reconnect(struct psmouse
>  	if (alps_get_status(psmouse, param))
>  		return -1;
>  
> -	if (param[0] & 0x04)
> +	if (!(param[0] & 0x04))
>  		alps_tap_mode(psmouse, 1);
>  
>  	if (alps_absolute_mode(psmouse)) {
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
