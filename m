Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbVK2GlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbVK2GlF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 01:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbVK2GlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 01:41:05 -0500
Received: from smtpout.mac.com ([17.250.248.47]:35823 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751323AbVK2GlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 01:41:04 -0500
In-Reply-To: <20051129054411.GB11013@kroah.com>
References: <Pine.LNX.4.50.0511231336261.16769-100000@monsoon.he.net> <20051128204950.GC17740@kroah.com> <37362F2B-D74A-4A40-905B-B25264B6C4AB@mac.com> <20051129054411.GB11013@kroah.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B43BE39F-16A2-4BFE-A6AA-0F4439780F1C@mac.com>
Cc: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] Updates to sysfs_create_subdir()
Date: Tue, 29 Nov 2005 01:41:01 -0500
To: Greg KH <greg@kroah.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 29, 2005, at 00:44, Greg KH wrote:
> On Mon, Nov 28, 2005 at 08:10:36PM -0500, Kyle Moffett wrote:
>> If the kernel gets this, then udev needs to allow attributes with  
>> more generic paths too.  It would be nice if I could use this  
>> [Pulled from the sample udev output halfway down this page: http:// 
>> www.reactivated.net/writing_udev_rules.html#identify-sysfs].
>>
>> BUS="scsi", SYSFS{../../../manufacturer}="Tekom Technologies,  
>> Inc", NAME="my_camera"
>
> Why can't you do this today?  Have you tried it?

Hmm, no, I don't suppose I have.  I guess I was taking the udev docs  
and other similar pages at their word that you couldn't match things  
in multiple subdirs.  *tries*  Interesting; it appears to work, but  
it would be nice if it was documented somewhere; this is _really_  
handy for certain devices with partial or missing udev support.  (I  
can specify the 3rd proprietary tape drive in the changer even if the  
drives themselves don't have any useful SCSI info attached to them.)   
Thanks for pointing this out!

I do have one question, though.  Is there any way to access the  
"DEVICE" or "SUBSYSTEM" values of those parent sysfs nodes?  I can  
see that those are symlinks in sysfs to other sysfs dirs, so there's  
no real way to match them with SYSFS{*}, but I'm hoping that perhaps  
they could be extended to accept a path in {} brackets much as SYSFS 
{} does.  Thanks for the help!  And btw, here are the rules I've  
worked out for my PowerBook (I frequently tinker with the MAC address  
when doing odd networking hackery, so it's not so useful for matching  
purposes):

## The built-in ethernet
SUBSYSTEM="net", SYSFS{device/devspec}="/pci@f4000000/ethernet@f",  
NAME="net_eth"
## The built-in firewire (via eth1394)
SUBSYSTEM="net", SYSFS{device/../devspec}="/pci@f4000000/firewire@e",  
NAME="net_fw"

Cheers,
Kyle Moffett

--
Unix was not designed to stop people from doing stupid things,  
because that would also stop them from doing clever things.
   -- Doug Gwyn


