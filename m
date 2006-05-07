Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWEGF4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWEGF4W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 01:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWEGF4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 01:56:22 -0400
Received: from smtpout.mac.com ([17.250.248.184]:61411 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751176AbWEGF4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 01:56:22 -0400
In-Reply-To: <m33bfm4ud2.fsf@defiant.localdomain>
References: <mj+md-20060504.211425.25445.atrey@ucw.cz> <20060505210614.GB7365@kroah.com> <9e4733910605051415o48fddbafpf0f8b096f971e482@mail.gmail.com> <20060505222738.GA8985@kroah.com> <9e4733910605051705j755ad61dm1c07c66c2c24c525@mail.gmail.com> <21d7e9970605051857l4415a04ai7d1b1f886bb01cee@mail.gmail.com> <9e4733910605052039n7d2debbse0fd07e0d1d059fb@mail.gmail.com> <m3d5er729f.fsf@defiant.localdomain> <9e4733910605060608l57c1a215pa300c326ef1eef4b@mail.gmail.com> <m34q036n46.fsf@defiant.localdomain> <9e4733910605061124u6b1c4b88nd84faa914c72521f@mail.gmail.com> <m33bfm4ud2.fsf@defiant.localdomain>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9E6FFBE8-39F0-4C3D-8D6C-B0EC59AD5D22@mac.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, Ian Romanick <idr@us.ibm.com>,
       Dave Airlie <airlied@linux.ie>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Date: Sun, 7 May 2006 01:56:11 -0400
To: Krzysztof Halasa <khc@pm.waw.pl>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 6, 2006, at 19:16:25, Krzysztof Halasa wrote:
> "Jon Smirl" <jonsmirl@gmail.com> writes:
>>> The card in question _has_ a driver. I, for example, just need a  
>>> way to write EEPROM data to it (vendor/device ID etc). The card  
>>> has to be selected by PCI bus and slot (device) number, not by  
>>> device class and/or IDs, because it can contain garbage and/or  
>>> some generic IDs with generic device class.
>>
>> Hardware like you describe violates the PCI spec
>
> What exactly does it violate?

"device class and/or IDs ... can contain garbage".  That seems to  
violate PCI spec to me.

>> I would probably handle this by writing an unbound device driver  
>> that exposes a sysfs file for bus:slot. When you write the  
>> bus:slot to the file it would then bind to the appropriate  
>> hardware and enable it. The newly bound driver would support the  
>> driver firmware loader interface as a means of getting your data in.
>
> What is also needed is that end users perform this task from time  
> to time. They generally don't want to have to compile the kernel :-)
>
> You know, even now it can be done (entirely in userspace), and only  
> enabling the device seems a bit dangerous.

Jon Smirl gave a great description of exactly how to write such a  
"driver".  I seem to recall that we already have the ability to  
trigger manual PCI binding by bus:slot number; in combination with an  
appropriate "write EEPROM with firmware file" driver that has no  
default list of PCI devices; you could easily manually trigger a bind  
of the device.  On the other hand I would personally never put such a  
device in my system, what if the garbage device IDs happened to match  
a device with poorly-written PCI IDE drivers that panic when they  
bind to a device which does not match their expectations?  In any  
case what you really need for all those cases is a simplistic stub  
driver that provides some sort of in-kernel mutual exclusion.

Cheers,
Kyle Moffett

