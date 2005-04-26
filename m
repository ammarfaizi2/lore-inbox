Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVDZG7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVDZG7K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 02:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVDZG7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 02:59:10 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:15158 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261363AbVDZG7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 02:59:02 -0400
Date: Mon, 25 Apr 2005 23:58:39 -0700
From: Greg KH <gregkh@suse.de>
To: dtor_core@ameritech.net
Cc: johnpol@2ka.mipt.ru, sensors@stimpy.netroedge.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
Message-ID: <20050426065839.GD5889@suse.de>
References: <200504210207.02421.dtor_core@ameritech.net> <1114089504.29655.93.camel@uganda> <d120d50005042107314cbacdea@mail.gmail.com> <1114420131.8527.52.camel@uganda> <d120d50005042509326241a302@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005042509326241a302@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 11:32:14AM -0500, Dmitry Torokhov wrote:
> On 4/25/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > On Thu, 2005-04-21 at 09:31 -0500, Dmitry Torokhov wrote:
> > >
> > > OK, that is what I am aying. But why do you need that attribute with
> > > variable name and a bin attribute that is not really bin but just a
> > > dump for all kind of data (looks like debug one).
> > 
> > bin attribute was created for lm_sensors scripts format - it only caches
> > read value.
> > I think there might be only 2 "must have" methods - read and write.
> > I plan to implement them using connector, so probably they will go away
> > completely.
> ...
> > > You will not be able to cram all 1-wire devices into unified
> > > interface. You will need to build classes on top of it and you might
> > > use connector (I am not sure) bit not on w1 bus level.
> > > ...
> > 
> > connector allows to have different objects inside one netlink group,
> > so it will use it in that way.
> > I think only two w1 methods must exist - read and write,
> > and they must follow protocol, defined in family driver.
> 
> No, I think there should not be any "must have" methods on w1_bus
> level. What you really need (and this needs to be coordinated with
> other sensors people) is a "sensors" class hierarchy that will define
> classes like "temperature sensor", "fan", "vid", etc. Then your w1
> family drivers, when bound to a slave, will create needed class
> devices. i2c drivers will do the same, and your superio, and I'll be
> able to change i8k driver just for kicks. Then your usespace would not
> care what _bus_ a particular sensor is sittign on and will be
> presented with a unified interface.

Yes, that is the way to go, and is what a number of people are currently
working on implementing.

thanks,

greg k-h
