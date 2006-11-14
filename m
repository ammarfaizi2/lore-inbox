Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966416AbWKNWjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966416AbWKNWjr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 17:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966418AbWKNWjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 17:39:47 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:29925 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S966416AbWKNWjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 17:39:45 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Christian Hoffmann <chrmhoffmann@gmail.com>
Subject: Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Date: Tue, 14 Nov 2006 23:36:43 +0100
User-Agent: KMail/1.9.1
Cc: linux-fbdev-devel@lists.sourceforge.net,
       "Christian Hoffmann" <Christian.Hoffmann@wallstreetsystems.com>,
       Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Solomon Peachy <pizza@shaftnet.org>, Pavel Machek <pavel@ucw.cz>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com> <200611140008.55059.rjw@sisk.pl> <200611142247.55137.chrmhoffmann@gmail.com>
In-Reply-To: <200611142247.55137.chrmhoffmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611142336.44021.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 14 November 2006 22:47, Christian Hoffmann wrote:
> On Tuesday 14 November 2006 00:08, Rafael J. Wysocki wrote:
> > On Monday, 13 November 2006 23:08, Christian Hoffmann wrote:
> > > > -----Original Message-----
> > > > From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
> > > > Sent: Monday, November 13, 2006 3:06 PM
> > > > To: Christian Hoffmann
> > > > Cc: Pavel Machek; Benjamin Herrenschmidt; Andrew Morton;
> > > > Solomon Peachy; linux-fbdev-devel@lists.sourceforge.net; LKML
> > > > Subject: Re: Fwd: [Suspend-devel] resume not working on acer
> > > > ferrari 4005 with radeonfb enabled
> > > >
> > > > On Monday, 13 November 2006 11:51, Christian Hoffmann wrote:
> > > > > > -----Original Message-----
> > > > > > From: Pavel Machek [mailto:pavel@ucw.cz]
> > > > > > Sent: Sunday, November 12, 2006 1:14 PM
> > > > > > To: Benjamin Herrenschmidt
> > > > > > Cc: Christian Hoffmann; Andrew Morton; Solomon Peachy; Rafael J.
> > > > > > Wysocki; linux-fbdev-devel@lists.sourceforge.net; LKML;
> > > > > > Christian@ogre.sisk.pl; Hoffmann@albercik.sisk.pl
> > > > > > Subject: Re: Fwd: [Suspend-devel] resume not working on
> > > >
> > > > acer ferrari
> > > >
> > > > > > 4005 with radeonfb enabled
> > > > > >
> > > > > > Hi!
> > > > > >
> > > > > > > > Then the radeonfb doesn't kick in at all (guess some
> > > >
> > > > pci ids are
> > > >
> > > > > > > > added in that patch).
> > > > > > > >
> > > > > > > > BTW: resume/suspend works ok if I have the vesa fb enabled.
> > > > > > >
> > > > > > > In that case (vesafb), when does the screen come back
> > > > > >
> > > > > > precisely ? Do
> > > > > >
> > > > > > > you get console mode back and then X ? Or it only comes
> > > >
> > > > back when
> > > >
> > > > > > > going back to X ? Do you have some userland-type vbetool
> > > > > >
> > > > > > thingy that
> > > > > >
> > > > > > > bring it back ?
> > > > > >
> > > > > > He's using s3_bios+s3_mode, so kernel does some BIOS
> > > >
> > > > calls to reinit
> > > >
> > > > > > the video. It should come out in text mode, too.
> > > > > >
> > > > > > Christian, can you unload radeonfb before suspend/reload it after
> > > > > > resume?
> > > > >
> > > > > Will it work if radeonfb is compiled as module? I think I
> > > >
> > > > had problems
> > > >
> > > > > with that, but I'll try again.
> > > > >
> > > > > > Next possibility is setting up serial console and adding some
> > > > > > printks to radeon...
> > > > >
> > > > > Unfortunatly, the laptop doesn't have serial port. I tried to get a
> > > > > USB device (pocketpc) read the USB serial, but I only partially
> > > > > succeeded. I can pass console=ttyUSB0 to the kernel and
> > > >
> > > > load the ipaq
> > > >
> > > > > serial console driver as it oopses. I am able to echo strings to
> > > > > /dev/ttyUSB0  and read them on the ipaq, but I am not able to
> > > > > "deviate" the kernel messages to that port. Any hints on how to do
> > > > > that would be very appreciated, I didn't find anything
> > > >
> > > > usefull on the
> > > >
> > > > > web. (I tried with setconsole /dev/ttyUSB0 but it gives error msg
> > > > > about device busy or something)
> > > >
> > > > Would it be practicable to use netconsole on your box?  If
> > > > so, it should work.
> > >
> > > I tried netconsole, and it somehow works, but when suspending it says in
> > > an "infinite" loop:
> > >
> > > unregister_netdevice: waiting for eth2 to become free. Usage count = 1
> >
> > Hm.  Is your kernel compiled with CONFIG_DISABLE_CONSOLE_SUSPEND set?
> >
> > Rafael
> 
> I tried that patch, but the last message I see over netconsole (using tg3) is:
> Suspending console(s)
> and then nothing. Nothing on resume at all :(

The patch prevents messages from being sent to the console(s) while the
devices that handle the console(s) are being suspended/resumed.

What you observe means that the box probably crashes somewhere during
the resuming of devices, so netconsole won't help.

BTW, could you please remind me which kernel you are using?

Rafael
 

-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
