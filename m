Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266807AbUIEP0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbUIEP0H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 11:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266821AbUIEP0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 11:26:07 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:53891 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266807AbUIEP0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 11:26:02 -0400
Message-ID: <9e473391040905082659660d6@mail.gmail.com>
Date: Sun, 5 Sep 2004 11:26:01 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Intel ICH - sound/pci/intel8x0.c
Cc: lkml <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@suse.cz>
In-Reply-To: <1094385318.1099.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e4733910409041943490b9587@mail.gmail.com>
	 <1094385318.1099.23.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I can change so I don't have to take ownership of the bridge from
the PCI driver so there isn't a conflict.  "Intel ICH Joystick" is a
deceptive name for this driver. It should be named something like "LPC
bridge" since there are other things on that device than the joystick.
Why does just the joystick need a special driver and nothing else on
that bridge needs one? Wouldn't PS/2, serial, parallel, etc all have
this problem?

"Intel ICH" is also a bad driver name. I'd prefer something like
"snd_intel8x0" since that is what the module is named.

On Sun, 05 Sep 2004 12:55:27 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Also a lot of other vendors Midi and joystick ports do have PCI ids.

I was thinking about this from the probing side. You can't count on
midi and joystick ports having PCI IDs so you have to manually probe.
But I also see how a card with a PCI ID could have these ports on it
and also include logic for turning them off and on.

On Sun, 05 Sep 2004 12:55:27 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Sul, 2004-09-05 at 03:43, Jon Smirl wrote:
> > The joystick PCI ID table in intel8x0.c is not correct. Joysticks and
> > MIDI ports are ISA devices and need be located by manual probing. This
> > ID table needs to be removed. Joystick and MIDI ports do not have PCI
> > IDs.
> 
> It isn't that simple. The LPC bridge also contains the controls for the
> joystick ports. You also need them for hotplug handling of the bridge
> should someone stick one in a laptop docking station. The ID table also
> ensures the driver is loaded. It's probably true that it will need
> splitting up a bit if another driver also needs ownership of the LPC
> bridge but for now that hasn't happened.
> 
> Also a lot of other vendors Midi and joystick ports do have PCI ids.
> 
> Alan
> 
-- 
Jon Smirl
jonsmirl@gmail.com
