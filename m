Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271311AbTG2HzU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 03:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271312AbTG2HzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 03:55:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:40374 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271311AbTG2HzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 03:55:15 -0400
Date: Tue, 29 Jul 2003 00:54:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: "S. Anderson" <sa@xmission.com>
Cc: sa@xmission.com, pavel@xal.co.uk, linux-kernel@vger.kernel.org,
       adaplas@pol.net
Subject: Re: OOPS 2.6.0-test2, modprobe i810fb
Message-Id: <20030729005456.495c89c4.akpm@osdl.org>
In-Reply-To: <20030729012417.A18449@xmission.xmission.com>
References: <20030728171806.GA1860@xal.co.uk>
	<20030728201954.A16103@xmission.xmission.com>
	<20030728202600.18338fa9.akpm@osdl.org>
	<20030728231812.A20738@xmission.xmission.com>
	<20030728225914.4f299586.akpm@osdl.org>
	<20030729012417.A18449@xmission.xmission.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"S. Anderson" <sa@xmission.com> wrote:
>
> Jul 29 00:33:48 localhost kernel: pci_bus_match: bus=0, devfn=232 8086 2482
>  Jul 29 00:33:48 localhost kernel:  ^ matching? ^ (i810fb)  ((( &ids->vendor = d094ee7c )))
>  Jul 29 00:33:48 localhost kernel: pci_match_device: &ids->vendor = d094ee7c
>  [..snip..]
> 
>  then when i insert my card again this is when the oops occurs:
> 
>  Jul 29 00:40:12 localhost kernel:  (pci_bus_add_devices) bus 3 devfn 0  1260 3890
>  Jul 29 00:40:12 localhost kernel: pci_bus_match: bus=3, devfn=0 1260 3890
>  Jul 29 00:40:12 localhost kernel:  ^ matching? ^ (serial)  ((( &ids->vendor = c0397314 )))
>  Jul 29 00:40:12 localhost kernel: pci_match_device: &ids->vendor = c0397314
>  Jul 29 00:40:12 localhost kernel: pci_bus_match: bus=3, devfn=0 1260 3890
>  Jul 29 00:40:12 localhost kernel:  ^ matching? ^ (eepro100)  ((( &ids->vendor = c0398a60 )))
>  Jul 29 00:40:12 localhost kernel: pci_match_device: &ids->vendor = c0398a60
>  Jul 29 00:40:12 localhost kernel: pci_bus_match: bus=3, devfn=0 1260 3890
>  Jul 29 00:40:12 localhost kernel:  ^ matching? ^ (PCI IDE)  ((( &ids->vendor = c039a630 )))
>  Jul 29 00:40:12 localhost kernel: pci_match_device: &ids->vendor = c039a630
>  Jul 29 00:40:12 localhost kernel: pci_bus_match: bus=3, devfn=0 1260 3890
>  Jul 29 00:40:12 localhost kernel:  ^ matching? ^ (yenta_cardbus)  ((( &ids->vendor = c039df98 )))
>  Jul 29 00:40:12 localhost kernel: pci_match_device: &ids->vendor = c039df98
>  Jul 29 00:40:12 localhost pci.agent: ... no modules for PCI slot 0000:03:00.0
>  Jul 29 00:40:12 localhost kernel: pci_bus_match: bus=3, devfn=0 1260 3890
>  Jul 29 00:40:12 localhost kernel:  ^ matching? ^ (i810fb)  ((( &ids->vendor = d094ee7c )))
>  Jul 29 00:40:12 localhost kernel: pci_match_device: &ids->vendor = d094ee7c
>  Jul 29 00:40:12 localhost kernel: Unable to handle kernel paging request at virtual address d094ee7c

wtf?  So the memory at d094ee7c (which contains i810fb's pci table) became
unmapped from kernel virtual address space as a result of you inserting
your carbus card.

I am impressed.

Jsut as a crazy test, could you delete /sbin/rmmod and see if it still
happens?  Maybe something is removing the module at an embarrassing time or
something.

