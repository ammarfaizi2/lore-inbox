Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264099AbTE0U2q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTE0U2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:28:46 -0400
Received: from static213-229-38-018.adsl.inode.at ([213.229.38.18]:38273 "HELO
	home.winischhofer.net") by vger.kernel.org with SMTP
	id S264099AbTE0U2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:28:45 -0400
Message-ID: <3ED3CDA9.5090605@winischhofer.net>
Date: Tue, 27 May 2003 22:42:17 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Davide Libenzi <davidel@xmailserver.org>, Martin Diehl <lists@mdiehl.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sis650 irq router fix for 2.4.x
References: <3ED21CE3.9060400@winischhofer.net>	 <Pine.LNX.4.55.0305261431230.3000@bigblue.dev.mcafeelabs.com>	 <3ED32BA4.4040707@winischhofer.net>	 <Pine.LNX.4.55.0305271000550.2340@bigblue.dev.mcafeelabs.com> <1054053901.18814.0.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> I'm keeping an eye on it. The correct answer appears to be 
> "use ACPI" once it works on SiS

It already does. No problem, except for idiotic OS string checks which 
require using a custom DSDT.

> I'll probably try some of those changes in a later -ac and see what
> happens

I patched the kernels of my 3 650 variants today (using a simpler 
variant than submitted by Davide), and it works well. They are running a 
webcam permanently, one is copying from and to a USB floppy in a loop, 
and I am using a USB mouse on all of them.

The issue is that the 0x6x register hack seems to be required for _all_ 
96x variants. These come with the 740 as well as all 650 versions, and 
probably many of the older chips (645, etc), too.

Unfortunately, I know of no way how to find out about these south 
bridges. They have the same PCI ID like the IRQ controller and ISA 
bridge of the 620, 530, 630 and the old 5595... and partly even the same 
revision number. Typical SiS stuff, lines up exactly with their graphics 
hardware...

Vojtech recommended doing it like the IDE drivers, but - as I said to 
him - it feels a bit inappropriate to poke around in the IDE config 
space for IRQ reasons... But anyone interested should take a look into 
the newest 5513 ide driver (in the bk tree).

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net          *** http://www.winischhofer.net
mailto:twini@xfree86.org

