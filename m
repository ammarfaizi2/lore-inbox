Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbVJVWtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbVJVWtu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 18:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVJVWtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 18:49:50 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:14540 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751243AbVJVWtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 18:49:50 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Rob Landley <rob@landley.net>
Subject: Re: ipw2200 only works as a module?
Date: Sat, 22 Oct 2005 23:50:57 +0100
User-Agent: KMail/1.8.92
Cc: kronos@kronoz.cjb.net, Keenan Pepper <keenanpepper@gmail.com>,
       linux-kernel@vger.kernel.org, jketreno@linux.intel.com
References: <20050926171220.GA9341@dreamland.darkstar.lan> <200510191635.13253.rob@landley.net>
In-Reply-To: <200510191635.13253.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510222350.57605.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 October 2005 22:35, Rob Landley wrote:
> On Monday 26 September 2005 12:12, Luca wrote:
> > Keenan Pepper <keenanpepper@gmail.com> ha scritto:
> > > With CONFIG_IPW2200=y I get:
> > >
> > > ipw2200: ipw-2.2-boot.fw load failed: Reason -2
> > > ipw2200: Unable to load firmware: 0xFFFFFFFE
> > >
> > > but with CONFIG_IPW2200=m it works fine. If it doesn't work when built
> > > into the kernel, why even give people the option?
> > >
> > > BTW, a better error message than "Reason -2" would be nice. =)
> >
> > -2 is -ENOENT (no such file or directory). ipw2000 requests its firmware
> > using a hotplug event, but when the driver is compiled into the kernel
> > it gets loaded _before_ the root fs is mounted and of course the hotplug
> > system and the firmware are not available.
>
> Any possibility of extracting initramfs early enough that the firmware
> could live in there when this sucker's built in?
>

Another possible solution would be to delay initialisation of the hardware 
until the network interface is brought up. This is a more robust approach 
because then if something bad happens and the firmware needs to be reloaded, 
you can just cycle the interface (ifdown/ifup) and the firmware will be 
reuploaded.

An example of hardware doing this is the prism54 driver (also in tree) which 
delays loading the firmware until it absolutely has to. This driver survives 
being built-in quite happily.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
