Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbTKDRob (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 12:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbTKDRob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 12:44:31 -0500
Received: from main.gmane.org ([80.91.224.249]:30371 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262429AbTKDRoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 12:44:30 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: VGA Console Idea
Date: Tue, 4 Nov 2003 20:44:26 +0300
Message-ID: <20031104204426.12c06ccb.vsu@altlinux.ru>
References: <Pine.LNX.4.44.0311041813320.5053-100000@gaia.cela.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Newsreader: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-alt-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Nov 2003 18:20:06 +0100 (CET) Maciej Zenczykowski wrote:

> this is just an idea for a VGA text mode console improvement which would
> provide us with 512 char fonts with little functionality loss.
> 
> Basically we perform a bit inversion of the font bitmap, and then map
> foreground to background and background to foreground.  If we turn off the
> blink bit allowing high intensity background colours then we end up with
> 16 foreground colours, 8 background colours, no blink and no high
> intensity background colours.  Since both blink and bg high intensity are
> seldom used (since you can (not quite) never be sure if you'll get one or
> the other) we end up with a 16fg/8bg/512char font situation.  Everything
> works as expected except for direct memory access through vcs/vcsa, these
> would need to be nibble swapped in the colour area, but then with 512 char
> fonts these aren't exactly really supported anyway...  What do you think?

Unfortunately, this won't work, because the standard VGA text mode
uses funny tricks to convert 8x16 font bitmaps in memory to 9x16
bitmaps for real display (some graphic characters from the original
IBM charset are specially handled by the hardware).

However, for the framebuffer console (where we don't have hidden 9th
pixel column) this could be useful - it is certainly better to lose
high-intensity background (which almost nobody uses) than
high-intensity foreground (which is used much more often). Probably
this can be performed without actually inverting anything...

PS: I really use high-intensity background colors in VIM (though I
rarely run in in the console these days).

