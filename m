Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbTKDSHm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 13:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbTKDSHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 13:07:42 -0500
Received: from gaia.cela.pl ([213.134.162.11]:51464 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S262456AbTKDSHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 13:07:41 -0500
Date: Tue, 4 Nov 2003 19:07:28 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Sergey Vlasov <vsu@altlinux.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: VGA Console Idea
In-Reply-To: <20031104204426.12c06ccb.vsu@altlinux.ru>
Message-ID: <Pine.LNX.4.44.0311041902321.5053-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately, this won't work, because the standard VGA text mode
> uses funny tricks to convert 8x16 font bitmaps in memory to 9x16
> bitmaps for real display (some graphic characters from the original
> IBM charset are specially handled by the hardware).

True, forgot about this (not so) little detail.  In 9pixel-wide font 
modes, the 9th pixel for all chars is taken to be background, except for 
0xC0..0xDF, where (if enabled) the 9th column is a copy of the eighth.  
Basically this means my idea would work only in 8-pixel wide font modes 
(which are probably still used quite a bit, on laptops especially - I'm 
using a 100x40 video mode on my 800x600 LCD display with 8x15 font). 

> However, for the framebuffer console (where we don't have hidden 9th
> pixel column) this could be useful - it is certainly better to lose
> high-intensity background (which almost nobody uses) than
> high-intensity foreground (which is used much more often). Probably
> this can be performed without actually inverting anything...

In framebuffer mode we should theoretically have no problem supporting any 
number of characters we want.  As long as we don't use direct video memory 
access thru vcs/vcsa were programs expect 8-bit characters we can keep 
even 16-bit (or 32) chars in memory (probably in unicode) - this of couse 
increases the size of the font we need to keep resident in memory, but 
we'd almost be rid of one level of font-mapping...

> PS: I really use high-intensity background colors in VIM (though I
> rarely run in in the console these days).
:)

