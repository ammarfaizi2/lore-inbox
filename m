Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268484AbUIXGez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268484AbUIXGez (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 02:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268505AbUIXGey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 02:34:54 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:60874 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S268484AbUIXG1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 02:27:32 -0400
Date: Fri, 24 Sep 2004 15:29:14 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [ACPI] [PATCH] PCI IRQ resource deallocation support [2/3]
In-reply-to: <20040924.145229.108814142.t-kochi@bq.jp.nec.com>
To: Takayoshi Kochi <t-kochi@bq.jp.nec.com>
Cc: bjorn.helgaas@hp.com, acpi-devel@lists.sourceforge.net,
       kaneshige.kenji@soft.fujitsu.com, akpm@osdl.org, greg@kroah.com,
       len.brown@intel.com, tony.luck@intel.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Message-id: <4153BEBA.5030202@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
References: <414FEBDB.2050201@soft.fujitsu.com>
 <200409210857.59457.bjorn.helgaas@hp.com> <4150D458.3050400@jp.fujitsu.com>
 <20040924.145229.108814142.t-kochi@bq.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takayoshi,

Thank you for feedback.

Takayoshi Kochi wrote:
>> > Why do we need to fiddle with dev->irq?  I think it should
>> > just be undefined after acpi_pci_irq_disable().
>> 
>> I had been considering what the "undefined dev->irq" was.
>> In fact, I had other ideas that was clearing it by zero or
>> -1 (0xffffffff). But I didn't know if we can use these values
>> as a undefined IRQ number. So I'm clearing it by the value
>> which was assigned by PCI core code (pci_read_irq()) before
>> acpi_pci_irq_enable() was called. 
> 
> I think it has little sense in restoring value from the configuration
> space to dev->irq or clearing it.
> 
> If we do preventive programming, it may be worth
> trying to define some magic constant (e.g. PCI_UNDEFINED_IRQ) and
> panic/BUG when the irq is being enabled.
> Otherwise, leaving dev->irq as it is would be ok.

Hmm, I think you are right.
I'll change my patch to leave dev->irq as it is. And then I'll
investigate about defining PCI_UNDEFINED_IRQ.

In fact, I posted updated patches a little before. I'll re-post
it with your feedback :-)

Thanks,
Kenji Kaneshige

