Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbTIFQCu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 12:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbTIFQCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 12:02:50 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:13710 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262905AbTIFQCs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 12:02:48 -0400
Date: Sat, 6 Sep 2003 17:02:00 +0100
From: Jamie Lokier <jamie@shareable.org>
To: David Brownell <david-b@pacbell.net>
Cc: Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       Linux usb mailing list 
	<linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: USB modem no longer detected in -test4
Message-ID: <20030906160200.GA10723@mail.jlokier.co.uk>
References: <20030903191701.GA2798@elf.ucw.cz> <20030903223936.GA7418@kroah.com> <20030903224412.GA6822@atrey.karlin.mff.cuni.cz> <20030903233602.GA1416@kroah.com> <20030904212417.GF31590@mail.jlokier.co.uk> <3F57C951.8030606@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F57C951.8030606@pacbell.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> >It worked fine in 2.5.75 too.  I have the same problem as Pavel, with
> >a different USB modem in -test4.
> 
> And ... does my suggestion to Pavel then improve things?
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=106263361810553&w=2
>   http://marc.theaimsgroup.com/?l=linux-usb-devel&m=106260875713372&w=2

Yes it does.

When loading the controller, these are some of the messages:

	PM: Adding info for usb:1-1:0
	PM: Adding info for usb:1-1:1
	drivers/usb/class/cdc-acm.c: need inactive config #2
	drivers/usb/class/cdc-acm.c: need inactive config #2

On loading cdc_acm:

	usb 1-1: control timeout on ep0in

When I do the echo 2 >/sys/bus/usb/devices/1-1/bConfigurationValue:

	acm: probe of 1-1:1 failed with error -5

I am able to open the modem device and use it after the echo, and not
before.  (I'm using it now).

> I'll submit a cdc-acm patch later to get rid of the need for the
> manual workaround.  And meanwhile, a hotplug script could automate
> this for you, in /etc/hotplug/usb/cdc-acm ...

So many other things don't work automatically for me in 2.6 that one
little echo for cdc_acm is a little thing.  Besides, hotplug doesn't
work either - something about the arguments to /sbin/hotplug has
changed since 2.4 and I am in no rush to install a new version.

Thanks for the modem fix.  I can now test the futex bug without going
offline :)

Cheers,
-- Jamie
