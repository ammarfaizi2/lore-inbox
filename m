Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266127AbUI0Fra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266127AbUI0Fra (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 01:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266133AbUI0Fra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 01:47:30 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:55786 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266127AbUI0FrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 01:47:25 -0400
Date: Mon, 27 Sep 2004 14:49:11 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [ACPI] [PATCH] Updated patches for PCI IRQ resource deallocation
 support [2/3]
In-reply-to: <Pine.LNX.4.53.0409251416570.2908@musoma.fsmlabs.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartmann <greg@kroah.com>, Len Brown <len.brown@intel.com>,
       tony.luck@intel.com, acpi-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org
Message-id: <4157A9D7.4090605@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
References: <Pine.LNX.4.53.0409251356110.2914@musoma.fsmlabs.com>
 <Pine.LNX.4.53.0409251401560.2914@musoma.fsmlabs.com>
 <Pine.LNX.4.53.0409251416570.2908@musoma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Sat, 25 Sep 2004, Zwane Mwaikambo wrote:
> 
>> Kenji Kaneshige wrote:
>> 
>> >     - Changed acpi_pci_irq_disable() to leave 'dev->irq' as it
>> >       is. Clearing 'dev->irq' by some magic constant
>> >       (e.g. PCI_UNDEFINED_IRQ) is TBD.
>> 
>> This may not be safe with CONFIG_PCI_MSI, you may want to verify against 
>> that if you already haven't.
>> 

Thank you for commemts.
You are right. If the linux IRQ number is allocated by MSI code,
clearing 'dev->irq' would cause a problem. So we need to consider
clearing 'dev->irq' carefully.

The latest patch doesn't clear 'dev->irq' so far.

>> > +acpi_unregister_gsi (unsigned int irq)
>> > +{
>> > +}
>> > +EXPORT_SYMBOL(acpi_unregister_gsi);
>> 
>> Why not just make these static inlines in header files? Since you're on 
>> this, how about making irq_desc and friends dynamic too?
> 
> Sorry, i broke Cc.
> 

I'm not quite sure what you are saying, but my idea is defining
acpi_unregister_gsi() as a opposite part of acpi_register_gsi().
Acpi_register_gsi() is defined for each arch (i386, ia64), so
acpi_unregister_gsi() is defined for each i386 and ia64 too. 

Thanks,
Kenji Kaneshige

