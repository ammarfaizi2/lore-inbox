Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263298AbTDCGck>; Thu, 3 Apr 2003 01:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263299AbTDCGck>; Thu, 3 Apr 2003 01:32:40 -0500
Received: from AMarseille-201-1-3-158.abo.wanadoo.fr ([193.253.250.158]:8487
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S263298AbTDCGcj>; Thu, 3 Apr 2003 01:32:39 -0500
Subject: Re: [Linux-fbdev-devel] [PATCH]: EDID parser
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
In-Reply-To: <1049330578.1029.38.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0304022245520.2488-100000@phoenix.infradead.org>
	 <1049330578.1029.38.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049352298.579.23.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 03 Apr 2003 08:44:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 3.  Some architecture specific methods, such as doing it via the BIOS. 
> This is the last choice, our fallback method. as this EDID may be static
> and represents only the display detected at boot time.
> 
> For supplementary functions, we also need some kind of control that
> allows the user to tell fbdev "I've switched monitors, please reread the
> EDID". We want to avoid doing DDC each time fbdev does an fb_set_var(),
> especially for DDC1 which can be very slow. 

That's also what Apple does indeed. It's too complicated/long to
dynamically detect hotplug, but they do have a button you can
click to force a re-detect of the displays in the GUI and this
goes via some kind of ioctl to the video driver to ask for new
connection informations (basically EDID).

> Also, a way to download the EDID from kernel to userland.

Just define an ioctl for that and let each driver that support EDID
return something seem to be the simplest way.

If we really want to make EDID a generic thing, then we can eventually
have the EDID block attached to each fb_info and then a generic
fbmem.c ioctl to read it, but then make sure that EDID block isn"t
mandatory (it has no sense to some specific HW like some embedded
stuffs) and I always prefer when drivers are the real target of
the calls like this ioctl, eventually using fbdev "tools" as helpers
instead of having fbdev do something directly as a "mid-mayer".

Ben.

