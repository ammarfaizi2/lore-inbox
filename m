Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266836AbUIEQFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266836AbUIEQFb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 12:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266839AbUIEQFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 12:05:31 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:57145 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266836AbUIEQFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 12:05:20 -0400
Message-ID: <9e47339104090509056e54866e@mail.gmail.com>
Date: Sun, 5 Sep 2004 12:05:19 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New proposed DRM interface design
Cc: Keith Whitwell <keith@tungstengraphics.com>, Dave Jones <davej@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@yahoo.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mharris@redhat.com
In-Reply-To: <1094395462.1271.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040904102914.B13149@infradead.org>
	 <4139C8A3.6010603@tungstengraphics.com>
	 <9e47339104090408362a356799@mail.gmail.com>
	 <4139FEB4.3080303@tungstengraphics.com>
	 <9e473391040904110354ba2593@mail.gmail.com>
	 <1094386050.1081.33.camel@localhost.localdomain>
	 <9e47339104090508052850b649@mail.gmail.com>
	 <1094393713.1264.7.camel@localhost.localdomain>
	 <9e473391040905083326707923@mail.gmail.com>
	 <1094395462.1271.12.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

They have to be merged. Cards with two heads need the mode set on each
head. fbdev only sets the mode on one head. If I teach fbdev how to
set the mode of the other head fbdev needs to learn about memory
management.  The DRM memory management code is complex and is a big
chunk of the driver.

I would also like to fix things so that we can have two logged in
users, one on each head. This isn't going to work if one them uses
fbdev and keeps swithing the chip to 2D mode while the other user is
in 3D mode. The chip needs to stay in 3D mode with the CP running.

We're not going to get OOPS display while running X without merging.
Something I would really like to have since I just had some and was
force to hook up a serial console.

It is just plain stupid having multiple device drivers fighting over
control of a single piece of hardware.  I thought we went over this
multiple times at OLS. There have been email discussions about this
since March.


On Sun, 05 Sep 2004 15:44:34 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Sul, 2004-09-05 at 16:33, Jon Smirl wrote:
> > Then how am I going to merge fbdev and DRM so that we don't have two
> > drivers fighting over the same hardware?
> 
> Everyone else in the discussions but you seemed to have no plans to
> merge them, yet you keep going back to that plan and ignoring the other
> opinions.
> 
> If you are merging them then something is wrong in the design. The only
> things they fundamentally share are knowledge of the current display
> layout, and state management for rendering.
> 
> As you say "if BSD isn't even going to use the code". So why are you
> trying to make it hard for the BSD side ? They've got a perfectly good
> frame buffer layer too and not suprisingly it has the same requirements
> for knowledge.
> 
> Alan
> 
> 



-- 
Jon Smirl
jonsmirl@gmail.com
