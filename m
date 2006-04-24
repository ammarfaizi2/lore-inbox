Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWDXU7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWDXU7s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWDXU7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:59:47 -0400
Received: from tim.rpsys.net ([194.106.48.114]:52390 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751270AbWDXU7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:59:46 -0400
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@suse.cz>
Cc: dtor_core@ameritech.net, Matthew Garrett <mjg59@srcf.ucam.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
In-Reply-To: <20060424203424.GE3386@elf.ucw.cz>
References: <20060419195356.GA24122@srcf.ucam.org>
	 <20060419200447.GA2459@isilmar.linta.de>
	 <20060419202421.GA24318@srcf.ucam.org>
	 <d120d5000604240745i71bd56b8n99b97130388d36f6@mail.gmail.com>
	 <1145894731.7155.120.camel@localhost.localdomain>
	 <d120d5000604240926u51fc06d6gbf4f23832064e0ad@mail.gmail.com>
	 <1145898341.7155.145.camel@localhost.localdomain>
	 <20060424203424.GE3386@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 21:59:31 +0100
Message-Id: <1145912371.7155.220.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 22:34 +0200, Pavel Machek wrote:
> What is on the jack, BTW? Left headphone, right headphone, mic in? Can
> all of them be used independently?

> > It gets tricky. AC presence isn't a property of a battery for example
> > and is in fact more like a switch (my handheld has a mechanical
> > switch
> 
> Oops, really? Mechanical switch to sense ac in? (What happens when you
> plug in charger but that is not plugged to AC?)

Most of the Zaurus devices can measure the AC voltage and make sanity
checks on it in the SharpSL Battery/PM code.

> I think that AC presence should be handled independently from
> battery. There can be >1 battery in the system.

Agreed. This is some of the leftover information I'm referring to below.

>(Another interesting question is: is AC status 0/1 or is it number of
> milivolts?)

I'd say millivolts except for the problem of what you do on systems that
don't support voltage readings. Use a very high value I guess. For a lot
of devices millivolts also means in kernel conversion tables. Do such
things belong in kernel or user space?

> > to detect when its plugged in) ;). The battery class would export some
> > information but not all of it and I don't know where the leftover
> > information should go. If I knew that, I'd write the class.
> 
> Leftover information?

Where to put AC status and AC voltage readings amongst other things.
Another sysfs class? Also, how do you control suspend/resume
notifications to userspace if not using APM/ACPI?

> I think we should create directory in sysfs, and populate it according
> to battery's capabilities.
> 
> Zaurus' battery would have voltage and maybe percent fields.
> 
> ACPI battery would have all the usual fields.
> 
> Another important question is a way for user applications to avoid
> polling... but I guess that should be solveable by enabling select on
> one of those files.

Agreed, this is something that would be needed.

Richard

