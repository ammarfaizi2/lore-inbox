Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbTEHGho (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 02:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbTEHGho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 02:37:44 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:16273 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S261183AbTEHGhm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 02:37:42 -0400
Date: Thu, 8 May 2003 08:50:01 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: r.a.mercer@blueyonder.co.uk
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix vesafb with large memory
In-Reply-To: <200305072004.h47K4Ud2026111@hera.kernel.org>
Message-ID: <Pine.GSO.4.21.0305080849010.12135-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003, Linux Kernel Mailing List wrote:
> ChangeSet 1.1199, 2003/05/06 22:04:11-03:00, r.a.mercer@blueyonder.co.uk
> 
> 	[PATCH] Fix vesafb with large memory
> 	
> 	Hi
> 	
> 	I've recently been having a problem with the vesafb refusing to boot on
> 	my system, after investigation the problem further I found that it had
> 	been mentioned on the 27 March 2003, in this thread
> 	
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=104878364823195&w=2
> 	
> 	In the thread Walt H, waltabbyh <at> comcast <dot> net, provides a fix.
> 	After just downloading 2.4.21-rc1 I noticed that this fix was not
> 	present. So heres a patch against 2.4.21-rc1 to fix this probelm.
> 	
> 	Please CC me with any responses as I'm not on the list.
> 	
> 	Cheers
> 	
> 	Adam
> 
> 
> # This patch includes the following deltas:
> #	           ChangeSet	1.1198  -> 1.1199 
> #	drivers/video/vesafb.c	1.7     -> 1.8    
> #
> 
>  vesafb.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff -Nru a/drivers/video/vesafb.c b/drivers/video/vesafb.c
> --- a/drivers/video/vesafb.c	Wed May  7 13:04:32 2003
> +++ b/drivers/video/vesafb.c	Wed May  7 13:04:32 2003
> @@ -520,7 +520,7 @@
>  	video_width         = screen_info.lfb_width;
>  	video_height        = screen_info.lfb_height;
>  	video_linelength    = screen_info.lfb_linelength;
> -	video_size          = screen_info.lfb_size * 65536;
> +	video_size          = screen_info.lfb_width *	screen_info.lfb_height * video_bpp;
>  	video_visual = (video_bpp == 8) ?
>  		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;

video_size must be in bytes, hence it must be

    video_size = screen_info.lfb_width*screen_info.lfb_height*video_bpp/8;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

