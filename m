Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVBRSTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVBRSTX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 13:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVBRSTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 13:19:23 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:48944 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261454AbVBRSTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 13:19:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=I92+hbfW/mp9YNTqHLdosR3l9yuL7UlRgjs7V/vuOrEv8U5+6o7wByo6q6FhmL/u7ywP2P1rAdEggu6N2+R/SVD4LuPgEg6tmaLaOFDOc6u5xrjtDMGjsq7459ov3qhjytdI7Q+/sVZlrAiif3TMUshYL7PlA0kmqYLovkGWjjU=
Message-ID: <d120d50005021810195f16ac0d@mail.gmail.com>
Date: Fri, 18 Feb 2005 13:19:08 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6: drivers/input/power.c is never built
Cc: Pavel Machek <pavel@suse.cz>, Oliver Neukum <oliver@neukum.org>,
       Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050218170036.GA1672@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050213004729.GA3256@stusta.de>
	 <047401c515bb$437b5130$0f01a8c0@max>
	 <20050218132651.GA1813@elf.ucw.cz>
	 <200502181436.01943.oliver@neukum.org>
	 <20050218160153.GC12434@elf.ucw.cz> <20050218170036.GA1672@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2005 18:00:36 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Fri, Feb 18, 2005 at 05:01:53PM +0100, Pavel Machek wrote:
> 
> > > > It has quite a lot of #ifdefs for CONFIG_APM/CONFIG_ARM/CONFIG_ACPI,
> > > > and it will not work on i386/APM, anyway. I still believe right
> > > > solution is to add input interface to ACPI. /proc/acpi/events needs to
> > > > die, being replaced by input subsystem.
> > >
> > > But aren't there power events (battery low, etc) which are not
> > > input events?
> >
> > Yes, there are. They can probably stay... Or we can get "battery low"
> > key.
> 
> We even have an event class for that, EV_PWR in the input subsystem.

I really really think this is wrong. Power management should be
possible without input layer. EV_PWR is fine for telling input devices
to do something, like enter lower power mode and for sending _some_
requests to the PM system. But input layer shoudl not be used as a
generic transport. I mean battery low, docking requests, etc has
nothing to do with input.
-- 
Dmitry
