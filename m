Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVCOUkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVCOUkW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 15:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVCOUIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 15:08:17 -0500
Received: from isilmar.linta.de ([213.239.214.66]:9692 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261881AbVCOUGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 15:06:53 -0500
Date: Tue, 15 Mar 2005 21:06:53 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Changes to the driver model class code.
Message-ID: <20050315200653.GA3068@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net,
	Kay Sievers <kay.sievers@vrfy.org>
References: <20050315170834.GA25475@kroah.com> <20050315190847.GA1870@isilmar.linta.de> <20050315195121.GA27408@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315195121.GA27408@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 11:51:21AM -0800, Greg KH wrote:
> > Also, it seems to me that you view the class subsystem to be too closely
> > related to /dev entries -- and for these /dev entries class_simple was
> > introduced, IIRC. However, /dev is not the reason the class subsystem was 
> > introduced for -- instead, it describes _types_ of devices which want to
> > share (userspace and in-kernel) interfaces.
> 
> I agree, I know it isn't directly related to /dev entries, but that _is_
> the most common usage of it, so I can't ignore it :)

I did not say "ignore". Having the new interface available (patches 1-3)
seems to be a sensible thing to do. Removing the so-called "old" api
(patches 4-x) is a different topic, though.

> Anyway, it's very simple to convert over to using the new functions, and
> still have all of your sysfs and reference counting functionality.  See
> the USB patch that I posted in this series as an example of how to do
> this.  Just use a kref and a pointer to the class_device.  You have all
> of the previous functionality that you needed before right there.

However, you need to do it in _addition_ -- you don't get it "for free" if
using struct class. Which means prgrammers need to think of two things
instead of one. And that's bad(TM).

Also, the lack of proper reference counting in several parts of the kernel
is proof enough that there's need to "encourage" reference counting. And
that's something the class subsystem did and does by providing easy
"embedded" reference counting, by warning on missing !release functions etc.

> class interfaces are not going away, there's a good need for them like
> you have pointed out.  I'm not expecting to just delete those api
> functions tomorrow, but slowly phase out the use of them over time, and
> hopefully, eventually get rid of them.  I think that with my USB host
> controller patch, I've proved that they are not as needed as you might
> think they were.

Indeed, such _workarounds_ are possible. A patch which converts pcmcia to
this new infrastructure would be quite trivial to write. However: I think we
should NOT do it. As it is a workaround to the more elegant solution the
"old" class API alllowed for.

> It's easy to make a complex, powerful, all-singing-all-dancing api.
> That's what we have today.  It's hard to make such an api easy to use,
> that's what we need to realize and start to fix.  This is the first of
> such steps to try to achieve this.

Math is hard, so let's go shopping. The "I want a /dev-entry"-api may get 
easier with your patches 1-3. With your patch 4 there is no improvement in
this area, however the "I want sane device-related reference counting"-api
will be much more difficult to get right.

Thanks,
	Dominik
