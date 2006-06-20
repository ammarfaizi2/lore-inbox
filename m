Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbWFTBJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbWFTBJj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 21:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbWFTBJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 21:09:39 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:39928 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965032AbWFTBJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 21:09:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=p8cnC89mGmgMQz5Th72vNRULFj9Bp6joLjd2o9jwd6HqJYHGPQ1OS2kt3lWvzk3lDPCZjIAU2PTB/XI0TSljGLhnZqNrkLQRrBFjpVAv58DUjyp7uKIm+k0CAspKPhUyWG7YQAiaNCi03NqlUD1Ijmc1EN/foU9nO3YKbHvTFZw=
Message-ID: <44974AC7.4060708@gmail.com>
Date: Tue, 20 Jun 2006 09:09:27 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/9] VT binding: Make VT binding a Kconfig option
References: <44957026.2020405@gmail.com> <9e4733910606191718n74d0bf40na7b0cc3902d80172@mail.gmail.com>
In-Reply-To: <9e4733910606191718n74d0bf40na7b0cc3902d80172@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> I gave this patch a try and it seems to work. I say seems because I
> could not get the nvidiafb driver to set a usable mode after it was
> bound/unbound.

What do you mean by this?  You mean that you cannot restore vgacon?
If that's the case, then yes, that is perfectly understandable as
nvidiafb does not restore VGA to text mode.

> That's not a problem with the patch, the patch is not
> addressing that issue. I tried vbetool but it kept GPFing.

I use nvidiafb, and vbetool works for me. It probably depends on the
hardware. Some nvidia cards have faulty BIOS'es and this has been reported
several times, at least when using nvidia cards with vesafb-tng.

> This is a
> patch to help developers so maybe someone will fix nvidiafb to be more
> friendly.
> 
> Is there any way to lessen this problem?

The best and simplest way is to make nvidiafb behave like i810fb and rivafb
where they completely restore the VGA hardware to text mode. Hopefully
adding this is not as difficult as it sounds. (I'll see if I can work on
this within this week).

>  Would it help if fbcon worked
> with text modes,

fbcon does work with text mode. One developer converted viafb to work
this way.  Each driver must be converted separately though.
 
 or would it be better for each driver to set in a
> default mode that it understands when it gets control? The fbdev
> driver should not set a mode when it loads, but that doesn't mean
> fbcon can't set one when it is activated. Similarly VGAcon would set
> the mode (and load its fonts) when it regains control.

The problem with vgacon setting its own mode is that it does not know
anything about the hardware. So VGA text mode will need to rely on
a secondary program to set the mode (whether it's vbetool, another
fb driver, or X does not matter).

A standalone vga text driver is next to impossible to do.

> 
> It would also be interesting to make VGAcon a modular driver. You
> could build in fbcon and then work on VGAcon.
> 

This is very doable.  Add a module_init() for vgacon where it calls
take_over_console(). And make sure the system driver points to
dummycon.

Tony
