Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVFNHoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVFNHoG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 03:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVFNHoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 03:44:06 -0400
Received: from mail.suse.de ([195.135.220.2]:53961 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261311AbVFNHnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 03:43:31 -0400
Message-ID: <42AE8A9E.5040406@suse.de>
Date: Tue, 14 Jun 2005 09:43:26 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-hotplug-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Vojtech Pavlik <vojtech@suse.cz>, Kay Sievers <kay.sievers@vrfy.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Input sysbsystema and hotplug
References: <200506131607.51736.dtor_core@ameritech.net>
In-Reply-To: <200506131607.51736.dtor_core@ameritech.net>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> Hi,
> 
> I am trying to convert input systsem to play nicely with sysfs and I am
> having trouble with hotplug agent. The old hotplug mechanism was using
> "input" as agent/subsystem name, unfortunately I can't simply use "input"
> class because when Greg added class_simple support to input handlers
> (evdev, mousedev, joydev, etc) he used that name. So currently stock
> kernel gets 2 types of hotplug events (from input core and from input
> handlers) with completely different arguments processed by the same
> input agent.
> 
> So I guess my question is: is there anyone who uses hotplug events
> for input interface devices (as in mouseX, eventX) as opposed to
> parent input devices (inputX). If not then I could rename Greg's class
> to "input_dev" and my new class to "input" and that will be compatible
> with older installations. 
> 
> Also, in the long run I would probably want to see something like this:
> 
> /sys/class/input---input0
> 		 |
> 		 |-input1
> 		 |
> 		 |-input2
> 		 |
> 		 |-mouse---mouse0
> 		 |	 |
> 		 |	 |-mouse1
> 		 |	 |
> 		 |	 --mice
> 		 |
> 		 |-event---event0
> 			 |
> 			 |-event1
> 			 |
> 			 |-event2
> 
> where inputX are class devices, mouse and event are subclasses of input
> class and mouseX and eventX are again class devices.
> 
> Objections, suggestions, etc? 
> 	 
Hmm. I don't like it very much as it mixes two different types of
devices (class devices and subclasses) into one directory.

I think it's cleaner to have two distinct class device types
(one for input_dev and one for input).

subclasses for the input class devices are a neat idea; but I fear the
hotplug event name will change for each subclass device ('input' will
become eg 'mouse'), so we again have to change all hotplug handlers.
And I don't see an easy solution for that ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
