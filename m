Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265854AbUBBU4h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266102AbUBBUyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:54:45 -0500
Received: from pop.gmx.de ([213.165.64.20]:50867 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266094AbUBBUvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 15:51:41 -0500
X-Authenticated: #4512188
Message-ID: <401EB859.9090200@gmx.de>
Date: Mon, 02 Feb 2004 21:51:37 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: oops with 2.6.1-rc1 and rc-3
References: <BF1FE1855350A0479097B3A0D2A80EE0020AEB18@hdsmsx402.hd.intel.com>	 <1075664953.2389.12.camel@dhcppc4>  <401E0E2C.8020708@gmx.de> <1075748372.2398.117.camel@dhcppc4>
In-Reply-To: <1075748372.2398.117.camel@dhcppc4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
>>>handlers:
>>>[<c02a6b50>] (ide_intr+0x0/0x190)
>>>[<c03248c0>] (snd_intel8x0_interrupt+0x0/0x210)
>>>Disabling IRQ #11
>>>irq 11: nobody cared!
> 
> 
> dmesg -s40000 output (or serial console log if dmesg unavailable)
> /proc/interrupts

This is starting to get stupid: I tried recreating the oops with rc2 and 
rc2-mm2, but this time they started up normal. Currently I am even using 
a mm2 based kernel. But 2.6.2-rc3 still oopses. The problem is it 
happens at kernel init time (libata doing its init) and thus I cannot do 
a dmesg. I don't have a serial console, neither. But I wrote down the 
functions called, if that is of help. I tried the kmsgdump patch to 
write the dmesg down to floppy, but either it didn't work or I am too 
stupid. Well, tell me whether it still helps making a bug report. Is 
there a way to make kernel more verbose? I mean all the acpi messages 
only appear in the log and not on screen. Then i could at least rite 
things down by hand, though it is not very inviting...

SO pleae specify which infos of the oopsing kernel you need 
specifically, minimisind my time in writing stuff down.


If you think you can work with above (lack of) informations, I will open 
a bug report and give you all the acpi and dmi dumps, etc.. you wanted.

  Here is the interrupt list, btw.

light@tachyon light $ cat /proc/interrupts
            CPU0
   0:     448685          XT-PIC  timer
   1:       1518          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   5:      33618          XT-PIC  Skystar2, ohci_hcd, nvidia
   8:          3          XT-PIC  rtc
   9:          0          XT-PIC  acpi
  10:       1322          XT-PIC  ohci_hcd, eth0
  11:      13086          XT-PIC  libata, NVidia nForce2, ehci_hcd
  12:      23562          XT-PIC  i8042
  14:         21          XT-PIC  ide0
  15:         26          XT-PIC  ide1
NMI:          0
ERR:          2

Prakash
