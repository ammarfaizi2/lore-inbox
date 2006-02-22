Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161256AbWBVAJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161256AbWBVAJQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 19:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161257AbWBVAJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 19:09:16 -0500
Received: from mail.dvmed.net ([216.237.124.58]:52910 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161256AbWBVAJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 19:09:15 -0500
Message-ID: <43FBABA4.7020906@pobox.com>
Date: Tue, 21 Feb 2006 19:09:08 -0500
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
References: <43FAB283.8090206@jp.fujitsu.com> <200602212231.55879.ak@suse.de> <43FB8C4F.6070802@pobox.com> <200602212306.24342.ak@suse.de>
In-Reply-To: <200602212306.24342.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tuesday 21 February 2006 22:55, Jeff Garzik wrote:
> 
> 
>>It doesn't matter how easily its added, it is the wrong place to add 
>>such things.
>>
>>This is what the various functions called during pci_driver::probe() do...
> 
> 
> The problem is that at least on the e1000 it only applies to some of the 
> many PCI-IDs it supports. So the original patch had an long ugly switch
> with PCI IDs to check it. I suggested to use driver_data for it then,
> but Kenji-San ended up with this new field.  I actually like the idea
> of the new field because it would allow to add such things very easily
> without adding lots of code.
> 
> it's not an uncommon situation. e.g. consider driver A which supports
> a lot of PCI-IDs but MSI only works on a few of them. How do you
> handle this? Add an ugly switch that will bitrot? Or put all the 
> information into a single place which is the pci_device_id array.

You do what tons of other drivers do, and indicate this via driver_data. 
  An enumerated type in driver_data can be used to uniquely identify any 
device or set of devices.

No need to add anything.

	Jeff



