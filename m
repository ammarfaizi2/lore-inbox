Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753932AbWKMFWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932AbWKMFWw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 00:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753927AbWKMFWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 00:22:52 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:3729 "EHLO adelie.ubuntu.com")
	by vger.kernel.org with ESMTP id S1753932AbWKMFWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 00:22:51 -0500
Subject: Re: [RFC] Pushing device/driver binding decisions to userspace
From: Ben Collins <ben.collins@ubuntu.com>
To: Nicholas Miell <nmiell@comcast.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1163382425.2801.6.camel@entropy>
References: <1163374762.5178.285.camel@gullible>
	 <1163378981.2801.3.camel@entropy>  <1163381067.5178.301.camel@gullible>
	 <1163382425.2801.6.camel@entropy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 12 Nov 2006 21:22:44 -0800
Message-Id: <1163395364.5178.327.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-12 at 17:47 -0800, Nicholas Miell wrote:
> On Sun, 2006-11-12 at 17:24 -0800, Ben Collins wrote:
> > On Sun, 2006-11-12 at 16:49 -0800, Nicholas Miell wrote:
> > > On Sun, 2006-11-12 at 15:39 -0800, Ben Collins wrote:
> > > 
> > > What's wrong with making udev or whatever unbind driver A and then bind
> > > driver B if the driver bound by the kernel ends up being the wrong
> > > choice? (Besides the inelegance of the kernel choosing one and then
> > > userspace immediately choosing the other, of course.)
> > > 
> > > I'd argue that having multiple drivers for the same hardware is a bit
> > > strange to begin with, but that's another issue entirely.
> > 
> > If two drivers are loaded for the same device, there's no way for udev
> > to tell the kernel which driver to use for a device, that I know of.
> 
> /sys/bus/*/drivers/*/{bind,unbind}

"bind" does not tell the driver core to "bind this device with this
driver", it tells it to "bind this driver to whatever devices we match
that aren't already bound".

That doesn't solve my use case.

> > Also, that just sounds very horrible to do. If you have udev/dbus events
> > flying around for "device present", "device gone", "device present",
> > then it could make for a very ugly user experience (think of programs to
> > handle devices being started because of these events).
> 
> So don't fire the events until after the final binding.

It's still not a correct solution. If we want a specific driver to be
bound to a specific device, userspace shouldn't have to jump through
hoops to do it. It should be simple and clean.

The suggestions you are giving require userspace to work around a
deficiency in the kernel, by guessing the ordering requirements to
satisfy what the user wants. In cases of hotplugging, it is also
sometimes impossible to satisfy these requirements using the current
scheme.
