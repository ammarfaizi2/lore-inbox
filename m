Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbVJRPl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbVJRPl7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 11:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbVJRPl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 11:41:59 -0400
Received: from qproxy.gmail.com ([72.14.204.200]:20093 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750813AbVJRPl6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 11:41:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PqKWoXAb08XL81R+BMc4ZkXa1xBeNYvunKmxzVdjaPP9d3PwKk/2dnac8sw+yBGAIfZmFgGYGfa2r0miSgBAHYg2K+n/zf/d60Gc1uhlWXHOPe/uOv9MXpSyDUBcf+N4xxDzfYR/Vsh1lmz/TMAEhdmklf7aucAtsWuDFwh1jg8=
Message-ID: <d120d5000510180841o12799ce1jd910a4f57b67c64@mail.gmail.com>
Date: Tue, 18 Oct 2005 10:41:57 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
Cc: Adam Belay <ambx1@neo.rr.com>, Greg KH <gregkh@suse.de>,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051018150833.GA7890@vrfy.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051013020844.GA31732@kroah.com>
	 <d120d5000510131435m7b27fe59l917ac3e11b2458c8@mail.gmail.com>
	 <20051014084554.GA19445@vrfy.org>
	 <d120d5000510141002v67a06900m219b47246c1d92c1@mail.gmail.com>
	 <20051015150855.GA7625@vrfy.org> <20051017214430.GA5193@suse.de>
	 <20051017232430.GA32655@neo.rr.com> <20051018052617.GA10263@suse.de>
	 <20051018071822.GC32655@neo.rr.com> <20051018150833.GA7890@vrfy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/05, Kay Sievers <kay.sievers@vrfy.org> wrote:
> On Tue, Oct 18, 2005 at 03:18:22AM -0400, Adam Belay wrote:
> > On Mon, Oct 17, 2005 at 10:26:17PM -0700, Greg KH wrote:
> > > On Mon, Oct 17, 2005 at 07:24:30PM -0400, Adam Belay wrote:
> > > >
> > > > Sounds good to me.  The changes to driver model internals may be substantial.
> > > > For example, because buses and classes will share more code, it's
> > > > reasonable to allow drivers to bind to any "device" object, even class
> > > > devices.  Of course this would be limited to classes that choose to
> > > > implement driver matching etc.  We are doing this now with the pci express
> > > > port driver.
> > >
> > > That's a bus, not a class device.  Drivers bind to devices through a
> > > bus.  That's why we have busses.
> >
> > If class devices and devices belong in the same tree, then clearly the original
> > distinction is artificial.  "struct bus_type" is a class of "struct device".
> > "struct class" is a class of "struct class_dev".  We now know of devices
> > in between these two extremes (e.g. pci express port driver).  It's also
> > possible that drivers will want to bind to class devices (e.g. a partition
> > driver binding to a block device).  Isn't it fair to say that the "bus_type"
> > vs. "class" distinction is also artificial?  At the very least they are
> > duplicating some code.
>
> I agree and would like to see the "bus" functionality just as set of special
> methods of a unified device struture also used for class devices.
>
> > > > > Oh, one tiny problem.  "virtual devices" are not currently represented
> > > > > in our device tree, but are in the class tree.  Things like the
> > > > > different vc and ttys and misc devices are examples of this.  I'll just
> > > > > put them on the "platform" bus if no one minds.
> > > >
> > > > I think we should be trying to kill off the platform bus (it's artifical and
> > > > doesn't show the real relationships between these devices).  Instead, just
> > > > hang them off the root of the tree.
> > >
> > > Everything that's currently a platform device go to the root?  No,
> > > that's not going to happen, sorry.
>
> But will sticking stuff like "mice" or "tty" into "platform" will really
> work? These devices belong to their own primary class like "input" or "tty" and
> they can not be part of a "bus" at the same time, right?
>
> I'm dreaming of:
>  - merging "struct device" and "struct class_device"
>
>  - provide current "bus" and "class" methodes for _all_ devices
>

This way you are fattening object interface and I don't think it is a
good thing. While we may want to have sysfs representation of all
devices be in /sys/devices internally we should keep the interfaces
and implementation clean and do not turn it into a kitchen sink.

--
Dmitry
