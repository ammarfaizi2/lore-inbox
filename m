Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbTDDPci (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 10:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbTDDPbX (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 10:31:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3081 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263773AbTDDP2I (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 10:28:08 -0500
Date: Fri, 4 Apr 2003 16:39:31 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] interlaced packed pixels
Message-ID: <20030404163931.E964@flint.arm.linux.org.uk>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.21.0304041310440.1720-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0304041310440.1720-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Fri, Apr 04, 2003 at 01:17:15PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 01:17:15PM +0200, Geert Uytterhoeven wrote:
> I'd like to introduce a new frame buffer type to accommodate packed pixel frame
> buffers that store the even and odd fields separately. This is typically used
> in graphics hardware for TV output (e.g. set-top boxes).

While we're on the subject of framebuffers, one area which needs to be
looked into is the pixel layout for all of:

- little endian byte, little endian pixel
	1bpp: word 0 bit 31..0 = pixel 31..0)
	16bpp: word 0 bit 31..0 = pixel1 bits 15..0 pixel0 bits 15..0) 
- little endian byte, big endian pixel
	1bpp: word 0 bit 31..0 = pixel 24..31, 16..23, 8..15, 0..7)
	16bpp: word 0 bit 31..0 = pixel1 bits 15..0 pixel0 bits 15..0) 
- big endian byte, big endian pixel
	1bpp: word 0 bit 31..0 = pixel 0..31)
	16bpp: word 0 bit 31..0 = pixel0 bits 15..0 pixel1 bits 15..0) 

We currently do not support all these combinations, and so far I haven't
looked into it.  It is on my (great long) to do list.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

