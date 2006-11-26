Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967340AbWKZIdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967340AbWKZIdd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 03:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967341AbWKZIdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 03:33:33 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:19396 "EHLO
	vervifontaine.sonycom.com") by vger.kernel.org with ESMTP
	id S967340AbWKZIdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 03:33:32 -0500
Date: Sun, 26 Nov 2006 09:33:30 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Willy Tarreau <w@1wt.eu>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-2.4] fbcon: incorrect use of "&&" instead of "&"
In-Reply-To: <20061125212209.GA5918@1wt.eu>
Message-ID: <Pine.LNX.4.62.0611260933160.4055@pademelon.sonytel.be>
References: <20061125212209.GA5918@1wt.eu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2006, Willy Tarreau wrote:
> I'm about to merge this in 2.4. Do you have any objection ?

No.

Acked-By: Geert Uytterhoeven <geert@linux-m68k.org>

> >From c969fc8009aeb748368319cec463ae2516f6fb17 Mon Sep 17 00:00:00 2001
> From: Willy Tarreau <w@1wt.eu>
> Date: Sat, 25 Nov 2006 21:54:10 +0100
> Subject: [PATCH] fbcon: incorrect use of "&&" instead of "&"
> 
> The use of "&&" in the following statement causes unexpected
> cases to be matched since __SCROLL_YMASK = 0x0f :
> 
>     switch (p->scrollmode && __SCROLL_YMASK)
>         case __SCROLL_YWRAP: ...  /* 0x02 */
>         case __SCROLL_YPAN: ...   /* 0x01 */
> 
> The YWRAP case can never be matched and the YPAN case may be
> matched by mistake. Obvious fix is to replace && with &. This
> bug is not present in 2.6.
> 
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> ---
>  drivers/video/fbcon.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/fbcon.c b/drivers/video/fbcon.c
> index 0fb40c5..1f66819 100644
> --- a/drivers/video/fbcon.c
> +++ b/drivers/video/fbcon.c
> @@ -2102,7 +2102,7 @@ static int fbcon_scrolldelta(struct vc_d
>  
>      offset = p->yscroll-scrollback_current;
>      limit = p->vrows;
> -    switch (p->scrollmode && __SCROLL_YMASK) {
> +    switch (p->scrollmode & __SCROLL_YMASK) {
>  	case __SCROLL_YWRAP:
>  	    p->var.vmode |= FB_VMODE_YWRAP;
>  	    break;
> -- 
> 1.4.2.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
