Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbUJYN6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbUJYN6g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 09:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbUJYN6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 09:58:36 -0400
Received: from gprs187-64.eurotel.cz ([160.218.187.64]:13440 "EHLO
	midnight.suse.cz") by vger.kernel.org with ESMTP id S261801AbUJYN6G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 09:58:06 -0400
Date: Mon, 25 Oct 2004 15:57:43 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stelian Pop <stelian@popies.net>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Sonypi driver model & PM changes
Message-ID: <20041025135742.GA1733@ucw.cz>
References: <200410210154.58301.dtor_core@ameritech.net> <20041025125629.GF6027@crusoe.alcove-fr> <20041025135036.GA3161@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025135036.GA3161@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 03:50:36PM +0200, Stelian Pop wrote:

> The special keys are like KEY_BACK, KEY_HELP, KEY_ZOOM, KEY_CAMERA,
> and a dozen FN + some key combinations.
> 
> I can integrate those events into the input layer in 2 different ways:
> 
> * allocate a new key event (in include/linux/input.h) for each
>   key *and* combination. This will make the keys and the combinations
>   work both on the console and in X.
> 
>   Unfortunately only events under the 0xff limit seem to be
>   propagated to X, the other ones don't generate any X event (I haven't
>   looked at the problem but I suppose it somewhere into the X code).

The number is 240 and it's the number of possible PS/2 scancode
combinations, and since at this time X can only understand the PS/2
protocol (and not native Linux events), this is the only way how to pass
keypresses to X.

I believe that although this way may be easier, it leads to madness.

>   showkey does corectly see the keys in raw mode.
> 
> * allocate a FN key event and let FN be a modifier.
> 
>   This is much nicer (less events allocated in input.h), but I haven't
>   found a way (and I'm not sure there is one) to say to X that Fn is a 
>   *new* modifier. Yes, I can say FN act like a Control, Meta or whatever
>   existing modifier, but this is useless since I already have a Control,
>   Alt, etc. key on my keyboard. The whole point is to add support for 
>   a new key !
> 
>   I also haven't looked yet at adding a new modifier in the console
>   mode...
 
IIRC X has only 8 modifier keys and all are already defined and you
can't define any more. But I doubt you're using all of them on your
keyboard. It should be possible to assign Fn to one of them.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
