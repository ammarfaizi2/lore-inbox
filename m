Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbTISLmH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 07:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbTISLmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 07:42:07 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:20367 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261522AbTISLmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 07:42:04 -0400
Date: Fri, 19 Sep 2003 13:41:58 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries.Brouwer@cwi.nl
Cc: akpm@osdl.org, torvalds@osdl.org, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] more keyboard stuff
Message-ID: <20030919114158.GC784@ucw.cz>
References: <UTC200309052322.h85NMi903303.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200309052322.h85NMi903303.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 06, 2003 at 01:22:44AM +0200, Andries.Brouwer@cwi.nl wrote:
> I looked a bit more at the keyboard code and find a bug
> and a probable bug.
> 
> (i) In case a synaptics touchpad has been detected, the comment
> says "disable AUX". But we do not set the disable bit, but
> instead .and. with the bit - no doubt getting zero.
> This must be a bug.
> 
> (ii) Directly above this is the suspicious comment
> "keyboard translation seems to be always off".
> But every machine comes always up in translated scancode 2.
> Translation is never off. But wait! by mistake the above .and.
> cleared the XLATE bit.
> 
> So, I think bug (i) explains mystery (ii).
> 
> However, note that this is code reading only.
> I do not have the hardware, so cannot test.
> 
> Andries
> 
> [line numbers will be off]

Thanks for spotting this. 

> diff -u --recursive --new-file -X /linux/dontdiff a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> --- a/drivers/input/serio/i8042.c	Sat Aug  9 22:16:42 2003
> +++ b/drivers/input/serio/i8042.c	Sat Sep  6 02:05:34 2003
> @@ -618,16 +619,10 @@
>  		(~param >> 4) & 0xf, ~param & 0xf);
>  
>  /*
> - * In MUX mode the keyboard translation seems to be always off.
> - */
> - 
> -	i8042_direct = 1;
> -
> -/*
>   * Disable all muxed ports by disabling AUX.
>   */
>  
> -	i8042_ctr &= I8042_CTR_AUXDIS;
> +	i8042_ctr |= I8042_CTR_AUXDIS;
>  	i8042_ctr &= ~I8042_CTR_AUXINT;
>  
>  	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR))

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
