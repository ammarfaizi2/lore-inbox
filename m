Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbWAGEnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbWAGEnV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 23:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbWAGEnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 23:43:21 -0500
Received: from gate.crashing.org ([63.228.1.57]:32396 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030343AbWAGEnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 23:43:20 -0500
Subject: Re: request for opinion on synaptics, adb and powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Peter Osterlund <petero2@telia.com>, Luca Bigliardi <shammash@artha.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <200601062336.26035.dtor_core@ameritech.net>
References: <20060106231301.GG4732@kamaji.shammash.lan>
	 <200601062317.03712.dtor_core@ameritech.net>
	 <1136608396.4840.206.camel@localhost.localdomain>
	 <200601062336.26035.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Sat, 07 Jan 2006 15:44:07 +1100
Message-Id: <1136609048.4840.210.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 23:36 -0500, Dmitry Torokhov wrote:
> On Friday 06 January 2006 23:33, Benjamin Herrenschmidt wrote:
> > 
> > > Why would you want to switch to relative mode when leaving X? As far as
> > > I know the only other mouse "user" out there is GPM and there are patches
> > > available for it to use event device:
> > > 
> > > 	http://geocities.com/dt_or/gpm/gpm.html
> > > 
> > > Unfortunately the maintainer can't find time to merge these so they were
> > > sitting there for over 2 years. FWIW Fedora patches their GPM with these.
> > 
> > gpm among other legacy things ...
> > 
> 
> What other legacy things? And in that case I think manually forcing protocol
> back to relative would be an option.
> 
> The thing is that Synaptics in absolute and relative mode is 2 completely
> different devices with different capabilities. If you want to switch mode
> you really need to kill old input device and create a brand new one.

Ok, so what method should we use to "switch" ? sysfs isn't quite an
option yet as the ADB bus isn't yet represented there (unless we add
attributes to the input object, but that's a bit awkward as it would be
destroyed and re-created if I follow you). A module option would work
but adbhid isn't a module, thus that would basically end up as a static
kernel argument, unless the driver "polls" the module param regulary to
trigger the change.. I don't think there is a way for a driver to get a
callback when /sys/module/<driver>/parameters/* changes is there ?

Ben.


