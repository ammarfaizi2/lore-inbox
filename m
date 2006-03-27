Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWC0F2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWC0F2M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 00:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWC0F2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 00:28:12 -0500
Received: from gate.crashing.org ([63.228.1.57]:7057 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750703AbWC0F2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 00:28:11 -0500
Subject: Re: funny framebuffer fonts on PowerBook with radeonfb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@hotpop.com>
In-Reply-To: <20060327033743.GA19788@MAIL.13thfloor.at>
References: <20060327004741.GA19187@MAIL.13thfloor.at>
	 <1143422242.3589.2.camel@localhost.localdomain>
	 <20060327033743.GA19788@MAIL.13thfloor.at>
Content-Type: text/plain
Date: Mon, 27 Mar 2006 16:26:38 +1100
Message-Id: <1143437199.2221.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-27 at 05:37 +0200, Herbert Poetzl wrote:

> after that, the screen goes white for half a second
> and becomes black with a large terminal font on it
> (the one I get without framebuffer, I think), the
> text there is printed undistorted ... shortly after
> that, I get a flash, and the mode switches to a much
> smaller font (the final framebuffer font) and the
> kernel messages written there are already distorted.
> half a second later (or less) the penguin appears at
> the top area (undistorted), when the bootup is done
> I get the following prompt (which again is okay)
> 
> 	bash-2.05b#
> 
> typing anything there is distorted again ...

Hrm... this is a a pristine 2.6.16 without any patch applied ? Also,
what video chip revision do you have exactly ? (lspci will tell you)

> pressing enter several times leaves 'copies' of
> the caracters on the screen, forming vertical bars
> the prompt (bash) is now always fine, the copy one
> line above (as all the others) is distorted ...
> 
> note, the bootup is not much different with older
> kernels, except for the strange distortions ...
> 
> attached my kernel configuration, just in case
> it is related ...

# CONFIG_VGA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
CONFIG_FONTS=y
# CONFIG_FONT_8x8 is not set
# CONFIG_FONT_8x16 is not set
CONFIG_FONT_6x11=y
CONFIG_FONT_7x14=y
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_10x18 is not set

Interesting... I suspect there is an endian bug in the new font code
that hits odd sized fonts (or non-multiple-of-8 fonts). Can you try
enabling 8x8 and 8x16 instead of 6x11 and 7x14 fonts and tell me if
those work ?

Tony: If my suspition is confirmed, I think that's your call :)

Cheers,
Ben.


