Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265243AbTLaTFw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 14:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265244AbTLaTFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 14:05:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28391 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265243AbTLaTFv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 14:05:51 -0500
Message-ID: <3FF31DFB.9030907@pobox.com>
Date: Wed, 31 Dec 2003 14:05:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] pci_set_dac helper
References: <3FF2F57A.80801@pobox.com> <20031231185953.GJ6791@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20031231185953.GJ6791@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Wed, Dec 31, 2003 at 11:12:42AM -0500, Jeff Garzik wrote:
> 
>>It seems to me like a lot of drivers wind up getting their 
>>pci_set_dma_mask stuff wrong, occasionally in subtle ways.  So, I 
>>created a "give me 64-bit PCI DMA" helper function.
> 
> 
> I like it, but I think it could be better.  A lot of drivers want
> 64-bit streaming DMA but 32-bit consistent DMA.  So how about this:

I like the direction of your patch:  the driver informs us ahead of time 
what it wants (even though this isn't necessarily true with PCI_DAC_EN, 
which falls back instead of fails).

However, the one big failing of your version is that the driver _must_ 
know if PCI DAC succeeded or not.  Therefore, two pieces of information 
must be returned (error value, DAC flag(s)), which lends itself more to 
leaving my version as-is ;-)


> I note ithat both this and your patch will lead to two errors being
> printed on 64-bit consistent failure; one by tg3 and one by the PCI
> layer; this seems suboptimal.  I suspect you want to do away with the
> error printk in the tg3 driver.

That was intentional in my patch, as it's a warning not an error in my 
pci_set_dac.  In your version I would agree.

	Jeff



