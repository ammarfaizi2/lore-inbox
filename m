Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262839AbVA2CpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbVA2CpW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 21:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbVA2CpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 21:45:22 -0500
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:53633 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262839AbVA2CpQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 21:45:16 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [RFC][PATCH] add driver matching priorities
Date: Fri, 28 Jan 2005 21:45:13 -0500
User-Agent: KMail/1.7.2
Cc: g@parcelfarce.linux.theplanet.co.uk, Adam Belay <abelay@novell.com>,
       greg@kroah.com, rml@novell.com, linux-kernel@vger.kernel.org
References: <1106951404.29709.20.camel@localhost.localdomain> <200501281823.27132.dtor_core@ameritech.net> <20050129001105.GQ8859@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050129001105.GQ8859@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501282145.13837.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 January 2005 19:11, Al Viro wrote:
> On Fri, Jan 28, 2005 at 06:23:26PM -0500, Dmitry Torokhov wrote:
> > On Friday 28 JanuarDy 2005 17:30, Adam Belay wrote:
> > > Of course this patch is not going to be effective alone.  We also need
> > > to change the init order.  If a driver is registered early but isn't the
> > > best available, it will be bound to the device prematurely.  This would
> > > be a problem for carbus (yenta) bridges.
> > > 
> > > I think we may have to load all in kernel drivers first, and then begin
> > > matching them to hardware.  Do you agree?  If so, I'd be happy to make a
> > > patch for that too.
> > > 
> > 
> > I disagree. The driver core should automatically unbind generic driver
> > from a device when native driver gets loaded. I think the only change is
> > that we can no longer skip devices that are bound to a driver and match
> > them all over again when a new driver is loaded.  
> 
> And what happens if we've already got the object busy?
> 

Mark it as dead and release structures when holder lets it go. With hotplug
pretty much everywhere more and more systems can handle it. Plus one could
argue that if an object needs a special driver to function properly it will
unlikely be busy before native driver is loaded.

Also, one still can do what Adam offers by pre-loading native drivers in
cases whent is required but still support more flexible default scheme.

-- 
Dmitry
