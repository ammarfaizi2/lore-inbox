Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268180AbUIKQLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268180AbUIKQLU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 12:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268184AbUIKQLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 12:11:19 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:6864 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268180AbUIKQLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 12:11:17 -0400
Message-ID: <9e47339104091109111c46db54@mail.gmail.com>
Date: Sat, 11 Sep 2004 12:11:13 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: radeon-pre-2
In-Reply-To: <20040911132727.A1783@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <9e47339104091008115b821912@mail.gmail.com>
	 <1094829278.17801.18.camel@localhost.localdomain>
	 <9e4733910409100937126dc0e7@mail.gmail.com>
	 <1094832031.17883.1.camel@localhost.localdomain>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <20040911132727.A1783@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sep 2004 13:27:27 +0100, Christoph Hellwig <hch@infradead.org> wrote:
> > If the kernel developers can address this point I would be most
> > interested, in fact I don't want to hear any more about sharing lowlevel
> > VGA device drivers until someone addresses why it is acceptable to have
> > two separate driver driving the same hardware for video and not for
> > anything else.. (remembering graphics cards are not-multifunction cards -
> > like Christoph used as an example before - 2d/3d are not separate
> > functions...)...
> 
> Well, Alan's proposal gets things back into a working shape with both
> fbdev and get additional benefits like hotplug and autloading without
> a major revamp of everything.  The major rework will have to happen sooner
> or later anyway, but by fixing the obvious problems we face now first it
> can be done in small pieces and with far less pressure.
> 
The resource reservation conflicts are already solved in the current
DRM code. Most of the changes are in kernel and the rest are in the
pipeline.  DRM loads in two modes, primary where it behaves like a
normal Linux driver and stealth where it uses the resources without
telling the kernel. Stealth/primary mode is a transition tool until
things get fixed. Once everything is sorted out stealth mode can be
removed.

Think of this as having the shared resource platform code in the DRM
driver. This shared platform knows how to load DRM. The next step is
to teach it how to load fbcon. Final step is to integrate the chip
specific code from DRM and fbdev.

I believe this method is less disruptive that simultaneously tearing
up vesafb, fbdev and DRM. The end result will be the same.



-- 
Jon Smirl
jonsmirl@gmail.com
