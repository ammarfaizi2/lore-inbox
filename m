Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVCOWcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVCOWcy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVCOWb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:31:29 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:43722 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261947AbVCOW3a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:29:30 -0500
From: David Brownell <david-b@pacbell.net>
To: dtor_core@ameritech.net
Subject: Re: [linux-usb-devel] Re: [RFC] Changes to the driver model class code.
Date: Tue, 15 Mar 2005 14:29:22 -0800
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>
References: <20050315170834.GA25475@kroah.com> <200503151314.40510.david-b@pacbell.net> <d120d5000503151405381f183a@mail.gmail.com>
In-Reply-To: <d120d5000503151405381f183a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503151429.22863.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 March 2005 2:05 pm, Dmitry Torokhov wrote:
> I think I was shopping around for the examples of proper driver model
> integration in 2.6.2 - 2.6.3 timeframe for the serio bus. I was
> looking at how USB was working around the fact that one can not
> add/remove children from the probe/remove methods.

Yes, the constraints on when children can be added/removed aren't
always useful.  In fact they can seem nastily arbitrary, and some
of them need careful workarounds elsewhere in USB.  The current
usbcore code should behave well in all common cases outside of
suspend/resume.  (Yes, it's routine to unplug USB devices when
the system is suspended.  That's not wholly worked around yet.
By the time World Domination is achieved, it'll be fixed!)


> I can not tell you 
> what exactly gave me the impression that conversion is still in
> progress, probably the comments like this:
> 
>      /* FIXME should device_bind_driver() */
>          iface->driver = driver;
>          usb_set_intfdata(iface, priv);
>          return 0;
> 
> Now I see it was changed shortly after I looked there. And I see that
> my impression was wrong, it _is_ tightly integrated with the driver
> model now.

That was a FIXME that I added, and indeed it's now fixed.  The
patch had a dry run around 2.6.0 but had some issues, and they
took time to fix/test properly given more pressing issues.  The
drivers that used those APIs needed changes/retesting too.  :)


> >  If you think those changes can easily be
> > reversed, I suggest you think again ... they enabled a LOT of
> > likewise-overdue cleanups.
> 
> Note that I am arguing for keeping existing interface, not removing it.

Those particular interfaces still exist even after Greg's patches
for the class support... he didn't change the physical device tree.

I tend to think the class support really does need to be treated
differently from the driver model core.  It's all sort of separate
anyway, since class devices aren't "real" ones.  They don't show up
in the physical device tree, and I understand the main reason to use
them is to mask that physical view behind a more "logical" view of
the hardware.  Keeping those views separate makes sense to me,
although I've not paid close attention to class device support.

- Dave

> -- 
> Dmitry
> 
