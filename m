Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbVJQRWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbVJQRWr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 13:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbVJQRWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 13:22:47 -0400
Received: from mail.dvmed.net ([216.237.124.58]:63630 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751093AbVJQRWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 13:22:46 -0400
Message-ID: <4353DDDF.50000@pobox.com>
Date: Mon, 17 Oct 2005 13:22:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] libata: fix broken Kconfig setup
References: <20051017044606.GA1266@havoc.gtf.org> <Pine.LNX.4.64.0510170754500.23590@g5.osdl.org> <4353C42A.3000005@pobox.com> <Pine.LNX.4.64.0510170848180.23590@g5.osdl.org> <4353CF7E.1090404@pobox.com> <Pine.LNX.4.64.0510171008120.3369@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510171008120.3369@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 17 Oct 2005, Jeff Garzik wrote:
> 
>>If IDE is compiled in, IDE SATA option is not enabled, and ata_piix or ahci
>>are used.
> 
> 
> How about this diff instead?

Nope, it elides critical logic.

1) The quirk should not be enabled if IDE driver is a module.  No reason 
to perform the nasty hack at all, as the user controls module load order.

2) The quirk should not be enabled if IDE driver is not built at all. 
Standard resource reservation code works as expected here.

3) The quirk should not be enabled if CONFIG_BLK_DEV_IDE_SATA is 
enabled, which indicates that the IDE driver gets preference for the 
Intel SATA hardware in question.


> It's really quite clean and understandable, and it makes it very clear 
> what's going on from a configuration standpoint, imnsho. And it does the 
> right thing when AHCI/PIIX is compiled as a SATA module (well, as right as 
> this approach ever can).

My patch works fine when ahci/piix is compiled as a module.  That's the 
configuration I personally tested.


> Of course, somebody should check that it really is just the AHCI and PIIX 
> drivers that want the quirk,

It is.  I wrote 100% of the code, and further, the quirk specifically 
enumerates which PCI IDs are affected, making it easy to verify.

	Jeff


