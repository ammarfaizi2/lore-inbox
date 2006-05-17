Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWEQUzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWEQUzX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 16:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWEQUzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 16:55:23 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:33289 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751109AbWEQUzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 16:55:22 -0400
Date: Wed, 17 May 2006 22:55:18 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Heiko Gerstung <heiko@am-anger-1.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB net driver hacker wanted (was Re: Bug related to bonding)
Message-ID: <20060517205518.GC28707@w.ods.org>
References: <44684B60.1070705@am-anger-1.de> <20060516045332.GN11191@w.ods.org> <44695D2A.9080705@am-anger-1.de> <20060516123351.GA22040@w.ods.org> <4469EB32.80806@am-anger-1.de> <20060516182324.GA23413@w.ods.org> <446B6BF8.5050208@am-anger-1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446B6BF8.5050208@am-anger-1.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2006 at 08:31:20PM +0200, Heiko Gerstung wrote:
> Hi List!
> 
> I am still having problems with rtl8150.c on Linux 2.4.32 ...
> 
> Willy Tarreau wrote:
> >> Please find below the complete async_get_registers function I set up, I
> >> hope it's OK to post it here. A kernel hacker will immediately spot the
> >> error, no? :-)
> >>     
> > Just a guess : I suspect that dev->ctrl_urb is NULL. I don't know how you
> > are supposed to initialize it though.
> >   
> You were right :-) It was a question of how things get initialized.
> My current state is that I am able to load the module but using my
> async_get_register function does not succeed due to timeouts. I am no
> kernel hacker and therefore it is like running through the darkest night
> with my sunglasses on :-) ... I sincerely hope, the maintainer of the
> driver helps me out...

I have no clue in this area either, unfortunately.

> It is interesting to see that with a 2.4.20 kernel I have no problems
> with loading the driver, it only crashes when I run net-snmp on it and
> then fire up an snmpwalk (which, I guess, queries the driver for some
> interface statistics or something like that).

You mean the bonding driver ? Older versions did not support ethtool ioctl(),
but only MII calls. I don't remember at what version it changed, but I suspect
from what you're saying that your driver might work if you disable ethtool.

Take a look at the bonding driver, there's a place where it first tries if
ethtool is supported on the driver, and if not it uses MII. I think that
commenting out one "if" statement would be close to enough.

> Deadline is coming and still no hope, yet. We'll see...

There's always hope, you have all the code :-)

> 
> Kind regards,
> Heiko

Regards,
Willy

