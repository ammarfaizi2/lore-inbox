Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVDUUCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVDUUCg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 16:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbVDUUCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 16:02:36 -0400
Received: from hermes.domdv.de ([193.102.202.1]:34577 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261845AbVDUUC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 16:02:28 -0400
Message-ID: <426806D0.9090507@domdv.de>
Date: Thu, 21 Apr 2005 22:02:24 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: rjw@sisk.pl, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3: various swsusp problems
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <4267DC2E.9030102@domdv.de> <20050421185717.GB475@openzaurus.ucw.cz>
In-Reply-To: <20050421185717.GB475@openzaurus.ucw.cz>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>there's some problems with swsusp in 2.6.12-rc3 (x86_64):
> 
> 
> Are they new or were they in -rc2, too?
> 

Fixed the rc2/rc3 IDE Oops myself today that prevented me to test rc2
earlier. It seems the IDE maintainer is currently not very responsive
and I didn't have sufficient spare time to look into this before today :-(

Yes, all problems are already in rc2.

> 
>>1. Is it necessary to print the following message during regular boot?
>>   swsusp: Suspend partition has wrong signature?
>>   It is a bit annoying and I believe it will confuse some swsusp
>>   users.
> 
> 
> Hmm, feel free to provide a patch. (I need something to try git on :-).

I'll have a look over the weekend.

> 
> 
>>2. PCMCIA related hangs during swsusp.
>>   swsusp hangs after freeing memory when either cardmgr is running
>>   or pcmcia cards are *physically* inserted. It is insufficient
>>   to do a 'cardctl eject' the cards must be removed, too, for
>>   swsusp not to hang. I do suspect some problem with the
>>   'pccardd' kernel threads.
> 
> 
> Did it work with any older kernel? Which driver is it? yenta?

2.6.11.2 works ok and, yes, its yenta. Some excerpt from lspci:

00:0b.0 CardBus bridge: Texas Instruments PCI7420 CardBus Controller
00:0b.1 CardBus bridge: Texas Instruments PCI7420 CardBus Controller

> 
> 
>>3. Sometimes during the search for the suspend hang reason the system
>>   went during suspend into a lightshow of:
>>   eth0: Too much work at interrupt!
>>   and some line that ends in:
>>   release_console_sem+0x13d/0x1c0)
>>   The start of the line is not readable as it just flickers by in
>>   the eth0 message limbo. NIC is a built in RTL-8169 Gigabit Ethernet
>>   (rev 10). Oh, no chance for a serial console capture as there's no
>>   built in serial device in this laptop.
> 
> 
> How repeatable is that? Will NIC work okay if you rmmod/insmod its driver?
> 				Pavel

Happens with a probability of about 10% to 20%. I did comment out the
'Too much work...' printk in r8169.c which results in the following
effect: no more message from the network driver (expected), no other
printk related to release_console_sem or anything else unusal, but write
to disk in the case the problem seems to happen is suddenly quite slow
and suspend eventually succeeds.
As the nic driver is built into the kernel insmod/rmmod currently won't
do:-) Nevertheless there doesn't seem to be any strange behaviour after
resume though I didn't really try to use the nic then.
There is, however, definitely no such problem with the nic in 2.6.11.2.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
