Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbUCPPsk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 10:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbUCPPpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 10:45:42 -0500
Received: from mail.kroah.org ([65.200.24.183]:36030 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263147AbUCPPpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 10:45:16 -0500
Date: Tue, 16 Mar 2004 07:44:54 -0800
From: Greg KH <greg@kroah.com>
To: Michael Hunold <hunold@convergence.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sensors@stimpy.netroedge.com
Subject: Re: [RFC][2.6] Additional i2c adapter flags for i2c client isolation
Message-ID: <20040316154454.GA13854@kroah.com>
References: <4056C805.8090004@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4056C805.8090004@convergence.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 10:25:25AM +0100, Michael Hunold wrote:
> Here, all client drivers are unconditionally told to try and attach to
> the adapter. There is no way that an i2c adapter can keep an i2c driver
> away from the bus.

Yes, but the different i2c chip drivers all check for the class setting
to be correct before they really do anything, right?

> Currently, adapters can already specify a class, for DVB
> I2C_ADAP_CLASS_TV_DIGITAL matches perfectly.

Yes, and that is what you should check for.  It's a bug if any of the
non-DVB i2c drivers probe devices with the .class set to
I2C_ADAP_CLASS_TV_DIGITAL.  Fix that and you should be fine, right?

> What I'd like to have is that client can specify some sort of "class",
> too, and that i2c adapters can tell the core that only clients where the
> class is matching are allowed to probe their existence.

Yeah, right now it's up to the chip drivers to be honest.  If you want
to implement a change to do this instead, I'll be glad to apply it.

thanks,

greg k-h
