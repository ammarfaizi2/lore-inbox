Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276532AbRJCAyG>; Tue, 2 Oct 2001 20:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276816AbRJCAx4>; Tue, 2 Oct 2001 20:53:56 -0400
Received: from alcove.wittsend.com ([130.205.0.10]:38785 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S276815AbRJCAxi>; Tue, 2 Oct 2001 20:53:38 -0400
Date: Tue, 2 Oct 2001 20:54:03 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.4.10 and USB Modems...
Message-ID: <20011002205403.B32715@alcove.wittsend.com>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20011002184757.A32712@alcove.wittsend.com> <20011002191311.C15255@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011002191311.C15255@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2001 at 07:13:11PM -0400, Pete Zaitcev wrote:
> > From: "Michael H. Warfield" <mhw@wittsend.com>
> > To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
> > Cc: mhw@wittsend.com
> > Date: Tue, 2 Oct 2001 18:47:57 -0400

	[...]

> Looks like 2/2/1 had to math even with 2.4.10, but perhaps
> something is too subtle in the matching code.

> This is what Vojtech wrote me about it (I hope he forgives me
> for posting a private mail - it is a technical subject):

> > Date: Tue, 2 Oct 2001 22:36:08 +0200
> > From: Vojtech Pavlik <vojtech@suse.cz>
> > To: Pete Zaitcev <zaitcev@redhat.com>
> > Subject: Re: acm in 2.2.10

> > On Tue, Oct 02, 2001 at 02:13:00PM -0400, Pete Zaitcev wrote:
> > > This looks dubious:
> > > 
> > > --- linux-2.4.9/drivers/usb/acm.c	Wed Jul  4 20:11:17 2001
> > > +++ linux-2.4.10/drivers/usb/acm.c	Sun Sep 23 09:49:00 2001
> > > @@ -647,7 +648,8 @@
> > >   */
> > >  
> > >  static struct usb_device_id acm_ids[] = {
> > > -	{ USB_DEVICE_INFO(2, 0, 0) },
> > > +	{match_flags: (USB_DEVICE_ID_MATCH_INT_CLASS | USB_DEVICE_ID_MATCH_INT_SUBCLASS),
> > > +	bInterfaceClass: USB_CLASS_COMM, bInterfaceSubClass: 2},
> > >  	{ }
> > >  };
> > >  
> > > Are you sure there are no 2/0/0 devices out there?
> > > Someone complained about some modem on Usenet today.
> > 
> > The change wasn't by me nor blessed by me, and it's wrong. It'll be
> > reverted in following kernels. The problem is that 2/0/0 also matches
> > the CDC Ethernet class, and thus both drivers get loaded for such
> > devices via the hotplug mechanism. This works, but is slightly
> > inefficient.

	I'll confirm this.  Backing out that change (which seems to be
the only real change to acm.c) corrected the problem and the modems
are now recognized and operate under 2.4.10.

> > -- 
> > Vojtech Pavlik
> > SuSE Labs

> I think it is important to clear changes by the maintainer.
> That's what he is there for :)

	Tell me about it (I maintain the Computone multiport driver).  :-)

> -- Pete

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

