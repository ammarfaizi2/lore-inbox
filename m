Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWDXVaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWDXVaK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWDXVaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:30:09 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22657 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751298AbWDXVaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:30:06 -0400
Date: Mon, 24 Apr 2006 23:29:26 +0200
From: Pavel Machek <pavel@suse.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: dtor_core@ameritech.net, Matthew Garrett <mjg59@srcf.ucam.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Message-ID: <20060424212926.GO3386@elf.ucw.cz>
References: <20060419195356.GA24122@srcf.ucam.org> <20060419200447.GA2459@isilmar.linta.de> <20060419202421.GA24318@srcf.ucam.org> <d120d5000604240745i71bd56b8n99b97130388d36f6@mail.gmail.com> <1145894731.7155.120.camel@localhost.localdomain> <d120d5000604240926u51fc06d6gbf4f23832064e0ad@mail.gmail.com> <1145898341.7155.145.camel@localhost.localdomain> <20060424203424.GE3386@elf.ucw.cz> <1145912371.7155.220.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145912371.7155.220.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >(Another interesting question is: is AC status 0/1 or is it number of
> > milivolts?)
> 
> I'd say millivolts except for the problem of what you do on systems that
> don't support voltage readings. Use a very high value I guess. For a lot
> of devices millivolts also means in kernel conversion tables. Do such
> things belong in kernel or user space?

We should probably return 0/-1 in such case (-1 = on, but voltage unknown).

> > > to detect when its plugged in) ;). The battery class would export some
> > > information but not all of it and I don't know where the leftover
> > > information should go. If I knew that, I'd write the class.
> > 
> > Leftover information?
> 
> Where to put AC status and AC voltage readings amongst other things.
> Another sysfs class? Also, how do you control suspend/resume
> notifications to userspace if not using APM/ACPI?

I'd say that AC status should go to separate class, I'm
afraid. Potentially AC has more parameters (like current, current
frequency, difference between phase of current and voltage, ...?) and
UPSs even measure that.

Does userspace need to be notified of suspend/resume? [I keep
insisting that they do not, and I'm probably wrong, but... :-)]

								Pavel
-- 
Thanks for all the (sleeping) penguins.
