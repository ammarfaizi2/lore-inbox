Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267061AbUBGTOr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 14:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267093AbUBGTOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 14:14:47 -0500
Received: from mail.kroah.org ([65.200.24.183]:14302 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267061AbUBGTN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 14:13:26 -0500
Date: Sat, 7 Feb 2004 11:13:15 -0800
From: Greg KH <greg@kroah.com>
To: Ben Collins <bcollins@debian.org>
Cc: Robert Gadsdon <robert@gadsdon.giointernet.co.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat"
Message-ID: <20040207191315.GC2581@kroah.com>
References: <fa.h1qu7q8.n6mopi@ifi.uio.no> <402240F9.3050607@gadsdon.giointernet.co.uk> <20040205182614.GG13075@kroah.com> <20040206144729.GJ1042@phunnypharm.org> <20040206182200.GE32116@kroah.com> <20040207172757.GQ1042@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040207172757.GQ1042@phunnypharm.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 12:27:58PM -0500, Ben Collins wrote:
> On Fri, Feb 06, 2004 at 10:22:00AM -0800, Greg KH wrote:
> > On Fri, Feb 06, 2004 at 09:47:30AM -0500, Ben Collins wrote:
> > > On Thu, Feb 05, 2004 at 10:26:14AM -0800, Greg KH wrote:
> > > > On Thu, Feb 05, 2004 at 01:11:21PM +0000, Robert Gadsdon wrote:
> > > > > 2.6.2-mm1 tombstone "Badness in kobject_get....." when booting:
> > > > 
> > > > Oooh, not nice.  That means a kobject is being used before it has been
> > > > initialized.  Glad to see that check finally helps out...
> > > 
> > > Doesn't sound like a bug in ieee1394. This bus for each is done on the
> > > ieee1394_bus_type, which is registered way ahead of time. Nothing is in
> > > that device list that didn't come from device_register(). Has something
> > > new changed to where I need to prep the device more before passing it to
> > > device_register()?
> > 
> > No, not at all.  You are initializing the structure to 0 before setting
> > any fields in it, right?  But that wouldn't be the symptom we are seeing
> > here...
> 
> Yeah, it's being memset() to zero. After that I set the parent and the
> bus_id, and then call device_register().
> 
> One thing I notice is that I am not checking the return value of
> device_register(), however if that fails, the device shouldn't be in the
> device list for the bus, correct?

That is correct.  I don't see the problem either in looking at your
code...

thanks,

greg k-h
