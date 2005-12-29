Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbVL2XHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbVL2XHB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 18:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVL2XHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 18:07:01 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:18022 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751109AbVL2XHB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 18:07:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SYUYj0yWTtf1phR5jTAMQzveQO8nBGyshfWitjFzpJ7Z0ZwcyRa7PF4hV4EHXnP3uApO0w6W/L7QKqL4g5lPCZ4sH6wPtCkDrL9n9LrVyA9PAiFKW+36tc4cjfBqdt4Mulr6rVK8MEWVl6wcYVGFj7HYqGndw18uWWw1SZbYomM=
Message-ID: <d120d5000512291507lfb8154fjf1b6d2d8a65faeb3@mail.gmail.com>
Date: Thu, 29 Dec 2005 18:07:00 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: userspace breakage
In-Reply-To: <20051229224103.GF12056@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
	 <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
	 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
	 <20051228201150.b6cfca14.akpm@osdl.org>
	 <20051229073259.GA20177@elte.hu>
	 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>
	 <20051229202852.GE12056@redhat.com>
	 <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org>
	 <20051229224103.GF12056@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/05, Dave Jones <davej@redhat.com> wrote:
> On Thu, Dec 29, 2005 at 12:49:16PM -0800, Linus Torvalds wrote:
>
>  > Umm.. Complain more. I upgrade kernels a lot more often than I upgrade
>  > distros, and things don't break. They're not allowed to break, because I
>  > refuse to upgrade my user programs just because I do kernel development.
>  > But I'd only notice a small part of user space, so if people don't
>  > complain, they break not because we don't care, but because we didn't even
>  > know.
>  >
>  > So if you have a user program that breaks, _complain_. It's really not
>  > supposed to happen outside of perhaps kernel module loaders etc things
>  > that get really really chummy with kernel internals (and even that was
>  > fixed: the modern way of loading modules isn't that chummy any more, so
>  > hopefully we'll not need to break even module loaders again).
>  >
>  > If we change some /proc file thing, breakage is often totally
>  > unintentional, and complaining is the right thing - people might not even
>  > have realized it broke.
>  >
>  > At least _I_ take breakage reports seriously. If there are maintainers
>  > that don't, complain to them. I'll back you up. Breaking user space simply
>  > isn't acceptable without years of preparation and warning.
>
> The udev situation I mentioned has been known about for at least a month,
> probably longer. With old udev, we don't get /dev/input/event* created
> with 2.6.15rc.
>

Once input core was converted to sysfs the bereakage was unavoidable.
Because of historical oversight input_dev and input interfaces, such
as mouseX were generating the same "input" events with different
arguments. The option was either to go with separate classes
(breakage) or making hierarchy within one class (breakage again). And
sysfs conversion was needed to do hotplug over netlink...

> At some point in time it became defacto that certain things like udev, hotplug,
> alsa-lib, wireless-tools and a bunch of others have to have kept in lockstep
> with the kernel, and if it breaks, it's your fault for not upgrading
> your userspace.
>

I would say that udev and hotplug is special kind of userspace as it
really extension of the kernel. It would probably be best if udev was
packaged together with the kernel.

--
Dmitry
