Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbVFHV1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVFHV1d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 17:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVFHV1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 17:27:33 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49071 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261998AbVFHV1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 17:27:24 -0400
Date: Wed, 8 Jun 2005 23:27:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: James Ketrenos <jketreno@linux.intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Netdev list <netdev@oss.sgi.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       "James P. Ketrenos" <ipw2100-admin@linux.intel.com>
Subject: Re: ipw2100: firmware problem
Message-ID: <20050608212707.GA2535@elf.ucw.cz>
References: <20050608142310.GA2339@elf.ucw.cz> <42A723D3.3060001@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A723D3.3060001@linux.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >I'm fighting with firmware problem: if ipw2100 is compiled into
> >kernel, it is loaded while kernel boots and firmware loader is not yet
> >available. That leads to uninitialized (=> useless) adapter.
> >  
> >
> We've been looking into whether the initrd can have the firmware affixed
> to the end w/ some magic bytes to identify it.  If it works, enhancing
> the request_firmware to support both hotplug and an initrd approach may
> be reasonable.

That seems pretty ugly to me... imagine more than one driver does this
:-(.

> >What's the prefered way to solve this one? Only load firmware when
> >user does ifconfig eth1 up? [It is wifi, it looks like it would be
> >better to start firmware sooner so that it can associate to the
> >AP...].
> >  
> >
> The debate goes back and forth on whether devices should come up only
> after they are told, or initialize and start looking for a network as
> soon as the module is loaded.
> 
> I lean more toward having the driver just do what it is told, defaulting
> to trying to scan and associate so link is ready as soon as possible. 
> We've added module parameters to change that behavior (disable and
> associate for the ipw2100).

Having a parameter to control this seems a bit too complex to me.

How is 

insmod ipw2100 enable=1

different from

insmod ipw2100
iwconfig eth1 start_scanning_or_whatever

?

								Pavel
