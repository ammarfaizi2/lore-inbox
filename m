Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266848AbSLUJTu>; Sat, 21 Dec 2002 04:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266851AbSLUJTu>; Sat, 21 Dec 2002 04:19:50 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23300 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266848AbSLUJTt>; Sat, 21 Dec 2002 04:19:49 -0500
Date: Sat, 21 Dec 2002 09:27:44 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [PATCH] fix endian problem in color_imageblit
Message-ID: <20021221092744.A23531@flint.arm.linux.org.uk>
Mail-Followup-To: Antonino Daplas <adaplas@pol.net>,
	James Simmons <jsimmons@infradead.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44.0212201932150.6471-100000@phoenix.infradead.org> <1040442194.1294.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1040442194.1294.9.camel@localhost.localdomain>; from adaplas@pol.net on Sat, Dec 21, 2002 at 11:45:44AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 21, 2002 at 11:45:44AM +0800, Antonino Daplas wrote:
> The pseudopalette will only matter for truecolor and directcolor as the
> rest of the visuals bypasses the pseudopalette.  Typecasting to
> "unsigned long" rather than "u32" is also safer (even for bpp16) since
> in 64-bit machines, the drawing functions use fb_writeq instead of
> fb_writel.

Erm, what does the size of the drawing functions have to do with the
size of the pseudo palette.  The pseudo palette is only there to encode
the pixel values for the 16 console colours.

This means that a 64-bit pseudo palette would only be useful if you have
a graphics card that supports > 32bpp, otherwise a 32-bit pseudo palette
is perfectly adequate, even if you are using fb_writeq.

(note that fbcon doesn't support > 32bpp, so we will only ever look at
the first 32 bits, and having it be 64-bit would just be a needless
waste of space imho.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

