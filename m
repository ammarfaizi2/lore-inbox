Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVAXRvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVAXRvq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 12:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVAXRvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 12:51:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43672 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261547AbVAXRui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 12:50:38 -0500
Date: Mon, 24 Jan 2005 09:49:22 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Greg KH <greg@kroah.com>, Adrian Bunk <bunk@stusta.de>,
       mdharm-usb@one-eyed-alien.net, zaitcev@redhat.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] let BLK_DEV_UB depend on USB_STORAGE=n
Message-ID: <20050124094922.165fa988@localhost.localdomain>
In-Reply-To: <1106567331.6480.43.camel@localhost.localdomain>
References: <20041220001644.GI21288@stusta.de>
	<20041220003146.GB11358@kroah.com>
	<20041223024031.GO5217@stusta.de>
	<20050119220707.GM4151@kroah.com>
	<1106567331.6480.43.camel@localhost.localdomain>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005 11:48:51 +0000, David Woodhouse <dwmw2@infradead.org> wrote:

> On Wed, 2005-01-19 at 14:07 -0800, Greg KH wrote:
> > I have been running with just the code portion of this patch for a while
> > now, with good results (no Kconfig changes.)
> > 
> > Pete and Matt, do you mind me applying the following portion of the
> > patch to the kernel tree?
> > 
> > > -#if !defined(CONFIG_BLK_DEV_UB) && !defined(CONFIG_BLK_DEV_UB_MODULE)
> > >  UNUSUAL_DEV(  0x0781, 0x0002, 0x0009, 0x0009, 
> > >  		"Sandisk",
> > >  		"ImageMate SDDR-31",
> > >  		US_SC_DEVICE, US_PR_DEVICE, NULL,
> > >  		US_FL_IGNORE_SER ),
> > > -#endif
> 
> Urgh. Please do. Code which may compile differently in the kernel image
> according to which _modules_ are configured at the time is horrid, and
> should be avoided.

The fallacy of this "urgh" is easy to demonstrate when you consider usb-storage
and ub the one and the same driver. Initially, ub was just a mode for
usb-storage ("threadless"). I only factored them separate for reasons
of clarity. Horrid, indeed. There's no reason to build one statically
and another as a module.

Mind, I didn't disagree with the backout patch as such, but not because
it was a good idea, but because it may help to shut up a few stupid users
(provided that our scripts preserve the link order from drivers/usb/Makefile
in modules.usbmap, or have other way to make sure that usb-storage entries
are ahead of ub entires; did anyone actually check it? if those scripts
sort by name, ub still pops ahead, and the backout is utterly ineffectual).

When we reintroduce ub in Fedora, I'll just put this patch right back,
it's not a problem. But please think about this issue a little more,
you might want to take the Urgh back.

-- Pete
