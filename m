Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWBUVzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWBUVzg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWBUVzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:55:36 -0500
Received: from mail.dvmed.net ([216.237.124.58]:21417 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932358AbWBUVzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:55:35 -0500
Message-ID: <43FB8C4F.6070802@pobox.com>
Date: Tue, 21 Feb 2006 16:55:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Greg KH <greg@kroah.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 3/6] PCI legacy I/O port free driver (take2) - Add device_flags
 into pci_device_id
References: <43FAB283.8090206@jp.fujitsu.com> <200602212159.52106.ak@suse.de> <20060221211004.GA12784@kroah.com> <200602212231.55879.ak@suse.de>
In-Reply-To: <200602212231.55879.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tuesday 21 February 2006 22:10, Greg KH wrote:
> 
>>On Tue, Feb 21, 2006 at 09:59:51PM +0100, Andi Kleen wrote:
>>
>>>On Tuesday 21 February 2006 21:56, Greg KH wrote:
>>>
>>>
>>>>I don't think you can add fields here, after the driver_data field.  It
>>>>might mess up userspace tools a lot, as you are changing a userspace
>>>>api.
>>>
>>>User space should look at the ASCII files (modules.*), not the binary
>>>As long as the code to generate these files still works it should be ok.
>>
>>Does it?  
> 
> 
> I assume Kenji-San tested that.
> 
> 
>>Shouldn't the tools export this information too, if it really 
>>should belong in the pci_id structure?
> 
> 
> No - is driver_data exported? 
>  
> 
>>So, is _every_ pci driver going to have to be modified to support this
>>new field if they are supposed to work on this kind of hardware? 
> 
> 
> There is 100% source compatibility because fields are only added at the
> end of the structure.
> 
> And the drivers will still work on this hardware even without modification.
> 
> It's only an optimization that can be added to selected drivers.

It doesn't matter how easily its added, it is the wrong place to add 
such things.

This is what the various functions called during pci_driver::probe() do...

	Jeff



