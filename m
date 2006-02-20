Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161134AbWBTUYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161134AbWBTUYj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 15:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161151AbWBTUYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 15:24:39 -0500
Received: from styx.suse.cz ([82.119.242.94]:3490 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1161134AbWBTUYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 15:24:38 -0500
Date: Mon, 20 Feb 2006 21:24:41 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i386 AT keyboard LED question.
Message-ID: <20060220202441.GB31272@suse.cz>
References: <200602202003.26642.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602202003.26642.nick@linicks.net>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 08:03:26PM +0000, Nick Warne wrote:

> Hi Vojtech,
> 
> I wondered why numlock LED goes off during boot process, even though I ask 
> BIOS to turn on;
> 
> atkbd.c
> 
> /*
>  * If the get ID command failed, we check if we can at least set the LEDs on
>  * the keyboard. This should work on every keyboard out there. It also turns
>  * the LEDs off, which we want anyway.
>  */
>                 param[0] = 0;
>                 if (ps2_command(ps2dev, param, ATKBD_CMD_SETLEDS))
>                         return -1;
> 
> 
> What is the rationale *why* we want LEDS off anyway?
 
Some old notebooks forget them on, which makes the keyboard unusable -
you get '4' instead of 'u', etc.

We can't read the LED state anyway (except for going to the BIOS data
structures, which isn't reasonable from the atkbd driver), and we need
to initialize it, so off is the safer default.

Further, this has been the behavior of Linux since it was first
implemented, and thus, in my rewrite of the keyboard handling, I didn't
change it.

It's trivial to change the default lock state in init scripts / xdm
config / X config, too.

-- 
Vojtech Pavlik
Director SuSE Labs
