Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbUFBVdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUFBVdA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 17:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264223AbUFBVc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 17:32:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45069 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262425AbUFBVcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 17:32:31 -0400
Date: Wed, 2 Jun 2004 22:32:19 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Andrew Zabolotny <zap@homelink.ru>, Todd Poynor <tpoynor@mvista.com>,
       linux-kernel@vger.kernel.org
Subject: Re: two patches - request for comments
Message-ID: <20040602223219.B9322@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Andrew Zabolotny <zap@homelink.ru>,
	Todd Poynor <tpoynor@mvista.com>, linux-kernel@vger.kernel.org
References: <20040529012030.795ad27e.zap@homelink.ru> <40B7B659.9010507@mvista.com> <20040529121059.3789c355.zap@homelink.ru> <40BCE28A.1050601@mvista.com> <20040602010036.440fc5b4.zap@homelink.ru> <20040602171542.GL7829@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040602171542.GL7829@kroah.com>; from greg@kroah.com on Wed, Jun 02, 2004 at 10:15:42AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 10:15:42AM -0700, Greg KH wrote:
> On Wed, Jun 02, 2004 at 01:00:36AM +0400, Andrew Zabolotny wrote:
> > 
> > In theory, if we would use the standard power interface, it could use the
> > different levels of power saving, e.g. 0 - controller and LCD on, 1,2 - LCD
> > off, controller on, 3,4 - both off.
> 
> Please use the standard power interface, and use the standard levels of
> power state.  That's why we _have_ this driver model in the first
> place...

It /doesn't/ make any sense to in this case.  We're talking effectively
about the LCD panel attributes, not a device as such.

IOW:
- LCD backlight brightness
- LCD backlight on/off
- LCD panel power on/off

Typically, the last item needs to be closely controlled in relation to
the LCD controller itself, and it just does not make sense to separate
the LCD panel power control from the controller itself in the device
model.  In fact, exposing the LCD panel power control independent of
the LCD controller state can lead to cases where you end up destroying
your LCD panel - there is a very defined sequence to power up/down
these things to avoid degredation.

However, the issue is that all of the three things can be handled
god-knows-which-way on any platform, even when they're using the
same LCD controllers.  So we need a way for platform/machine specific
code to provide the information so that the LCD controller can
correctly handle these settings on blank, etc.

Hope this provides some extra reasoning why using the device model
for these attributes is wrong.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
