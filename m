Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWHCLZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWHCLZu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 07:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWHCLZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 07:25:50 -0400
Received: from ns1.suse.de ([195.135.220.2]:48814 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932376AbWHCLZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 07:25:48 -0400
Subject: Re: Generic battery interface
From: Thomas Renninger <trenn@suse.de>
Reply-To: trenn@suse.de
To: Jean Delvare <khali@linux-fr.org>
Cc: Pavel Machek <pavel@suse.cz>, Shem Multinymous <multinymous@gmail.com>,
       Vojtech Pavlik <vojtech@suse.cz>, "Brown, Len" <len.brown@intel.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org,
       Henrique de Moraes Holschuh <hmh@debian.org>,
       Mark Underwood <basicmark@yahoo.com>, Greg KH <greg@kroah.com>
In-Reply-To: <20060802091841.8585a72a.khali@linux-fr.org>
References: <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
	 <20060727232427.GA4907@suse.cz>
	 <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	 <20060728074202.GA4757@suse.cz>
	 <41840b750607280814x50db03erb30d833802ae983e@mail.gmail.com>
	 <20060728202359.GB5313@suse.cz>
	 <41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com>
	 <41840b750607291406p2f843054rc89fa1c3c467688d@mail.gmail.com>
	 <41840b750607301137t1e10fe88o3a1c73e7a4b4bf44@mail.gmail.com>
	 <20060731233536.92b39035.khali@linux-fr.org>
	 <20060731230145.GF3612@elf.ucw.cz>
	 <20060802091841.8585a72a.khali@linux-fr.org>
Content-Type: text/plain
Organization: Novell/SUSE
Date: Thu, 03 Aug 2006 13:29:06 +0200
Message-Id: <1154604546.4302.482.camel@queen.suse.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-02 at 09:18 +0200, Jean Delvare wrote:
> Hi Pavel,
> 
> > > frequently it can read from the chip. And no hardware monitoring chip I
> > > know of can tell when the monitored value has changed - you have to read
> > > the chip registers to know.
> > 
> > ACPI battery can tell when values change in significant way. (Like
> > battery becoming critical).
> 
> Ah, good to know. But is there a practical use for this? I'd suspect
> that the user wants to know the battery charge% all the time anyway,
> critical or not.

Some batteries throw an event for each consumed percent or at least
enough events to keep track of remaining power.
Some are only throwing an event when capacity warning/low is reached,
some aren't throwing any events.

It may be of use to reduce polling on some machines, but you will always
need a fall back. Determining whether the machine throws events
regularly is not really possible, so by default you will start to poll
the battery on all machines. Maybe in this case the normal (0x80)
battery events should be ignored to avoid double readings or the values
are cached in kernel as suggested, then it does not hurt.

One should also not rely on the warning/low capacity values.
I cannot say for sure whether all machines throw an event if these
limits are reached. We defined our own limits in userspace, this always
works. I'd go for not using the BIOS limits here at all and take user
defined capacity warning/low values (in percent) in hal or wherever.

IMO opinion the normal battery events (0x80) are not much of a use. They
probably should be forwarded, so that userspace could switch to irq
driven notification if this should ever work on more than 90% of the
machines, but default will be polling. More important are the status
events (0x81) if a battery is added/removed.

   Thomas

