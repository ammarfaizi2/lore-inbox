Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUIWRbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUIWRbo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 13:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266457AbUIWRaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 13:30:13 -0400
Received: from hagen.doit.wisc.edu ([144.92.197.163]:57062 "EHLO
	smtp7.wiscmail.wisc.edu") by vger.kernel.org with ESMTP
	id S268197AbUIWR2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 13:28:31 -0400
Date: Thu, 23 Sep 2004 17:28:25 +0000
From: John Lenz <lenz@cs.wisc.edu>
Subject: Re: [PATCH] new class for led devices
In-reply-to: <20040922220715.GA30210@elf.ucw.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Message-id: <1095960505l.4817l.0l@hydra>
MIME-version: 1.0
X-Mailer: Balsa 2.2.4
Content-type: text/plain; Format=Flowed; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Spam-Score: 
X-Spam-Report: IsSpam=no, Probability=7%, Hits=__CD 0, __CT 0, __CTE 0,
 __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0,
 __SANE_MSGID 0
X-Spam-PmxInfo: Server=avs-4, Version=4.7.0.111621, Antispam-Engine: 2.0.0.0,
 Antispam-Data: 2004.9.22.6, SenderIP=146.151.41.63
References: <1095829641l.11731l.0l@hydra> <20040922072727.GA4553@ucw.cz>
 <1095882787l.4629l.0l@hydra> <20040922220715.GA30210@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/04 17:07:15, Pavel Machek wrote:
> Hi!
> 
> > >Well, we already have an interface for setting LEDs through the input
> > >layer, it'd be trivial to create an input device driver with just  
> > >LEDs
> > >and no buttons/keys ...
> > >
> > 
> > It's not really a nice fit with what we are trying to do.  In the input  
> > layer, there is a whole list of led types, none of which make sense...  
> > For example, on the Sharp Zaurus, we have two leds, one green, one  
> > amber.  Which one is LED_NUML?  We don't enforce anything on the policy  
> > userspace has for the leds, sometimes it might use the amber led to let  
> > the user know they have new mail, and sometimes to show the power is  
> > plugged in, sometimes for something else (maybe even that caps lock or  
> > numlock is on).
> 
> Actually on zaurus one led is labeled "CHARGING" and second is labeled
> "MAIL". There are PC keyboards with "MAIL" led already, I
> believe... It does not seem to be that bad fit. I do not think you
> want to label leds by colors, machine may well have three green leds
> (see normal pc keyboard). And on most machines you do not even know
> what color the leds are (new notebooks like blue leds :-().
> 
> So right solution seems to be adding LED_MAIL and LED_CHARGING and be
> done with that...

Yeah, that would work.  And if userspace wants to use the led for something
else, just uses MAIL and CHARGING as the names of the leds.

Signed-off-by: John Lenz <lenz@cs.wisc.edu>

--- bk/include/linux/input.h~input
+++ bk/include/linux/input.h
@@ -542,6 +542,8 @@
 #define LED_SUSPEND		0x06
 #define LED_MUTE		0x07
 #define LED_MISC		0x08
+#define LED_MAIL		0x09
+#define LED_CHARGING		0x0a
 #define LED_MAX			0x0f
 
 /*


