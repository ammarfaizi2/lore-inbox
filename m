Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbVBVFOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVBVFOX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 00:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbVBVFOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 00:14:23 -0500
Received: from gate.crashing.org ([63.228.1.57]:30934 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262209AbVBVFOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 00:14:16 -0500
Subject: Re: POSTing of video cards (WAS: Solo Xgl..)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@linux.ie>,
       dri-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       xorg@lists.freedesktop.org
In-Reply-To: <a728f9f9050221205634a3acf0@mail.gmail.com>
References: <Pine.LNX.4.58.0502201049480.18753@skynet>
	 <4218BAF0.3010603@tungstengraphics.com>
	 <21d7e997050220150030ea5a68@mail.gmail.com>
	 <9e4733910502201542afb35f7@mail.gmail.com> <1108973275.5326.8.camel@gaston>
	 <9e47339105022111082b2023c2@mail.gmail.com>
	 <1109019855.5327.28.camel@gaston>
	 <9e4733910502211717116a4df3@mail.gmail.com>
	 <1109041968.5412.63.camel@gaston>
	 <a728f9f9050221205634a3acf0@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 16:13:36 +1100
Message-Id: <1109049217.5412.79.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-21 at 23:56 -0500, Alex Deucher wrote:

> another advantage of the emulator would be that "PC" vga cards could
> be used in non-x86 platforms, which I'm sure would be quite popular...

That's implied indeed... though Jon approach would require the common
code to "know" that we are on a platform that didn't run the x86 BIOS
on this or this card...

Some non-x86 platforms do already have an emulator in the firmware, some
do POST all cards, some don't, it's really tricky to try to "know" from
the generic code what to do here and will probably lead us into endless
trouble. (We may want to avoid some cards, broken BIOSes, etc... and do
it all by hand).

I think that the driver is the "chief" here and the one to know what to
do with the cards it drives. It can detect a non-POSTed card and deal
with it.

What we can/should provide, is a ncie helper to do the job once the
driver decides to have a go at it. I think userspace is the right
solution, similar to the firmware loader helpers, as I wrote earlier.
There are a few issues related on trying to run these before / is
mounted or during the sleep process, but those are things I plan to work
on & fix sooner or later. (Which is also why it has to be an
asynchronous API, so that the helper can call back "later" when the
helper has been found).

Ben.


