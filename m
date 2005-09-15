Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161019AbVIOUz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbVIOUz0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 16:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbVIOUz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 16:55:26 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:22277 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932597AbVIOUzZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 16:55:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GBwASRa5OQPcxccb7/vmfbqS6gvn6L+187cufbARIvuYhUnsKdSNkDXrRCVTFjHb1pmpTmdLlYABnD3MdiUbHIMTbWMKM41/6M4fDVgvhLdPknYm5XAoZaCKqRo3NnGlJ0i4myOT110eeOlzipsPqWHOR1Rjw2dQfmBVqmBZ0Rw=
Message-ID: <d120d50005091513552688cd75@mail.gmail.com>
Date: Thu, 15 Sep 2005 15:55:23 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [patch 09/28] Input: convert net/bluetooth to dynamic input_dev allocation
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       Kay Sievers <kay.sievers@vrfy.org>, Hannes Reinecke <hare@suse.de>
In-Reply-To: <20050915202553.GA3977@midnight.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050915070131.813650000.dtor_core@ameritech.net>
	 <20050915070302.931769000.dtor_core@ameritech.net>
	 <1126770894.28510.10.camel@station6.example.com>
	 <d120d50005091507225659868e@mail.gmail.com>
	 <1126795310.3505.47.camel@station6.example.com>
	 <20050915190700.GA3354@midnight.suse.cz>
	 <d120d50005091512226a339890@mail.gmail.com>
	 <20050915202553.GA3977@midnight.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/05, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Thu, Sep 15, 2005 at 02:22:34PM -0500, Dmitry Torokhov wrote:
> > They are devices - class devices :). I have the following distinction
> > in my head - "normal" devices (bus devices) are real hardware devices
> > and their drivers need to do resource and/or power management. Class
> > devices represent virtual devices - some kind of abstraction - that
> > unify and combine "real" devices from several buses into one class.
> 
> Yes. While input drivers do need to care about power management usually,
> the input device abstraction itself doesn't have to, which makes it
> indeed a special kind of a device.
> 

Right. They just signal to underlying hardware driver when they are in
use (open), but the actual power management is left to the specific
bus/driver, not input core.

> I was always wondering whether the distinction between bus/class was
> needed, as the border isn't very clear.
> 

Classes combine devices which are logically the same, i.e. they
perform similar functions. Buses combine devices that are perform
different functions but have similar hardware interface. For example a
network cards - it is a class. You can have network card sit on a PCI,
USB, ISA buses but for the rest of the kernel they are accesses
through netdev abstraction. At least this is my understanding of our
device model ;)

-- 
Dmitry
