Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTLON6d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 08:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTLON6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 08:58:33 -0500
Received: from fmr01.intel.com ([192.55.52.18]:27336 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S263632AbTLON63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 08:58:29 -0500
Message-ID: <3FDDBDFE.5020707@intel.com>
Date: Mon, 15 Dec 2003 15:58:22 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: arjanv@redhat.com
CC: Gabriel Paubert <paubert@iram.es>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Martin Mares <mj@ucw.cz>,
       zaitcev@redhat.com, hch@infradead.org
Subject: Re: PCI Express support for 2.4 kernel
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com>	 <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es>	 <3FDDACA9.1050600@intel.com> <1071494155.5223.3.camel@laptop.fenrus.com>
In-Reply-To: <1071494155.5223.3.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got it.
Should I understand it this way: for system with >=1Gb RAM, I will be 
unable to ioremap 256Mb region?
It looks confusing. On my test system (don't ask details, I am not 
alowed to share this info), I see
video controller with 256Mb BAR. Does it mean this controller will not 
work as well?

There is alternative solution, for each transaction to ioremap/unmap 
corresponded page.
I don't like it, it involves huge overhead.

I thought about remapping only pages that have actual PCI devices behind,
but this is problematic: access to config goes not always through 
pci_exp_read_config_xxx and alike, raw access with bus/dev/fn numbers 
used as well. And in 2.6, correct me if I wrong, raw access using 
bus/dev/fn numbers goes to be the only way. Per-device access replaced 
with per-bus, at least.

I can statically remap only region for existing buses, this will be huge 
save. It is 1MB per bus, this lead to typical 2-3MB instead of 256. To 
be sure I can do this, I need to know that new bus can't be added on run 
time. I don't think it is true, isn't it? Or do we have single point to 
capture hot plug for new bus?

Vladimir.

Arjan van de Ven wrote:

>>I should be missing something here. You have 256M of physical address 
>>space at 0xe0000000 occupied.
>>You can do nothing with it, it is simply present. Then, ioremap maps it 
>>somewhere in high memory.
>>It should not conflict with kernel RAM, for which trivial mapping (+3G) 
>>used.
>>    
>>
>
>the thing is that typically you have a maximum of 168Mb or so of
>ioremap/vmalloc space (they share the same pool). That is, ff your
>system has >= 1Gb of ram, if it has less ran the ioremap/vmalloc space
>is bigger....
>
>  
>

