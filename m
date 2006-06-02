Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWFBClq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWFBClq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 22:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWFBClp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 22:41:45 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:30898 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751150AbWFBClp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 22:41:45 -0400
Date: Thu, 01 Jun 2006 20:39:41 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [linux-usb-devel] Re: USB devices fail unnecessarily on unpowered
 hubs
In-reply-to: <6j5oR-7Sw-11@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: David Liontooth <liontooth@cogweb.net>
Message-id: <447FA4ED.8070204@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <6iS8y-35Z-5@gated-at.bofh.it> <6iWP5-2gj-71@gated-at.bofh.it>
 <6iYxg-53W-29@gated-at.bofh.it> <6j5oR-7Sw-11@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Liontooth wrote:
> It's clearly a good thing to be testing for this. As Alan points out,
> 100mA is the maximum permitted pre-configuration draw, so what a device
> draws when plugged in is not informative.
> 
> However, obeying the USB power rules is not an end in itself -- the
> relevant question is the minimum power the device requires to operate
> correctly and without damage.
> 
> The MaxPower value does not appear to be a reliable index of this. My
> USB stick has a MaxPower value of 178mA and works flawlessly off an
> unpowered hub. Unfortunately devices don't seem to tell us what their
> minimum power requirements are, so we need more flexibility in writing
> rules for this.

The fact it appears to work on an unpowered hub doesn't mean anything. 
Why would the manufacturer specify it can consume 178 mA if it couldn't 
consume that much under some conditions? Have you measured it? What 
makes you think that the hub can supply that much power on all ports at 
the same time despite not being specified to do so?

Trying to say "Well, it says it needs this much, but it probably doesn't 
really NEED that much.." is an unreliable guessing game.

> 
> udev could surely pick up on the MaxPower value and tolerate up to a
> 100% underrun on USB flash drives. That would likely still 90% of the
> pain right there, maybe all of it.
> 
> What are the reasons not to do this? What happens if a USB stick is
> underpowered to one unit? Nothing? Slower transmission? Data loss? Flash
> memory destruction? If it's just speed, it's a price well worth paying.

If the device can't get enough power, all kinds of bad stuff can happen. 
  This is the reason why USB power budgeting is part of the standard in 
the first place. The kernel has no business ignoring such restrictions, 
not without a clearly-marked-as-dangerous user choice.

> This is a great opportunity for a small exercise in empathy, utilizing
> that little long-neglected mirror neuron. Thousands of USB sticks
> inexplicably go dead in people's familiar hubs on keyboards and desks;
> Linux kernel coders dream sweet dreams of not violating USB power rules.
> I appreciate Andrew's support for a real-worldly solution.

Keep in mind that Windows will not permit the USB device to work in such 
configurations either. Windows always did the right thing here. Linux 
did not do the right thing before, and now it does.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

