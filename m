Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263288AbTECJxK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 05:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263289AbTECJxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 05:53:10 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:8172 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S263288AbTECJxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 05:53:08 -0400
Message-ID: <3EB39463.2080307@blue-labs.org>
Date: Sat, 03 May 2003 06:05:23 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030429
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       apcupsd-devel@apcupsd.org
Subject: Re: APC USB ups, Back-UPS ES series, 2.5.68
References: <3EB331B5.4080306@blue-labs.org> <20030503063632.GA2769@kroah.com>
In-Reply-To: <20030503063632.GA2769@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yep...a simple fact that I overlooked.  This is a devfs created file so 
the kernel is at fault.  Looks like it's off by 128.

David

Greg KH wrote:

>On Fri, May 02, 2003 at 11:04:21PM -0400, David Ford wrote:
>  
>
>>(Please cc: me on reply)
>>
>>I'm wanting to get this new toy up and running.  I've installed apcupsd, 
>>but it doesn't want to work well with my kernel (2.5.68) or somewhat.
>>
>>When apcupsd tries to open the hiddev, open() gets an ENODEV.  Is 
>>apcupsd doing something wrong or is 2.5.68 doing something wrong?
>>
>>~# dmesg
>>hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
>>hub 1-0:0: new USB device on port 1, assigned address 4
>>usb 1-1: new device strings: Mfr=3, Product=1, SerialNumber=2
>>usb 1-1: Product: Back-UPS ES 350 FW:800.e3.D USB FW:e3
>>usb 1-1: Manufacturer: APC
>>usb 1-1: SerialNumber: AB0238241677 
>>usb 1-1: usb_new_device - registering interface 1-1:0
>>hid 1-1:0: usb_device_probe
>>hid 1-1:0: usb_device_probe - got id
>>drivers/usb/core/file.c: asking for 1 minors, starting at 96
>>drivers/usb/core/file.c: found a minor chunk free, starting at 96
>>hiddev96: USB HID v1.10 Device [APC Back-UPS ES 350 FW:800.e3.D USB 
>>FW:e3] on usb-00:07.2-1
>>
>>
>>~# ls -l /dev/usb/hid
>>total 0
>>crw-r--r--    1 root     root     180, 192 Dec 31  1969 hiddev96
>>crw-r--r--    1 root     root     180, 193 Dec 31  1969 hiddev97
>>    
>>
>
>Huh?  /dev/usb/hiddev0 is major 180, minor 96.  So the kernel asked for
>minor 96 and it got it.  Why are you trying to connect to minor number
>192?
>
>For a list of the USB minor numbers see:
>	http://www.linux-usb.org/usb.devices.txt
>
>It's a bit different from Documentation/devices.txt, I need to send the
>updates to lanana.org someday...
>
>thanks,
>
>greg k-h
>


