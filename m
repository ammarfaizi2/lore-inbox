Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269266AbUJKVhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269266AbUJKVhR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 17:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269265AbUJKVhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 17:37:17 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:51887 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S269277AbUJKVhJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 17:37:09 -0400
From: David Brownell <david-b@pacbell.net>
To: ncunningham@linuxmail.org
Subject: Re: Totally broken PCI PM calls
Date: Mon, 11 Oct 2004 14:37:17 -0700
User-Agent: KMail/1.6.2
Cc: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
References: <1097455528.25489.9.camel@gaston> <200410110936.37268.david-b@pacbell.net> <1097529469.4523.3.camel@desktop.cunninghams>
In-Reply-To: <1097529469.4523.3.camel@desktop.cunninghams>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200410111437.17898.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nigel,

On Monday 11 October 2004 2:17 pm, Nigel Cunningham wrote:
> On Tue, 2004-10-12 at 02:36, David Brownell wrote:
> > I've made that point too.  STD is logically a few steps:  quiesce system,
> > write image to swap, change power state.

I'm hoping you agree with that abbreviated summary of
what's involved!  Pavel seemed to.  Of course the devil is
in the details, which I hope to leave mostly to others ... ;)


> > The ACPI spec talks about 
> > that as keeping the system in a G1/S4 powered state, but "swusp"
> > doesn't use that ... it does a full power-off.   And of course,
> > full power-off 
> > means that the BIOS probably mucks with the USB hardware, so it's
> > not a real resume any more.
> 
> That's not necessarily true. Swsusp and suspend2 both include support
> for enter ACPI S4 state. For suspend2 it's optional (to allow for broken
> bioses). Not sure about whether it is with swsusp.

The machines I've tested with relatively generic 2.6.9-rc kernels
don't use BIOS support for S4 when I call swsusp.

Of course the ACPI spec muddies the water by talking about two
different states called "S4":  "S4 Sleeping", which is what I was
talking about as G1/S4; and "S4 Non-Volatile Sleep" that's more
what I've seen with swusp:  more like a G2 or G3 poweroff.

I'm willing to believe that there are systems on which swsusp
tells drivers a less confusing story ... but I don't seem to have
tested with those!

- Dave
