Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265864AbTL3X4I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 18:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265866AbTL3X4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 18:56:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58299 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265864AbTL3Xz7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 18:55:59 -0500
Message-ID: <3FF2107B.6020503@pobox.com>
Date: Tue, 30 Dec 2003 18:55:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: Mickael Marchand <marchand@kde.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adaptec 1210sa
References: <200312220305.29955.marchand@kde.org> <3FF20B7A.1090108@pobox.com> <641152704.1072828669@aslan.btc.adaptec.com>
In-Reply-To: <641152704.1072828669@aslan.btc.adaptec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin T. Gibbs wrote:
>>>the idea suggested by Justin was to clear bits 6 and 7 at 0x8a of pci 
>>>configuration space. (which I hope did fine :)
>>>
>>>Thanks Justin :)
>>
>>
>>Does the aar1210 have a different PCI id?  That would make it easy to
>>distinguish, and thus easy to selectively apply your patch only to Adaptec
>>chipsets that need it.
> 
> 
> The change is harmless for controllers using non-adaptec BIOSes.  You'll
> find that on these other controllers, the interrupt masks are already
> clear.  If this wasn't the case, the current Linux driver wouldn't work
> even on stock boards.


The current Linux driver (well, my sata_sil at least) doesn't work for 
several situations, at the moment :)  I need to handle the watchdog 
timer, and also need to mask a bunch of SATA-phy-specific interrupts.

Now that I see in the docs that these bits are present in the stock 
3112, it makes sense to unconditionally ensure they are clear, thus 
completely eliminating the BIOS from the equation.

	Jeff



