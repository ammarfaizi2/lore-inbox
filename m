Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265661AbUBFSoI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 13:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265636AbUBFSlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 13:41:53 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:43498 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S265654AbUBFSk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 13:40:57 -0500
Date: Fri, 6 Feb 2004 13:39:14 -0500
From: Ben Collins <bcollins@debian.org>
To: Greg KH <greg@kroah.com>
Cc: Robert Gadsdon <robert@gadsdon.giointernet.co.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat"
Message-ID: <20040206183914.GM1042@phunnypharm.org>
References: <fa.h1qu7q8.n6mopi@ifi.uio.no> <402240F9.3050607@gadsdon.giointernet.co.uk> <20040205182614.GG13075@kroah.com> <20040206144729.GJ1042@phunnypharm.org> <20040206182200.GE32116@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040206182200.GE32116@kroah.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 10:22:00AM -0800, Greg KH wrote:
> On Fri, Feb 06, 2004 at 09:47:30AM -0500, Ben Collins wrote:
> > On Thu, Feb 05, 2004 at 10:26:14AM -0800, Greg KH wrote:
> > > On Thu, Feb 05, 2004 at 01:11:21PM +0000, Robert Gadsdon wrote:
> > > > 2.6.2-mm1 tombstone "Badness in kobject_get....." when booting:
> > > 
> > > Oooh, not nice.  That means a kobject is being used before it has been
> > > initialized.  Glad to see that check finally helps out...
> > 
> > Doesn't sound like a bug in ieee1394. This bus for each is done on the
> > ieee1394_bus_type, which is registered way ahead of time. Nothing is in
> > that device list that didn't come from device_register(). Has something
> > new changed to where I need to prep the device more before passing it to
> > device_register()?
> 
> No, not at all.  You are initializing the structure to 0 before setting
> any fields in it, right?  But that wouldn't be the symptom we are seeing
> here...

Fact is, I can't reproduce this with stock 2.6.2. If this is only
reproducible in 2.6.2-mm1, then it must be some change in there. What is
occuring is a bus_for_each_dev() where the callback returns 1 so that
the caller can stop and process one device (outside of the
bus_for_each_dev() loop so as not to cause lockups). Then it starts
bus_for_each_dev() again using the last device processed as the starting
point.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
