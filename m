Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266549AbUAWG6i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 01:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbUAWGzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 01:55:11 -0500
Received: from gate.crashing.org ([63.228.1.57]:42714 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266525AbUAWGst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 01:48:49 -0500
Subject: Re: logic error in radeonfb.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: davej@redhat.com
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <E1Ajuub-0000xr-00@hardwired>
References: <E1Ajuub-0000xr-00@hardwired>
Content-Type: text/plain
Message-Id: <1074840394.949.200.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 23 Jan 2004 17:46:35 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-23 at 17:35, davej@redhat.com wrote:
> Looks like another instance of a ! in the wrong place.

Ohh, and _oooold_ bug fixed a long time ago in 2.4. There may actually
be another occurence of this one elsewhere iirc. I'll check that. Note
that this code is powermac specific anyway and that old radeonfb doesn't
work very well on a lot of powermacs, so it's not very urgent. The new
radeonfb which has that fixed for a long time will get in along with
the fbdev updates as soon as I'm finished cleaning them up.

Ben.

>     Dave
> 
> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/video/radeonfb.c linux-2.5/drivers/video/radeonfb.c
> --- bk-linus/drivers/video/radeonfb.c	2004-01-21 15:58:42.000000000 +0000
> +++ linux-2.5/drivers/video/radeonfb.c	2004-01-21 17:48:54.000000000 +0000
> @@ -2319,7 +2319,7 @@ static int radeon_set_backlight_enable(i
>  	lvds_gen_cntl |= (LVDS_BL_MOD_EN | LVDS_BLON);
>  	if (on && (level > BACKLIGHT_OFF)) {
>  		lvds_gen_cntl |= LVDS_DIGON;
> -		if (!lvds_gen_cntl & LVDS_ON) {
> +		if (!(lvds_gen_cntl & LVDS_ON)) {
>  			lvds_gen_cntl &= ~LVDS_BLON;
>  			OUTREG(LVDS_GEN_CNTL, lvds_gen_cntl);
>  			(void)INREG(LVDS_GEN_CNTL);
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

