Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbUANVmU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 16:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbUANVmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 16:42:20 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:27531 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263637AbUANVmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 16:42:17 -0500
Date: Wed, 14 Jan 2004 22:42:12 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: aebr@win.tue.nl, 1@pervalidus.net, linux-kernel@vger.kernel.org
Subject: Re: BUG: The key "/ ?" on my abtn2 keyboard is dead with kernel 2.6.1
Message-ID: <20040114214212.GA2485@ucw.cz>
References: <200401111545.59290.murilo_pontes@yahoo.com.br> <20040111235025.GA832@ucw.cz> <Pine.LNX.4.58.0401120004110.601@pervalidus.dyndns.org> <20040112083647.GB2372@ucw.cz> <20040112135655.A980@pclin040.win.tue.nl> <20040114142445.GA28377@ucw.cz> <20040114182202.GA32081@ucw.cz> <20040114120136.0f3f92ca.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114120136.0f3f92ca.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 12:01:36PM -0800, Andrew Morton wrote:
> 
> Vojtech Pavlik <vojtech@suse.cz> wrote:
> >
> >  Thus I propose this patch to make the 2.6 keycodes for Brazillian,
> >  Korean and Japanese keys compatible with 2.4.
> > 
> > 
> >  ChangeSet@1.1512, 2004-01-14 19:17:00+01:00, vojtech@suse.cz
> >    input: Move around Fxx and Japanese/Korean/Brazil keycode definitions
> >           to be compatible with 2.4.
> 
> This changes the table in drivers/char/keyboard.c in ways which conflict
> with the below patch.  It changes the same keycodes, but differently.  
> 
> Should the below patch be dropped, or is further resolution needed?

The patch below needs to be redone. I'll do it.

> From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> 
> Vojtech Pavlik <vojtech@suse.cz> writes:
> 
> > KEY_INTL2  182  /* Hiragana / Katakana */
> > KEY_INTL3  183  /* Yen */
> > 
> > These keycodes are translated back to the PS/2 scancodes in raw mode.
> 
> Sounds like 2.6.1 has the bug. 
> 
> Currently does,
> 
> HIRAGANA	INTL2(182)	7d
> YEN		INTL2(182)	7d
> 
> But, these should be
> 
> HIRAGANA	INTL2(182)	70
> YEN		INTL3(183)	7d
> 
> 
> 
> ---
> 
>  25-akpm/drivers/char/keyboard.c        |    2 +-
>  25-akpm/drivers/input/keyboard/atkbd.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff -puN drivers/char/keyboard.c~keyboard-scancode-fix drivers/char/keyboard.c
> --- 25/drivers/char/keyboard.c~keyboard-scancode-fix	Tue Jan 13 09:55:54 2004
> +++ 25-akpm/drivers/char/keyboard.c	Tue Jan 13 09:55:54 2004
> @@ -957,7 +957,7 @@ static unsigned short x86_keycodes[256] 
>  	360,261,262,263,298,376,100,101,321,316,373,286,289,102,351,355,
>  	103,104,105,275,287,279,306,106,274,107,294,364,358,363,362,361,
>  	291,108,381,281,290,272,292,305,280, 99,112,257,258,359,113,114,
> -	264,117,271,374,379,115,125,273,121,123, 92,265,266,267,268,269,
> +	264,117,271,374,379,115,112,125,121,123, 92,265,266,267,268,269,
>  	120,119,118,277,278,282,283,295,296,297,299,300,301,293,303,307,
>  	308,310,313,314,315,317,318,319,320,357,322,323,324,325,276,330,
>  	332,340,365,342,343,344,345,346,356,270,341,368,369,370,371,372 };
> diff -puN drivers/input/keyboard/atkbd.c~keyboard-scancode-fix drivers/input/keyboard/atkbd.c
> --- 25/drivers/input/keyboard/atkbd.c~keyboard-scancode-fix	Tue Jan 13 09:55:54 2004
> +++ 25-akpm/drivers/input/keyboard/atkbd.c	Tue Jan 13 09:55:54 2004
> @@ -61,7 +61,7 @@ static unsigned char atkbd_set2_keycode[
>  	  0, 49, 48, 35, 34, 21,  7, 89,  0,  0, 50, 36, 22,  8,  9, 90,
>  	  0, 51, 37, 23, 24, 11, 10,  0,  0, 52, 53, 38, 39, 25, 12,  0,
>  	  0,181, 40,  0, 26, 13,  0,  0, 58, 54, 28, 27,  0, 43,  0,194,
> -	  0, 86,193,192,184,  0, 14,185,  0, 79,182, 75, 71,124,  0,  0,
> +	  0, 86,193,192,184,  0, 14,185,  0, 79,183, 75, 71,124,  0,  0,
>  	 82, 83, 80, 76, 77, 72,  1, 69, 87, 78, 81, 74, 55, 73, 70, 99,
>  
>  	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
> 
> _
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
