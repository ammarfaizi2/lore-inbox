Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276770AbRJBXNJ>; Tue, 2 Oct 2001 19:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276777AbRJBXNA>; Tue, 2 Oct 2001 19:13:00 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:21895 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S276770AbRJBXMl>; Tue, 2 Oct 2001 19:12:41 -0400
Date: Tue, 2 Oct 2001 19:13:11 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.4.10 and USB Modems...
Message-ID: <20011002191311.C15255@devserv.devel.redhat.com>
In-Reply-To: <20011002184757.A32712@alcove.wittsend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011002184757.A32712@alcove.wittsend.com>; from mhw@wittsend.com on Tue, Oct 02, 2001 at 06:47:57PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: "Michael H. Warfield" <mhw@wittsend.com>
> To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
> Cc: mhw@wittsend.com
> Date: Tue, 2 Oct 2001 18:47:57 -0400

> 	I just upgraded the kernel on a system which has 4 USB modems
> (US Robotics 56K Voice/Fax modems).  The modems were recognized and
> worked under 2.4.6 but under 2.4.10 they are not recognized and I get
> and error that no driver claims them. [...]

> T:  Bus=01 Lev=02 Prnt=02 Port=02 Cnt=03 Dev#=  5 Spd=12  MxCh= 0
> D:  Ver= 1.00 Cls=02(comm.) Sub=00 Prot=00 MxPS= 8 #Cfgs=  2
> P:  Vendor=04c1 ProdID=3021 Rev= 0.82
> S:  Manufacturer=3Com Inc.
> S:  Product=U.S.Robotics 56000 Voice USB Modem
> S:  SerialNumber=005605000000000E100D1A170000
> C:* #Ifs= 1 Cfg#= 1 Atr=60 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
> E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
> C:  #Ifs= 2 Cfg#= 2 Atr=60 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=02 Prot=01 Driver=(none)
> E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=128ms
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=(none)
> E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms

Looks like 2/2/1 had to math even with 2.4.10, but perhaps
something is too subtle in the matching code.

This is what Vojtech wrote me about it (I hope he forgives me
for posting a private mail - it is a technical subject):

> Date: Tue, 2 Oct 2001 22:36:08 +0200
> From: Vojtech Pavlik <vojtech@suse.cz>
> To: Pete Zaitcev <zaitcev@redhat.com>
> Subject: Re: acm in 2.2.10
> 
> On Tue, Oct 02, 2001 at 02:13:00PM -0400, Pete Zaitcev wrote:
> > This looks dubious:
> > 
> > --- linux-2.4.9/drivers/usb/acm.c	Wed Jul  4 20:11:17 2001
> > +++ linux-2.4.10/drivers/usb/acm.c	Sun Sep 23 09:49:00 2001
> > @@ -647,7 +648,8 @@
> >   */
> >  
> >  static struct usb_device_id acm_ids[] = {
> > -	{ USB_DEVICE_INFO(2, 0, 0) },
> > +	{match_flags: (USB_DEVICE_ID_MATCH_INT_CLASS | USB_DEVICE_ID_MATCH_INT_SUBCLASS),
> > +	bInterfaceClass: USB_CLASS_COMM, bInterfaceSubClass: 2},
> >  	{ }
> >  };
> >  
> > Are you sure there are no 2/0/0 devices out there?
> > Someone complained about some modem on Usenet today.
> 
> The change wasn't by me nor blessed by me, and it's wrong. It'll be
> reverted in following kernels. The problem is that 2/0/0 also matches
> the CDC Ethernet class, and thus both drivers get loaded for such
> devices via the hotplug mechanism. This works, but is slightly
> inefficient.
> 
> -- 
> Vojtech Pavlik
> SuSE Labs

I think it is important to clear changes by the maintainer.
That's what he is there for :)

-- Pete
