Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWFBAHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWFBAHH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 20:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWFBAHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 20:07:06 -0400
Received: from weber.sscnet.ucla.edu ([128.97.42.3]:21702 "EHLO
	weber.sscnet.ucla.edu") by vger.kernel.org with ESMTP
	id S1751045AbWFBAHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 20:07:05 -0400
Message-ID: <447F8057.4000109@cogweb.net>
Date: Thu, 01 Jun 2006 17:03:35 -0700
From: David Liontooth <liontooth@cogweb.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060517)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: USB devices fail unnecessarily on unpowered
 hubs
References: <20060601030140.172239b0.akpm@osdl.org> <Pine.LNX.4.44L0.0606011050330.6784-100000@iolanthe.rowland.org> <20060601164327.GB29176@kroah.com>
In-Reply-To: <20060601164327.GB29176@kroah.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Jun 01, 2006 at 10:58:43AM -0400, Alan Stern wrote:
>   
>> On Thu, 1 Jun 2006, Andrew Morton wrote:
>>
>>     
>>> On Thu, 01 Jun 2006 02:18:20 -0700
>>> David Liontooth <liontooth@cogweb.net> wrote:
>>>
>>>       
>>>> Starting with 2.6.16, some USB devices fail unnecessarily on unpowered
>>>> hubs. Alan Stern explains,
>>>>
>>>> "The idea is that the kernel now keeps track of USB power budgets.  When a 
>>>> bus-powered device requires more current than its upstream hub is capable 
>>>> of providing, the kernel will not configure it.
>>>>
>>>> Computers' USB ports are capable of providing a full 500 mA, so devices
>>>> plugged directly into the computer will work okay.  However unpowered hubs
>>>> can provide only 100 mA to each port.  Some devices require (or claim they
>>>> require) more current than that.  As a result, they don't get configured
>>>> when plugged into an unpowered hub."
>>>>
>>>> http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg43480.html
>>>>
>>>> This is generating a lot of grief and appears to be unnecessarily
>>>> strict. Common USB sticks with a MaxPower value just above 100mA, for
>>>> instance, typically work fine on unpowered hubs supplying 100mA.
>>>>
>>>> Is a more user-friendly solution possible? Could the shortfall
>>>> information be passed to udev, which would allow rules to be written per
>>>> device?
>>>>         
>> I'm not sure whether we create a udev event when a new USB device is
>> connected.
>>     
> Yes we do.  It's of the class "usb_device" and you can write a single
> udev rule to override the power test if you really want to.
>
> Of course I don't recommend someone doing this, as it is violating the
> USB power rules, and it is a good thing that we are finally testing for
> them.
>   
It's clearly a good thing to be testing for this. As Alan points out,
100mA is the maximum permitted pre-configuration draw, so what a device
draws when plugged in is not informative.

However, obeying the USB power rules is not an end in itself -- the
relevant question is the minimum power the device requires to operate
correctly and without damage.

The MaxPower value does not appear to be a reliable index of this. My
USB stick has a MaxPower value of 178mA and works flawlessly off an
unpowered hub. Unfortunately devices don't seem to tell us what their
minimum power requirements are, so we need more flexibility in writing
rules for this.

udev could surely pick up on the MaxPower value and tolerate up to a
100% underrun on USB flash drives. That would likely still 90% of the
pain right there, maybe all of it.

What are the reasons not to do this? What happens if a USB stick is
underpowered to one unit? Nothing? Slower transmission? Data loss? Flash
memory destruction? If it's just speed, it's a price well worth paying.

This is a great opportunity for a small exercise in empathy, utilizing
that little long-neglected mirror neuron. Thousands of USB sticks
inexplicably go dead in people's familiar hubs on keyboards and desks;
Linux kernel coders dream sweet dreams of not violating USB power rules.
I appreciate Andrew's support for a real-worldly solution.

Dave






