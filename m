Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVBVTjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVBVTjq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 14:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVBVTjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 14:39:45 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:51317 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261427AbVBVTix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 14:38:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=pf+yVIDF/Mb+cFugXwx8IG0T0s1Y8jAZeP6tcFlvJDkMGwAo3ndMtfdFdh7ZPnFWZCTcxFBFk6RI7DBi+dY5+jS6ToJoKJIA5dLlw3BrgOnYuaNToct9qNuBrFGQVkA1UyrQy/BM8ksYIHOhor3Piu4trk22G7aQksw7YHCUuBs=
Message-ID: <d120d50005022211384a83726d@mail.gmail.com>
Date: Tue, 22 Feb 2005 14:38:48 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: POSTing of video cards (WAS: Solo Xgl..)
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Dave Airlie <airlied@linux.ie>, dri-devel@lists.sourceforge.net,
       xorg@lists.freedesktop.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0502221111410.2378@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0502201049480.18753@skynet>
	 <21d7e997050220150030ea5a68@mail.gmail.com>
	 <9e4733910502201542afb35f7@mail.gmail.com>
	 <1108973275.5326.8.camel@gaston>
	 <9e47339105022111082b2023c2@mail.gmail.com>
	 <1109019855.5327.28.camel@gaston>
	 <9e4733910502211717116a4df3@mail.gmail.com>
	 <1109041968.5412.63.camel@gaston>
	 <9e473391050221204215a079e1@mail.gmail.com>
	 <Pine.LNX.4.58.0502221111410.2378@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2005 11:19:10 -0800 (PST), Linus Torvalds
<torvalds@osdl.org> wrote:
> 
> 
> On Mon, 21 Feb 2005, Jon Smirl wrote:
> >
> > I was working on the assumption that all PCI based, VGA class hardware
> > that is not the boot device needs to be posted.
> 
> I don't think that's true. We certainly don't _want_ it to be true in the
> long run - and even now there are cards that we can initialize fully
> without using the BIOS at all.
> 
> > And that the posting should occur before the drivers are
> > loaded.
> 
> Personally, I'd much rather let the driver be involved in the decision.
> 
> That may mean that the probe routine knows how to initialize the card, but
> it may mean that it does an "exec_usermodehelper()" kind of thing.
> Actually, I'd prefer it if this was largely up to "udev": if the driver
> notices that it can't initialize the card, why not just enumerate it
> enough that "udev" knows about it (that's pretty much automatic), and let
> the driver just ignore the card until some (possibly much later) date when
> the user level scripts have found it and initialized it.
> 
> That would imply that the driver have some "re-attach" entrypoint (which
> migth be a ioctl, but might also be just a /sysfs file access), which is
> the user-lands way of saying "try again - I've now initialized the
> hardware".
> 

This sounds awfully like firmware loader that seems to be working just
fine for a ranfe of network cards and other devices.

-- 
Dmitry
