Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261579AbSIXGHR>; Tue, 24 Sep 2002 02:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261580AbSIXGHR>; Tue, 24 Sep 2002 02:07:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15371 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261579AbSIXGHQ>;
	Tue, 24 Sep 2002 02:07:16 -0400
Message-ID: <3D90022C.3060300@pobox.com>
Date: Tue, 24 Sep 2002 02:11:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux (Keith Mitchell)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Hien Nguyen <hien@us.ibm.com>, James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: [PATCH-RFC] README 1ST - New problem logging macros (2.5.38)
References: <20020924055657.C968F2C0A6@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> In message <3D8FD0A9.1010906@pobox.com> you write:
> 
>>>@@ -325,7 +326,8 @@
>>> 	while(inb(cmd_ioaddr) && --wait >= 0);
>>> #ifndef final_version
>>> 	if (wait < 0)
>>>-		printk(KERN_ALERT "eepro100: wait_for_cmd_done timeout!\n");
>>>+		problem(LOG_ALERT, "eepro100: wait_for_cmd_done timeout!",
>>>+				detail(ioaddr, "%lx", cmd_ioaddr));
>>
>>bloat, the ioaddr can easily be deduced
> 
> 
> No!  That's *exactly* the problem: you see:
> 	eepro100: wait_for_cmd_done timeout!
> 
> in your logs, now *which* of the 5 eepro100 cards was it?
> 
> wait_for_cmd_done(long cmd_ioaddr) should take a 'struct net_device *'
> and use net_problem, then no details needed.

right, that's a bug, it needs struct net_device * like the standard 
Becker style.


>>>-		printk (KERN_ERR "eepro100: cannot reserve MMIO region\n");
>>>+		pci_problem(LOG_ERR, pdev, "eepro100: cannot reserve MMIO regio
>>
> n");
> 
>>bloat, no advantage over printk
> 
> 
> Now, which of those 5 cards was it again?

Another bug, this driver should be using pci_request_regions() which 
prints that stuff out :)

Does IBM want to submit a patch that cleans up these problems, and makes 
the existing event logging more standard [and is compatible with 
existing 2.4 and 2.5 kernels]?

As an aside, changing all those printks also introduces a _huge_ PITA 
for driver developers porting drivers back and forth between 2.4 and 2.5.

	Jeff



