Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264788AbSLTTDD>; Fri, 20 Dec 2002 14:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbSLTTDC>; Fri, 20 Dec 2002 14:03:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30731 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264788AbSLTTDC>; Fri, 20 Dec 2002 14:03:02 -0500
Date: Fri, 20 Dec 2002 11:11:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: davidm@hpl.hp.com, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.x disable BAR when sizing
In-Reply-To: <20021220215029.A22996@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.44.0212201108540.2035-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Dec 2002, Ivan Kokshaysky wrote:
>
> On Fri, Dec 20, 2002 at 09:05:53AM -0800, Linus Torvalds wrote:
> > One solution in the long term may be to not even probe the BAR's at all in
> > generic code, and only do it in the pci_enable_dev() stuff. That way it
> > would literally only be done by the driver, who can hopefully make sure
> > that the device is ok with it.
>
> I don't think that generic BAR probing is ever avoidable - too often
> it's the only way to build a consistent resource tree. Without that
> the driver cannot know whether the BAR setting is safe or there is a
> conflict with something else.

Well, generic BAR probing certainly isn't avoidable right now, that's for
sure. But we might make it less common, by doing it only "on demand", and
having default drivers for pci-pci bus bridges, for example (where the
default driver would do what we do now, but perhaps a way to register
specific bus drivers that know more about their specifics).

I don't think there are any real reasons to change what we do now - it
sounds like even David doesn't actually have any devices that actually
_need_ the disable as-is.

		Linus

