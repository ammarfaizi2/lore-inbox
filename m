Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbVLNCH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbVLNCH5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 21:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbVLNCH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 21:07:57 -0500
Received: from web32409.mail.mud.yahoo.com ([68.142.207.202]:42139 "HELO
	web32409.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030357AbVLNCH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 21:07:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Ow2MFSLNHj/qne9fXTg5NPPe+1VkYCZwSx7y7lvlb4zoqDimcr0M3gL/M13EMnK95/j/XBqcri0kPiQkvSv1nI3/Mc05+c9SuEutR6/ZtXbmvqHo0sHlyrxcW/MRrvMEoWegJKIuf4P8c6SKP1ORvoUxRiG2BXNbvCr0/Sbx4u8=  ;
Message-ID: <20051214020754.66330.qmail@web32409.mail.mud.yahoo.com>
Date: Tue, 13 Dec 2005 18:07:54 -0800 (PST)
From: Anil kumar <anils_r@yahoo.com>
Subject: driver_attach question
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Should driver_attach( ) return an error value?

I have disabled a device in the system bios, The
driver fails to report -ENODEV.
This is for 2.6.11.1 kernel
When I dig through the PCI subsystem and driver_attach
code, I find that :

pci_register_driver is returing zero(no error) even
when the device is not present in the system. 
But when I check driver_attach( ), I get -ENODEV for
driver_probe_device(). which is correct. But
driver_attach( ) does not return this error value. 
driver attach( ) is called in bus_add_driver( ) and
bus_add_driver just returns error=0
Hence I get error=0 in pci_register_driver.

Am I missing something in the flow?

int pci_register_driver( )
{
.....
.....
error = driver_register(&drv->driver);
return error;
}

int driver_register(struct device_driver * drv)
{
.....
return bus_add_driver(drv);
}

int bus_add_driver(struct device_driver * drv)
{
.....
driver_attach(drv);
...
return error;
}

void driver_attach(struct device_driver * drv)
{
....
error = driver_probe_device(drv, dev);
....
}

with regards,
  Anil




__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
