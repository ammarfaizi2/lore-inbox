Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268489AbUH3P3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268489AbUH3P3C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 11:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268490AbUH3P3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 11:29:02 -0400
Received: from zero.aec.at ([193.170.194.10]:15364 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S268489AbUH3P27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 11:28:59 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, mark.langsdorf@amd.com,
       root@chaos.analogic.com
Subject: Re: Celistica with AMD chip-set
References: <2yV1c-29L-7@gated-at.bofh.it> <2yVb1-2ft-57@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 30 Aug 2004 17:28:07 +0200
In-Reply-To: <2yVb1-2ft-57@gated-at.bofh.it> (Alan Cox's message of "Mon, 30
 Aug 2004 16:20:15 +0200")
Message-ID: <m34qmktzlk.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Llu, 2004-08-30 at 15:02, Richard B. Johnson wrote:
>> Hello all,
>> 
>> The Celistica server with the AMD chip-set has very poor
>> PCI performance with Linux (and probably W$ too).
>> 
>> The problem was traced to incorrect bridge configuration
>> in the HyperTransport(tm) chips that connect up pairs
>> of slots.

>    while((pdev = pci_find_device(0x1022, 0x7450, pdev)) != NULL)
>        pci_write_config_dword(pdev,  0x4c, 0x2ec1);


> Can you get Celestica to mail me their PCI subvendor
> id/devid's for the problem configuration or DMI strings
> and then we can do a PCI quirk properly for this.

Celistica is just the contract manufacturer for the AMD
reference design, they're really AMD designs. 0122/7450 
is the AMD 8131 PCI-X bridge.

I doubt it is a good idea to blindly change the configuration of the
bridge like this in the kernel.  It is probably better to wait for an
BIOS update or if you really need an urgent fix to do it from user
space. Any fix should probably read/change bit/write the register, not
blindly overwrite.

-Andi

