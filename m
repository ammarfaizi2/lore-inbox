Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269861AbTGOW4l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 18:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269864AbTGOW4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 18:56:41 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:41450 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP id S269861AbTGOW4i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 18:56:38 -0400
Date: Tue, 15 Jul 2003 16:15:48 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [More Info] Re: 2.6.0test 1 fails on eth0 up (arjanv RPM's - all
 needed rpms installed)
In-reply-to: <20030715210240.GA5345@kroah.com>
To: Greg KH <greg@kroah.com>
Cc: "Trever L. Adams" <tadams-lists@myrealbox.com>, arjanv@redhat.com,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <3F148B24.8080408@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
References: <1058196612.3353.2.camel@aurora.localdomain>
 <3F12FF53.7060708@pobox.com> <1058210139.5981.6.camel@laptop.fenrus.com>
 <1058217601.4441.1.camel@aurora.localdomain>
 <1058299838.3358.4.camel@aurora.localdomain> <20030715210240.GA5345@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> Hm, but usb_hcd_irq() reports back the proper interrupt return value.  I
> don't see how this could happen, unless the ehci driver was somehow
> halted...
> 
> David, any ideas?

It's getting an IRQ before the driver expects them,
I suspect.  I think the HCD glue needs a new entry,
forcing hardware reset before the rest of hcd init.
Easy/simple to do; and IMO reasonable too.

Of course, it's also strange that leaving ACPI on
causes problems at this level.  And that it only
happens for EHCI.

- Dave


