Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbVBVGfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbVBVGfo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 01:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVBVGfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 01:35:44 -0500
Received: from gate.crashing.org ([63.228.1.57]:4567 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262213AbVBVGfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 01:35:36 -0500
Subject: Re: POSTing of video cards (WAS: Solo Xgl..)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, Dave Airlie <airlied@linux.ie>,
       dri-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       xorg@lists.freedesktop.org
In-Reply-To: <9e473391050221220564235858@mail.gmail.com>
References: <Pine.LNX.4.58.0502201049480.18753@skynet>
	 <21d7e997050220150030ea5a68@mail.gmail.com>
	 <9e4733910502201542afb35f7@mail.gmail.com> <1108973275.5326.8.camel@gaston>
	 <9e47339105022111082b2023c2@mail.gmail.com>
	 <1109019855.5327.28.camel@gaston>
	 <9e4733910502211717116a4df3@mail.gmail.com>
	 <1109041968.5412.63.camel@gaston>
	 <a728f9f9050221205634a3acf0@mail.gmail.com>
	 <1109049217.5412.79.camel@gaston>
	 <9e473391050221220564235858@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 17:34:52 +1100
Message-Id: <1109054092.5327.94.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-22 at 01:05 -0500, Jon Smirl wrote:
> On Tue, 22 Feb 2005 16:13:36 +1100, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > What we can/should provide, is a ncie helper to do the job once the
> > driver decides to have a go at it. I think userspace is the right
> > solution, similar to the firmware loader helpers, as I wrote earlier.
> > There are a few issues related on trying to run these before / is
> > mounted or during the sleep process, but those are things I plan to work
> > on & fix sooner or later. (Which is also why it has to be an
> > asynchronous API, so that the helper can call back "later" when the
> > helper has been found).
> 
> Can a userspace solution solve the problem of cards that need to be
> posted when they are coming out of suspend?

Yes, though they'll come up a bit later than the rest of the world if
the driver can't resume them itself (which is what should happen
normally, running the BIOS on resume is a hack).

Also, as I wrote earlier, what we care about now is the API in the form
of a helper. It fits well to have that helper just do something similar
to the firmware loader, running the stuff in userspace, but that isn't
mandatory, we could change later to be in-kernel, partially, or even
have a CONFIG option wether to have the emulator in kernel or not :)

The driver doesn't have to care if we provide a suitable API. And
userspace helper is a good enough implementation to start with.

Ben.


