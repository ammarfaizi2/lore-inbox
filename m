Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbRBGDzq>; Tue, 6 Feb 2001 22:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129028AbRBGDzh>; Tue, 6 Feb 2001 22:55:37 -0500
Received: from Mail.ubishops.ca ([192.197.190.5]:40203 "EHLO Mail.ubishops.ca")
	by vger.kernel.org with ESMTP id <S129026AbRBGDzY>;
	Tue, 6 Feb 2001 22:55:24 -0500
Message-ID: <3A80C703.84099624@yahoo.co.uk>
Date: Tue, 06 Feb 2001 22:54:43 -0500
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Bug: 2.4.0 w/ PCMCIA on ThinkPad: KERNEL: 
 assertion(dev->ip_ptr==NULL)failed at 
 dev.c(2422):netdev_finish_unregister
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a bit more information about this bug now.
The message "assertion(yadda) failed ..." occurs only
if the eth0 interface has been configured using pump
or dhclient.  If the card isn't connected to the network
the message never occurs.  If eth0 is merely brought up
and down using ifconfig the message doesn't occur.  Only
if pump or dhclient has configured eth0 does the message
occur.  Sometimes it occurs on "ifdown eth0", sometimes
on "cardctl eject" and sometimes during the shutdown
sequence.

Thomas

> Dear l-k. 
> 
> I'm still having this problem with kernel 2.4.0: 
> 
> Conditions: 
> Linux 2.4.0 compiled on an IBM ThinkPad 600 51U (Pentium II) 
> laptop with PCMCIA support. Same behavior with integral kernel 
> PCMCIA, modular kernel PCMCIA and modular Hinds PCMCIA. System 
> is Progeny Debian beta II. 
> 
> I have a Xircom modem/ethernet card which works correctly using 
> the serial_cs, xirc2ps_cs, ds, i82365 and pcmcia_core modules; 
> however when I try to "cardctl eject" or "reboot" I get first, 
>    "KERNEL: assertion(dev->ip_ptr==NULL)failed at 
>     dev.c(2422):netdev_finish_unregister" 
> (not exact since I had to copy it down on paper ... doesn't 
> show up in the logs) then a perpetual series of: 
>    "unregister_netdevice: waiting for eth0 to become free. 
>     Usage count = -1" 
> messages every five seconds or so. "ps -A" reveals that 
> modprobe is running; it can't be killed even with "kill -9". 
> The "ifconfig" command locks up. Shutdown won't complete 
> so I end up having to use SysRq-S-U-B to reboot. 
> 
> This problem only occurs if the Xircom card is connected to 
> the Ethernet (in which case it is configured using DHCP). 
> If the card is left unconnected to the network, the problem 
> does not occur---the card can be ejected. 
> 
> Thomas Hood 
> Please cc: your replies to me at jdthood_AT_yahoo.co.uk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
