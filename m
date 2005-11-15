Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbVKOPrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbVKOPrd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 10:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbVKOPrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 10:47:32 -0500
Received: from znsun1.ifh.de ([141.34.1.16]:64151 "EHLO znsun1.ifh.de")
	by vger.kernel.org with ESMTP id S1751008AbVKOPrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 10:47:32 -0500
Date: Tue, 15 Nov 2005 16:46:47 +0100 (CET)
From: Patrick Boettcher <patrick.boettcher@desy.de>
X-X-Sender: pboettch@pub3.ifh.de
To: Johannes Stezenbach <js@linuxtv.org>
Cc: Chris Rankin <rankincj@yahoo.com>, linux-dvb-maintainer@linuxtv.org,
       David Brigada <brigad@rpi.edu>, linux-kernel@vger.kernel.org
Subject: Re: [linux-dvb-maintainer] Re: [OOPS] Linux 2.6.14.2 and DVB USB
In-Reply-To: <20051115152823.GA4079@linuxtv.org>
Message-ID: <Pine.LNX.4.64.0511151633490.29360@pub3.ifh.de>
References: <20051114235102.64514.qmail@web52912.mail.yahoo.com>    
 <Pine.LNX.4.64.0511150939010.18517@pub3.ifh.de> <20051115152823.GA4079@linuxtv.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Report: ALL_TRUSTED,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 15 Nov 2005, Johannes Stezenbach wrote:
>> Unfortunately the dvb-core is currently not able to handle hotplugging
>> while a dvb application is accessing a dvb-dev-node. This applies
>> for every dvb-device, not only for dvb-usb devices, but no one ever tried
>> to unplug a DVB PCI card while using it, yet.
>>
>> Before unplugging a device, you can check if the module is removable to
>> make sure that really no application is currently using it. (You will get
>> "module in use" then).
>>
>> We already thought about that problem and we think that dvbdev.c is the
>> correct place to start implementing that, but I don't have enough
>> knowledge (and time) to do that now, sorry.
>
> I thought someone sent a patch which fixes it for the cinergyT2
> recently? Wouldn't the same approach work for dvb-usb?
> (But I haven't had a chance to test the cinergyT2 patch yet.)

Once Deti Fliegl created that patch I had a look at it to figure out if it 
can easily be adapted to dvb-usb. This is was my answer:

http://www.linuxtv.org/pipermail/linux-dvb/2005-October/005333.html

After that mail I had some private mails with Deti, but he is currently 
too busy to adapt his mechanism to dvbdev.c and I'm too stupid.

The cinergy-driver handles the frontend in a different way and that's 
why it is possible to fix it like Deti does it.

If I could fix it in in dvb-usb, then it would be again only fixed for a 
small amount of devices. For DVB-PCMCIA-cards using the default 
fe-architecture will also cause Oopses like that, when unplugging while 
having the device in use. That's why, IMHO, the dvb-core should be made 
hotplug-safe, not a single driver. Even worse: it's not just the 
frontend-device-nodes, but also the demux-nodes (and I think the other 
onces too).

best regards,
Patrick.

--
   Mail: patrick.boettcher@desy.de
   WWW:  http://www.wi-bw.tfh-wildau.de/~pboettch/
