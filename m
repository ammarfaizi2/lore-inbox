Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbVJJAn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbVJJAn2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 20:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVJJAn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 20:43:28 -0400
Received: from deliverator6.gatech.edu ([130.207.165.168]:22144 "EHLO
	deliverator6.gatech.edu") by vger.kernel.org with ESMTP
	id S932312AbVJJAn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 20:43:27 -0400
Message-ID: <4349B920.4090105@mail.gatech.edu>
Date: Sun, 09 Oct 2005 20:43:12 -0400
From: Luke Albers <gtg940r@mail.gatech.edu>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: USB-> bluetooth adapter problem
References: <43499A44.2070803@mail.gatech.edu> <1128898123.19569.28.camel@blade>
In-Reply-To: <1128898123.19569.28.camel@blade>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel Holtmann wrote:

>Hi Luke,
>
>  
>
>>I have a 3com USB bluetooth adapter, that worked for  me at one time, 
>>that I can't get working anymore.
>>
>>The model is 3CREB96B
>>
>>Sometimes it isnt even noticed when I plug it in, but after restarting 
>>hotplug I get this:
>>
>>usb 4-1: new full speed USB device using uhci_hcd and address 2
>>hci_usb_probe: Can't set isoc interface settings
>>usb 4-1: USB disconnect, address 2
>>
>>I don't think that I have removed any options from the kernel that 
>>should cause this, and other USB devices work fine.
>>
>>Can someone please explain this message in more detail (google turns up 
>>very little)?
>>    
>>
>
>try to load the hci_usb driver with "isoc=0". This disables the SCO
>support inside the driver.
>
>Regards
>
>Marcel
>
>
>
>  
>
Thanks for your reply.

Under "Bluetooth subsystem support" I removed support for "SCO links 
support", and then under "Bluetooth device drivers" I removed SCO 
(voice) support.  What is still left:

HCI USB driver
HCI UART driver
      -UART (H4) protocol support
      -BCSP protocol support
HCI BCM203x USB driver
HCI BlueFRITZ! USB driver
HCI VHCI (Virtual HCI device) driver

I realize that some of these shouldnt be in there, but I don't think 
they are causing problems, either.  Anyway, after I removed the items 
mentioned above, and after plugging in the bluetooth adapter, this is 
what I get:

Oct  9 20:24:17 Obliterus usb 4-1: new full speed USB device using 
uhci_hcd and address 2
Oct  9 20:24:18 Obliterus usb 4-1: USB disconnect, address 2
Oct  9 20:24:18 Obliterus Bluetooth: HCI USB driver ver 2.8
Oct  9 20:24:18 Obliterus usbcore: registered new driver hci_usb

So it looks like it immediately disconnects.  It doesn't show up with 
lspci at all either.  I havent tried using the hci_usb as a module and 
setting isoc=0 yet, but am I correct that removing the SCO stuff from 
the kernel took care of the problem, since I no longer get the same message? 


Thanks
