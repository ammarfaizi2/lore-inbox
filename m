Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbVKIVhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbVKIVhr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbVKIVhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:37:47 -0500
Received: from tim.rpsys.net ([194.106.48.114]:22222 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751484AbVKIVhq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:37:46 -0500
Subject: Re: [patch] Re: 2.6.14-rc5-mm1 - ide-cs broken!
From: Richard Purdie <rpurdie@rpsys.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       damir.perisa@solnet.ch, akpm@osdl.org,
       Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <43726269.7020600@tmr.com>
References: <20051103220305.77620d8f.akpm@osdl.org>
	 <20051104071932.GA6362@kroah.com>
	 <1131117293.26925.46.camel@localhost.localdomain>
	 <20051104163755.GB13420@kroah.com>
	 <1131531428.8506.24.camel@localhost.localdomain>  <437226B2.10901@tmr.com>
	 <1131557221.8506.76.camel@localhost.localdomain> <43726269.7020600@tmr.com>
Content-Type: text/plain
Date: Wed, 09 Nov 2005 21:37:14 +0000
Message-Id: <1131572234.8506.130.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-09 at 15:56 -0500, Bill Davidsen wrote: 
> Given the large number of possible valid configurations, I'm trying to 
> determine which you are trying to fix and if that will break the others.

I'm primarily fixing ide-cs but the same fix equally applies to any
CompactFlash interface directly accessed as an ide device. 

> There are, at minimum, three possible hardware attach cases, each of 
> which may be on a distribution which uses udev or not. I'm assuming that 
> if this is a udev problem is would be fixed at the udev level, but your 
> comment on "userspace hacks" does sound like fixes to userspace bugs.

Initially I'd have blamed udev but its actually doing exactly the right
thing in this case and is definitely not at fault. (I've described this
in detail in the past if you want more information.)

> The three attach methods are pcmcia, direct plugin slots (laptops only 
> AFAIK)

These both generally use ide-cs and the patch was written with this in
mind. 

There are a small number of broken adaptors which have been discussed
and the known ones are already worked around. 

> , and USB devices.
> 
> It seems that the pcmcia cases for laptops and desktops are the same, 
> and the whole media and device go away as a unit with the card. But for 
> USB and direct plug-in, the "device" seems to be present even without 
> media. I can't easily check that for laptop before tonight, but attached 
> USB devices show up as sdX currently, with or without media.

USB devices have secondary controllers between the card and the USB bus.
The ide interface is not exposed to the system and they're handled by a
totally different interface and driver (sd = scsidisk). This patch
doesn't change anything to do with that and their behaviour is correct.

Richard

