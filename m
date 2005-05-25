Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262291AbVEYFXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbVEYFXZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 01:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262302AbVEYFXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 01:23:21 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:5628 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262291AbVEYFXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 01:23:09 -0400
Message-Id: <200505250523.j4P5N5Xo012122@hp.home>
Reply-to: leisner@rochester.rr.com
To: Greg KH <greg@kroah.com>
cc: Marty Leisner <leisner@rochester.rr.com>, linux-kernel@vger.kernel.org,
       leisner@rochester.rr.com
Subject: Re: CONFIG_HOTPLUG, 2.4.x and ppc 
In-reply-to: Your message of "Tue, 24 May 2005 21:26:21 PDT."
             <20050525042621.GB17299@kroah.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12099.1116998554.1@hp>
Date: Wed, 25 May 2005 01:23:04 -0400
From: "Marty Leisner" <leisner@rochester.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Its a custom chip with bridge functionality...(its not hotplug,
but the thought was "if hotplug can add a bridge at a later time,
so can an arbitrary module".  There's a number of minor problems
in how BRIDGE_OTHER is handled (i.e. the first two bars should
be filled in like any other bridge, but everything else ignored).

The goal is to add a PCI bus behind the bridge (the bios
and the kernel doesn't know about it).   

So I'm executing the sequence to add a new bus -- which 
needs CONFIG_HOTPLUG to export the symbols -- which causes the
problem with PPC in the arch dependent part (it works fine
on intel platforms).

Looking at the hotplug drivers, it looks like its tied to
intel architectures in places...but adding a PCI bus should be
a PCI thing...

Marty Leisner


Greg KH <greg@kroah.com> writes  on Tue, 24 May 2005 21:26:21 PDT
     > On Tue, May 24, 2005 at 10:41:18PM -0400, Marty Leisner wrote:
     > > 
     > > I'm dealing with a custom BRIDGE_OTHER chip, which has PCI devices
     > > on the other side...the configuration cycles don't follow a standard, and
     > > I'm trying to establish the bus behind the bridge when I install a module...
     > > essentially I'm doing things similar to hotplug drivers...
     > > 
     > > I have no experience with hotplug drivers, but it appears to be incompatible
     > > with the ppc architure...
     > 
     > What pci hotplug controller works on the ppc platform on the 2.4 kernel?
     > 
     > thanks,
     > 
     > greg k-h
