Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932765AbVLIAYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932765AbVLIAYU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 19:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932766AbVLIAYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 19:24:20 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:13370 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932765AbVLIAYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 19:24:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sPLJFRfj6iUa6ftYyJDRbEzx7ZosMelDHWTk6/NAjNF3d6m0e7ardhE2+pd6b4vaJ1f9oBykSRV7pbWxg7cOAGXPnClto8r2CakPbINMcGptXOYn+H1wC2Qug0CJy74rDR/30dCHArmI0zaf5hF2PpxHymZoHHOvrvlvII5eMEE=
Message-ID: <4398CEAF.9050303@gmail.com>
Date: Fri, 09 Dec 2005 08:24:15 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Knut Petersen <Knut_Petersen@t-online.de>
CC: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/1 2.6.15-rc4-git1] Fix switching to KD_TEXT
References: <4398B888.50005@t-online.de>
In-Reply-To: <4398B888.50005@t-online.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Knut Petersen wrote:
>  Every framebuffer driver relies on the assumption that the set_par()
> function
> of the driver is called before drawing functions and other functions
> dependent
> on the hardware state are executed.
> 
> This assumption is false in two cases, and one is a genuine linux
> bug:
> 
>    1: Whenever you switch from X to a framebuffer console for the very
>        first time, there is a chance that a broken X system has _not_ set
>        the mode to KD_GRAPHICS, thus the vt and framebuffer code
>        executes a screen redraw and several other functions before a
>        set_par() is executed. This is believed to be not a bug of linux
>        but a bug of X/xdm.
> 
>    2: Whenever a switch from X to a framebuffer console occures,
>         the pan_display() function of the driver is called once before
>         the set_par() function of the driver is called. Code path:
>         complete_change_console -> redraw_screen -> fbcon_switch ->
>         bit_update_start-> fb_pan_display -> xyz_pan_display.
>         This is clearly a bug of linux.

This part, #2, can be easily fixed.

> 
> Although our primary goal must be to fix linux bugs and not to work
> around bugs of X, the patch fixes both of the cases.
> 
> The advantage and correctness of this patch should be obvious. Yes, it
> does add a possibly slow call to the fb_set_par() function, but at this
> point it is necessary.
> 
> Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>

Sorry, NAK for now.  Unless other people agree that it is okay for them
to have an unconditional call to set_par() for every console switch. Note
that the set_par() in some drivers is terribly slow (several seconds at least).

Let's wait a few days, if nobody disagrees with you, so be it.

Tony 
