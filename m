Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262811AbVG2UOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbVG2UOi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbVG2UOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 16:14:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11198 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262807AbVG2UOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 16:14:04 -0400
Date: Fri, 29 Jul 2005 21:13:42 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: colormap fixes
In-Reply-To: <Pine.LNX.4.62.0507281758080.24391@numbat.sonytel.be>
Message-ID: <Pine.LNX.4.56.0507292106440.17988@pentafluge.infradead.org>
References: <200507280031.j6S0V3L3016861@hera.kernel.org>
 <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be>
 <9e473391050728060741040424@mail.gmail.com> <42E8F0CD.6070500@gmail.com>
 <Pine.LNX.4.62.0507281758080.24391@numbat.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> >  3) Add another file in sysfs which specifies at what index and how many
> > entries will be read or written from or to the cmap. With this additional
> > sysfs file, it should be able to handle any reasonable cmap length, but
> > it will take more than one reading of the color_map file. Another
> > advantage is that the entire color map need not be read or written if
> > only one field needs to be changed.
> > 
> > I've attached a test patch.  Let me know what you think.
> 
> I like it! ... But, a disadvantages is that it needs to store state between two
> non-atomic operations. E.g. imagine two processes doing this at the same time.

   That is really nice. Setting the values in the color map don't have to 
be atomic. Programming the hardware color registers do!! You could do a 
loop filling the color map and then do a sync operation that would flush 
the values to the hardware. It would be really nice if sysfs files had 
hooks for syncing so we could do atomic operations :-) 
     I realized for the cursor it is the same things. We have several 
fields to set but we don't want to program the cursor over and over 
again for every slight change. Instead we shoudl cache the changes
until we want to send those changes to the hardware.



