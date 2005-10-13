Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbVJMVV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbVJMVV7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 17:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVJMVV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 17:21:59 -0400
Received: from qproxy.gmail.com ([72.14.204.203]:32883 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964842AbVJMVV6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 17:21:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DhTysjIZJDkDWaobwoqUR0I8cMv0khXTO29+03mlHAnKAGyxy23LAWbTbufiC00BABg6JqCzS9jwjr1TZl0oaE3+CBzNKN34s1yX0J/XzOKMl6RmkKIfExD1Hwr2YibnAyMWy1KakvB6jO+hpmr9Z8zYYdZK20t3Sc1MyqR4v4U=
Message-ID: <d120d5000510131421r5637ef98h7a7a5af794d1b744@mail.gmail.com>
Date: Thu, 13 Oct 2005 16:21:57 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
Cc: Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051013063800.GA12008@midnight.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051013020844.GA31732@kroah.com>
	 <20051013063800.GA12008@midnight.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/05, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Wed, Oct 12, 2005 at 07:08:44PM -0700, Greg KH wrote:
> >
> > Oh, one final thing.  I really don't think that input should be a class.
> > It looks like a "bus" and acts like a "bus" (you have different devices
> > that have different drivers bind to them, and you want to load those
> > drivers with the hotplug mechanism.)
>
> [ Vojtech mumbles something about saying that from the beginning. ]
>

I think Greg spoke a bit hastily here. Input_devs do not directly talk
to the hardware and do not control power management and do not define
access methods for the hardware therefore using bus abstraction would
be wrong.

> > The only thing keeping this from
> > being a bus is the fact that we can't bind multiple drivers to a single
> > device these days, and I can't see a way to move this code to that
> > model, so oh well...
>

We should never let multiple drivers control the same piece of
hardware (in all cases where you would you can always split that piece
into smaller pieces, each controlled by its own driver). Input
intrefaces, on the other hand, are not drivers in regular sense, they
do not alter behavior of the underlying hardware. They just provide
different "views"/interfaces for the same device and because they
don't touch the hardware there can be many of them attached to the
same device. This is the crucial difference between them and normal
drivers.

--
Dmitry
