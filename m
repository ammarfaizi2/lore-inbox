Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266534AbUIWUYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266534AbUIWUYG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266073AbUIWUVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:21:15 -0400
Received: from mail.humboldt.co.uk ([81.2.65.18]:20436 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S264991AbUIWUT3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:19:29 -0400
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
From: Adrian Cox <adrian@humboldt.co.uk>
To: Michael Hunold <hunold@linuxtv.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sensors@Stimpy.netroedge.com, Jon Smirl <jonsmirl@gmail.com>,
       Greg KH <greg@kroah.com>
In-Reply-To: <41527696.5060002@linuxtv.org>
References: <414F111C.9030809@linuxtv.org>
	 <20040921154111.GA13028@kroah.com>	 <41506099.8000307@web.de>
	 <41506D78.6030106@web.de> <1095843365.18365.48.camel@localhost>
	 <20040922102938.M15856@linux-fr.org> <1095854048.18365.75.camel@localhost>
	 <41527696.5060002@linuxtv.org>
Content-Type: text/plain
Message-Id: <1095970724.1683.232.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 23 Sep 2004 21:18:45 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-23 at 08:09, Michael Hunold wrote:
> We need to keep in mind, that the adapter interface must be a per-client 
> interface. On PCI devices it's simple: you have a i2c bus bound to a dvb 
> card and know which chipsets can be there. The bus is dvb specific.
> 
> On embedded platforms, however, you usually have one one i2c bus, where 
> everything is present: dvb frontends, audio/video multiplexers, 
> digital/analog audio converters, stuff like that.
> 
> So if you create *the* i2c bus and invite i2c client to participate at 
> the party, you need to provide different interfaces to the different 
> chipsets.

I may have to solve a similar problem when connecting an image sensor
directly to an embedded processor. My current idea looks a bit like
this:

1) The I2C bus is a platform device, created at boot time, independent
of my video capture module.
2) My module contains a dummy I2C driver, which exists solely to grab an
i2c_adapter pointer for the platform I2C device.

My underlying libraries don't have to worry whether the i2c_adapter came
from a parent PCI device or a platform device. My only worry is that
power management may still provide us with a headache, as we'll have to
cope with platform devices being suspended in any order.

- Adrian Cox
Humboldt Solutions Ltd.


