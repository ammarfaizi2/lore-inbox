Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265650AbTA1PsH>; Tue, 28 Jan 2003 10:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267342AbTA1PsH>; Tue, 28 Jan 2003 10:48:07 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:25756 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S265650AbTA1PsG>;
	Tue, 28 Jan 2003 10:48:06 -0500
Date: Tue, 28 Jan 2003 16:57:19 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: =?iso-8859-2?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] in drivers/char/joystick/magellan.c
Message-ID: <20030128165719.A382@ucw.cz>
References: <20030128155312.GD10685@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030128155312.GD10685@wohnheim.fh-wedel.de>; from joern@wohnheim.fh-wedel.de on Tue, Jan 28, 2003 at 04:53:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 04:53:12PM +0100, Jörn Engel wrote:
> Hi!
> 
> Without the patch below, the \0 terminating the string is written
> anywhere. nibbles[] would be even better, I guess.

Well, the zero isn't used, so it might make sense to use '0', 'A', 'B' ...
... though that's not very nice either.

> Can you check for stupidity on my side?

Can't find any. ;) Patch applied with [].

> 
> Jörn
> 
> -- 
> But this is not to say that the main benefit of Linux and other GPL
> software is lower-cost. Control is the main benefit--cost is secondary.
> -- Bruce Perens
> 
> diff -Naur linux-2.4.21-pre3-ac4/drivers/char/joystick/magellan.c scratch/drivers/char/joystick/magellan.c
> --- linux-2.4.21-pre3-ac4/drivers/char/joystick/magellan.c	Thu Sep 13 00:34:06 2001
> +++ scratch/drivers/char/joystick/magellan.c	Mon Jan 27 13:49:54 2003
> @@ -66,7 +66,7 @@
>  
>  static int magellan_crunch_nibbles(unsigned char *data, int count)
>  {
> -	static unsigned char nibbles[16] = "0AB3D56GH9:K<MN?";
> +	static unsigned char nibbles[17] = "0AB3D56GH9:K<MN?";
>  
>  	do {
>  		if (data[count] == nibbles[data[count] & 0xf])

-- 
Vojtech Pavlik
SuSE Labs
