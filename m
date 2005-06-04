Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVFDAeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVFDAeR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 20:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVFDAeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 20:34:16 -0400
Received: from mail.dvmed.net ([216.237.124.58]:48320 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261195AbVFDAeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 20:34:12 -0400
Message-ID: <42A0F6F9.8010700@pobox.com>
Date: Fri, 03 Jun 2005 20:34:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Greg KH <gregkh@suse.de>, tom.l.nguyen@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       roland@topspin.com, davem@davemloft.net,
       Michael Chan <mchan@broadcom.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pci_enable_msi() for everyone?
References: <20050603224551.GA10014@kroah.com>  <42A0E4B4.3050309@pobox.com>	 <1117843264.31082.204.camel@gaston>  <42A0F10D.8020308@pobox.com> <1117844169.31082.210.camel@gaston>
In-Reply-To: <1117844169.31082.210.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>>Honestly I can think of situations where one driver would want a bit per 
>>BAR, and many others would just need a single MMIO bit.  Don't forget 
>>legacy decoding too:  with -only- a bit per BAR, the driver cannot tell 
>>the PCI layer that disabling IO means disabling a legacy ISA region 
>>that's not listed in the PCI BARs.
> 
> 
> VGA is too much of a special case here. I'm currently working on a VGA
> arbitrer but it will need a separate API (along with a userland
> interface). Maybe the kernel side of this API could be folded in that
> pci_enable() thing though, I'll have to give it a though...

I was in fact thinking of IDE not VGA :)

Let's keep it simple.

Just need to make sure that, if we use an enable-by-PCI-BAR bitmap, it 
is still possible to let the driver make decisions about enable/disable 
of the IO and MMIO bits.  You could have a PCI BAR bitmap and then two 
additional "don't touch <xxx>" bits, for example.

	Jeff



