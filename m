Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVCUPfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVCUPfR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 10:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVCUPez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 10:34:55 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:22936 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S261824AbVCUPdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 10:33:46 -0500
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
From: Kenan Esau <kenan.esau@conan.de>
To: dtor_core@ameritech.net
Cc: harald.hoyer@redhat.de, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <d120d500050321065261ee815c@mail.gmail.com>
References: <20050217194217.GA2458@ucw.cz> <20050219131639.GA4922@ucw.cz>
	 <1108973216.5774.72.camel@localhost> <20050224090338.GA3699@ucw.cz>
	 <1109664709.18617.10.camel@localhost> <20050301120839.GA5720@ucw.cz>
	 <1110180436.3444.17.camel@localhost> <20050307073406.GA2026@ucw.cz>
	 <1110893143.4777.31.camel@localhost> <20050321124407.GA1762@ucw.cz>
	 <d120d500050321065261ee815c@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 21 Mar 2005 16:31:08 +0100
Message-Id: <1111419068.8079.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 21.03.2005, 09:52 -0500 schrieb Dmitry Torokhov:
> On Mon, 21 Mar 2005 13:44:07 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > On Tue, Mar 15, 2005 at 02:25:42PM +0100, Kenan Esau wrote:
> > > Here is a new version of the patch:
> > >       - minimal changes
> > >       - reintroduced DMI-probing
> > >
> > > I had a look at the synaptic-sources to see how the pass-through-mode is
> > > implemented. We'll see if something similar to this also works with the
> > > lifebook.
> > 
> > Thanks, I applied this version of the patch to my tree. It'll appear in
> > next -mm, and in 2.6.13.
> > 
> 
> There are couple of things that I an concerned with:
> 
> 1. I don't like that it overrides meaning of max_proto parameter to be
> exactly the protocol specified. 

Yeah -- I agree. I also don't like that double-meaning. That was the
reason why I originally proposed the use of a new parameter...

> However, if you take my psmouse
> protocol switching through sysfs patch we can drop that change and
> require that non auto-detectable protocols be activated through sysfs
> after loading the driver.

I think that would also be a good solution.

> 2. It looks like it bypasses rate and resolution setting in
> psmouse_initialize. What was the reason for it? Does setting rate or
> resolution disturbs lifebook mode? If so the driver has to implement
> it's own set_rate and set_resolution handlers so when one tries to
> change rate from userspace (through sysfs) the request would be
> ignored.

IMHO it does not make sense to call psmouse_initialize() although it
does not disturb lifebook-mode. But setting resolution is already done
during lifebook_initialize(). And there psmouse->set_resolution() and
psmouse->set_rate() are used so setting resolution and rate should also
work via sysfs.

My stomach feels strange when I call lifebook_initialize() and after
that call an xy_initialize() for some other protocol although it might
not disturb the lifebook-mode.

