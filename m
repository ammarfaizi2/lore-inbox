Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269792AbRHDEkQ>; Sat, 4 Aug 2001 00:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269793AbRHDEkH>; Sat, 4 Aug 2001 00:40:07 -0400
Received: from 35.roland.net ([65.112.177.35]:54286 "EHLO earth.roland.net")
	by vger.kernel.org with ESMTP id <S269792AbRHDEj6>;
	Sat, 4 Aug 2001 00:39:58 -0400
Message-ID: <3B6B7C88.3010803@roland.net>
Date: Fri, 03 Aug 2001 23:39:36 -0500
From: Jim Roland <jroland@roland.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; rv:0.9.1) Gecko/20010622
X-Accept-Language: en-us
MIME-Version: 1.0
To: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
CC: Chris Wedgwood <cw@f00f.org>, Mark Atwood <mra@pobox.com>,
        linux-kernel@vger.kernel.org
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <m33d78de7d.fsf@flash.localdomain> 	<20010804132159.F18108@weta.f00f.org> <996888738.24442.1.camel@tduffy-lnx.afara.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's a little simpler now.

Under 2.2 and 2.4, I have gotten away with doing the following (assuming 
the module does not require a port address or irq):
alias eth0 modulename
alias eth1 modulename

This assumes the kernel sees both cards (look in your kernel ring log, 
typically /var/log/dmesg).  If the entries are both there for eth0 and 
eth1 and irq and port addresses are correct, you're ready to go.  I have 
had no problems with DLink DE220s for example (NE2000 clones).

If it does not see the 2nd card (eth1), then go for something like 
"ether=0,0,eth1" in at the boot prompt (use the append option for LILO 
to make it permanent if you're using LILO).  If that does not work, then 
provide "ether=11,0x300,eth1" (example of IRQ11, IO address 300 hex). 
 The man page on bootparam will explain a little further.

The above was sometimes necessary for ISA, but the PCI world should 
require less intervention.



Thomas Duffy wrote:

>On 04 Aug 2001 13:21:59 +1200, Chris Wedgwood wrote:
>
>>the kernel calls modprobe asking for the network device 'eth0',
>>modprobe uses the configuration file to map this to a module
>>
>
>so, what happens when you have two eth cards that use the same module?
>in the isa land, the order you pass the io=0x300,0x240 would determine
>which order the eth?'s go to...how about in the pci world?
>
>-tduffy
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


