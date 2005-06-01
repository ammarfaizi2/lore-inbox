Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVFATTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVFATTY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 15:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVFATQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 15:16:44 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:49833 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S261225AbVFATPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 15:15:39 -0400
Message-ID: <429E0965.1090809@vc.cvut.cz>
Date: Wed, 01 Jun 2005 21:15:49 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rene Herman <rene.herman@keyaccess.nl>
CC: Mark Lord <lkml@rtr.ca>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: External USB2 HDD affects speed hda
References: <429BA001.2030405@keyaccess.nl> <429DA0A9.6010808@rtr.ca> <429DFEBF.8090908@keyaccess.nl>
In-Reply-To: <429DFEBF.8090908@keyaccess.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:
> Mark Lord wrote:
> 
>> Look at "cat /proc/interrupts" and see if the USB is sharing
>> an IRQ line with ide0.  If so, then the best explanation I can
>> see is that the USB driver must have a *really slow* interrupt
>> handler up to the point where it determines that the interrupt
>> is not for it.
> 
> 
> No, that's not it. Both ide0 (14) and EHCI (3) are on private, unshared 
> IRQs. rmmodding ehci_hcd as per Pavel's sugestion gets me back my speed. 
> Exactly _why_ I've no idea though. I've just added you to the CC on that 
> reply...

Because EHCI hardware continuously watches some memory area to
find whether there are some transfers from host to your USB
devices ready...  You just need better memory bandwidth so all
your devices transfers fit on your bus.  Or maybe EHCI driver
could program hardware to not query transfer descriptors
that often. But it would increase latency for people
who use USB only and do not care about other parts of system.

						Petr Vandrovec

