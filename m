Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269760AbUICSmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269760AbUICSmW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 14:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269480AbUICSkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 14:40:15 -0400
Received: from hagen.doit.wisc.edu ([144.92.197.163]:17313 "EHLO
	smtp7.wiscmail.wisc.edu") by vger.kernel.org with ESMTP
	id S269704AbUICSiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 14:38:12 -0400
Date: Fri, 03 Sep 2004 18:38:06 +0000
From: John Lenz <lenz@cs.wisc.edu>
Subject: Re: [PATCH 2.6.8.1 0/2] leds: new class for led devices
In-reply-to: <20040903135103.GA982@elf.ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Message-id: <1094236686l.7429l.0l@hydra>
MIME-version: 1.0
X-Mailer: Balsa 2.2.4
Content-type: text/plain; Format=Flowed; DelSp=Yes; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Spam-Score: 
X-Spam-Report: IsSpam=no, Probability=7%, Hits=__CD 0, __CT 0, __CTE 0,
 __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0,
 __SANE_MSGID 0
X-Spam-PmxInfo: Server=avs-2, Version=4.7.0.111621, Antispam-Engine: 2.0.0.0,
 Antispam-Data: 2004.9.3.0, SenderIP=146.151.41.63
References: <1094157190l.4235l.2l@hydra> <20040903135103.GA982@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/04 08:51:03, Pavel Machek wrote:
> > function : a read/write attribute that sets the current function of
> > this led.  The available options are
> >
> >  timer : the led blinks on and off on a timer
> >  idle : the led turns off when the system is idle and on when not idle
> >  power : the led represents the current power state
> >  user : the led is controlled by user space
> 
> I'm afraid this is really good idea. It seems quite overengineered to
> me (and I'd be afraid that idle part slows machine). Perhaps having
> only "user" mode is better idea?

I was only mimicing the support currently in the arm led code.
After thinking about it from a broader perspective of including GPIOs,
we should probably get rid of this function thing entirely.  Just let user  
space do everything... userspace can monitor sysfs and hotplug and have the  
led represent power or idle or whatever.

> 
> > light : a read/write attribute that allows userspace to see the current
> 
> > status of the led.  If function="user" then writing to this attribute
> > will change the led on or off.  If function != "user" then writing has
> > no effect.
> >  light is an integer, where 0 means off, 1 means on first color, 2
> > means on second color, etc.  (for example, if color="green/blue" then
> > light=1 means turn led on to green and if light=2 means turn led on to
> > blue.
> 
> Is there ways to turn on both?

depends on the hardware...

The led class does not really inforce any policy, it just passes this
number along to the actual driver that is registered.  So say you had
a led that could be red, green, or both red and green at the same time
(not sure how that would work hardware wise, but ok).  The driver could
do something like set color="red/green/red&green" and then use 0,1,2,3.
The kernel is just reflecting the possible states the hardware could be
in.

John



