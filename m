Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbVDEOgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVDEOgg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 10:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVDEOgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 10:36:36 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:1683 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261745AbVDEOge
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 10:36:34 -0400
Subject: Re: [PATCH 00/04] Load keyspan firmware with hotplug
From: Marcel Holtmann <marcel@holtmann.org>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, Greg KH <greg@kroah.com>,
       Sven Luther <sven.luther@wanadoo.fr>,
       Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050405114543.GG10171@delft.aura.cs.cmu.edu>
References: <20050404100929.GA23921@pegasos>
	 <20050404191745.GB12141@kroah.com>
	 <20050405042329.GA10171@delft.aura.cs.cmu.edu>
	 <200504042351.22099.dtor_core@ameritech.net>
	 <1112692926.8263.125.camel@pegasus>
	 <20050405114543.GG10171@delft.aura.cs.cmu.edu>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 16:36:31 +0200
Message-Id: <1112711791.12406.26.camel@notepaq>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

> > I agree with Dmitry on this point. The IHEX parser should not be inside
> > firmware_class.c. What about using keyspan_ihex.[ch] for it?
> 
> That's what I had originally, actually called firmware_ihex.ko, since
> the IHEX format parser is not in any way keyspan specific and there are
> several usb-serial converters that seem to use the same IHEX->.h trick
> which could trivially be modified to use this loader.
> 
> But the compiled parser fairly small (< 2KB) and adding it to the
> existing module didn't effectively add any size to the firmware_class
> module since things are rounded to a page boundary anyways.

so it seems that this is usb-serial specific at the moment. Then I would
propose to add it to the core of the usb-serial driver. Unless no other
driver in the kernel needs a IHEX parser, I think it is bad idea to mess
it up at the moment. People are also working on a replacement for the
current request_firmware(), because the needs are changing. Try to keep
it close with the usb-serial for now.

Regards

Marcel


