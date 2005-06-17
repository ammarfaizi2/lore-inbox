Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVFQRFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVFQRFW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 13:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVFQRFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 13:05:22 -0400
Received: from osten.wh.uni-dortmund.de ([129.217.129.130]:32719 "EHLO
	osten.wh.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262021AbVFQRFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 13:05:09 -0400
Message-ID: <42B302C2.9030009@web.de>
Date: Fri, 17 Jun 2005 19:05:06 +0200
From: Alexander Fieroch <fieroch@web.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: de-de, en-us, en
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [2.6.12rc4] PROBLEM: "drive appears confused" and "irq 18:  
   nobody cared!"
References: <d6gf8j$jnb$1@sea.gmane.org>	 <20050527171613.5f949683.akpm@osdl.org> <429A2397.6090609@web.de>	 <58cb370e05061401041a67cfa7@mail.gmail.com> <42B091EE.4020802@web.de>	 <20050615143039.24132251.akpm@osdl.org>	 <1118960606.24646.58.camel@localhost.localdomain> <42B2AACC.7070908@web.de> <1119011887.24646.84.camel@localhost.localdomain>
In-Reply-To: <1119011887.24646.84.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
>>Jun 17 12:07:49 orclex kernel: irq 18: nobody cared (try booting with the "irqpoll" option.
> 
> Something failed to clear IRQ 18, that typically means there are IRQ
> routing problems rather than IDE ones and would explain your traces.
> 
> Try booting with acpi=off and see what trace you get then.

acpi=off makes linux hang and not continuing booting. Hm, syslog does
not contain the trace until that crash but the last lines before the
hanging are:

ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found


I've tried booting the kernel with parameter irqpoll as you have
suggested but it leads to a kernel panic.
The last line was:

kernel panic - not syncing: Aiee, killing interrupt handler!

It's not saved in syslog too, so is there any way to get the trace to a
file?


There is something other I've tested - perhaps it's usefull for you.
I've turned off the power options in my ami bios and linux hangs for a
long time while booting.
I got messages like:

...
ide-cd: cmd 0x5a timed out
hdb: lost interrupt
hdb: lost interrupt
hdb: lost interrupt
ide-cd: cmd 0x5a timed out
hdb: lost interrupt
hdb: irq timeout: status=0xd0 { Busy }
hdb: lost interrupt
hdb: lost interrupt
...

After 30minutes I did a restart and set the bios power options back to:

Repost Video on S3 Resume [yes]
ACPI 2.0 Support          [yes]
ACPI APIC support         [enabled]


Regards,
Alexander Fieroch
