Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266033AbTGDN3x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 09:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266036AbTGDN3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 09:29:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54424 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266033AbTGDN3w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 09:29:52 -0400
Message-ID: <3F0584A8.8040304@pobox.com>
Date: Fri, 04 Jul 2003 09:44:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>,
       linux-kernel@vger.kernel.org, mj@ucw.cz, alan@redhat.com
Subject: Re: [PATCH] Re: VIA PCI IRQ router bug fix
References: <5F106036E3D97448B673ED7AA8B2B6B36C352C@scl-exch2k.phoenix.com>	 <3F04C1AA.80107@pobox.com> <1057303907.5801.0.camel@laptop.fenrus.com>
In-Reply-To: <1057303907.5801.0.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>> 
>> static int pirq_via_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
>> {
>>-	write_config_nybble(router, 0x55, pirq, irq);
>>+	write_config_nybble(router, 0x55, pirq == 4 ? 5 : pirq, irq);
>> 	return 1;
>> }
> 
> 
> 
> you missed the 
> 
>>+        return (x >> 4);
> 
> in the original patch... so your code is NOT identical. 

Look at read_config_nybble...

	return (nr & 1) ? (x >> 4) : (x & 0xf);

Can you spell out which part is different?  I don't see it.

	Jeff


