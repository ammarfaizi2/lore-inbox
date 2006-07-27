Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWG0XYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWG0XYx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 19:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWG0XYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 19:24:53 -0400
Received: from styx.suse.cz ([82.119.242.94]:12497 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750823AbWG0XYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 19:24:51 -0400
Date: Fri, 28 Jul 2006 01:24:27 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
Message-ID: <20060727232427.GA4907@suse.cz>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 11:32:39PM +0300, Shem Multinymous wrote:

> >Also, critical battery alarms are important events.
> 
> Yes, but not time-sensitive.

They well can be. And it'd be pretty stupid to just throw away the
events the hardware offers to us and use polling from userspace, too.

> >Please do not add more polling to user-space, else DaveJ
> >will be putting it up as a further example of "Why userspace sucks"
> >at the next OLS:-)
> 
> Battery polling is already used extensively, and its overhead is
> completely negligible.

You're joking, right? On quite a number of laptops, it takes quite a
while to read the battery, spent in BIOS through SMI, polling the I2C
bus while talking to the battery. The less often this is done, the
better.

> I'm yet to see any deployed userspace code
> trying to query battery status more than once per second.

The applets that were doing it (yes, up to 100 times per second)
corrected their ways pretty quickly, because some machines became
unusable with the applet enabled.

> On the other hand, if you send an event whenever the voltage or
> current change, you'll flood userspace with junk. So you'll need to
> have a "fuzz" like in the input device code; but this may be
> client-specific or hardware-specific.

You could, trivially, mirror the behavior of current applets: Not report
the changes to the battery status more often than each N seconds, except
for critical events.

Said that, there haven't been many problems reported in the input layer
that I could attibute to bad default selection of fuzz.

> And you'll need to identify devices in a useful way, a problem that's
> not yet solved even for input devices... You see where it's going.

May you be more specific here? I'm not aware of any problems in this
area. This may be my fault: What needs to be fixed there?

-- 
Vojtech Pavlik
Director SuSE Labs
