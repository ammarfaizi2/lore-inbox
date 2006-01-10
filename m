Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWAJGsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWAJGsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 01:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWAJGsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 01:48:43 -0500
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:40526 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750832AbWAJGsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 01:48:41 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 12/24] pcspkr: register with driver core as a platfrom device
Date: Tue, 10 Jan 2006 01:48:37 -0500
User-Agent: KMail/1.8.3
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       mikey@neuling.org
References: <20060107171559.593824000.dtor_core@ameritech.net> <20060107172100.901011000.dtor_core@ameritech.net> <1136875317.10235.4.camel@localhost.localdomain>
In-Reply-To: <1136875317.10235.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601100148.38228.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 January 2006 01:41, Benjamin Herrenschmidt wrote:
> On Sat, 2006-01-07 at 12:16 -0500, Dmitry Torokhov wrote:
> > plain text document attachment (pcspkr-platform-device.patch)
> > Input: pcspkr - register with driver core as a platfrom device
> 
> Hi Dimitri !
> 
> That looks great, something we've been wanting to tackle for a while...
> except for one thing :)
> 
> The actual creation of the device shouldn't be done there... only the
> driver should be there. The device instanciation should be moved to the
> i386 arch code (and/or any other architecture that might have this
> thing).
> 
> On ppc64 for example, we have machines that will blow up when that
> driver tries to poke random IOs, but we also have machines that do have
> that legacy piece of hardware where expected. We can know it from the
> firmware, thus we can decide wether to create the platform device or not
> from the arch code.
> 
> What do you prefer ? Keep that the way you did for now and add some
> #ifdef CONFIG_PPC64 with the ppc64 probe code in that driver or do you
> want to call all the way to moving the actual device creation to the
> platform code (as I think should be done) ?
> 

Having platform code instantiate platform devices would be great but I
wonder how it will look like on x86 where we don't have a way to enumerate
devices. ACPI might do it but I am not sure if all DSDTs describe beepers...

-- 
Dmitry
