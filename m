Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262366AbUKDTIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbUKDTIM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbUKDTIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:08:11 -0500
Received: from web81309.mail.yahoo.com ([206.190.37.84]:44370 "HELO
	web81309.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262366AbUKDTGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:06:19 -0500
Message-ID: <20041104190619.76178.qmail@web81309.mail.yahoo.com>
Date: Thu, 4 Nov 2004 11:06:19 -0800 (PST)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH 2.6.10-rc1 4/4] driver-model: attach/detach sysfs node implemented
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>, Tejun Heo <tj@home-tj.org>,
       rusty@rustcorp.com.au
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Greg KH wrote:
> On Thu, Nov 04, 2004 at 12:05:31PM -0500, Dmitry Torokhov wrote:
> > Also, there usually much more going on with regard to locking and
> > other bus-specific actions besides taking bus's rwsem when binding
> > devices. Serio bus will definitely get upset if you try to disconnect
> > even a leaf device in the manner presented above and I think USB
> > will get upset as well.
> 
> No, we can disconnect a driver from a device just fine for USB with no

What about connecting? I am pretty ignorant of USB inner workings
but when I took a glance there seems to be a lot of preparations
before device is ready to be probed...

> problems (as long as it's not the hub driver from a hub device, we need
> to never be able to disconnect those.)

Never say never ;) That was the first thing I did after playing with
PCI devices when I tried doing what Tejun did.

If kernel advertises an userspace interface it will be used. I can see
myself wanting to disconnect my hub and all its devices so my wireless
explorer does not use batteries and I do not want to figure out what
port it is connected to... Someone else will find another reason,
I don't know.

I also think that even PCI should kill children devices behind a bridge
if bridge driver is disconnected to manage resources in more strict way.
But I think that would require notion of generic/specialized driver and
require automatic rebinding of specialized driver over generic one so
every PCI device has a driver attached to it.

-- 
Dmitry

