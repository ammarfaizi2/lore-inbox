Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbWIEOcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbWIEOcN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 10:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbWIEOcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 10:32:13 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:17135 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S965013AbWIEOcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 10:32:11 -0400
Date: Tue, 05 Sep 2006 08:32:27 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 2.6.18-rc5-mm1 unusual IRQ number for VIA device
In-reply-to: <44FCCB7A.8000105@bellsouth.net>
To: Jay Cliburn <jacliburn@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Message-id: <44FD8A7B.1000503@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.zOFUKsGFxa+fu0uGVN6HuRT+Krg@ifi.uio.no>
 <fa.2CAUcMm0GNX2+CNwugoJEUNtwzQ@ifi.uio.no> <44FCA4EC.3060507@shaw.ca>
 <44FCA920.4020706@bellsouth.net> <44FCCB7A.8000105@bellsouth.net>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Cliburn wrote:
> Nothing I've read about MSI so far indicates that an IRQ number greater 
> than 255 is permissible, yet this device gets assigned an IRQ number of 
> 8,410 when MSI is enabled.  Booting 2.6.18-rc5-mm1 with pci=nomsi causes 
> the device to be assigned IRQ 17 instead of 8410.
> 
> The problem with the large IRQ number is made manifest in Fedora's 
> irqbalance program, which is run as an init script.  An array is built 
> in that program that's indexed by IRQ number, with a max of 255.  When 
> the program attempts to index element 8410, it segfaults.
> 
> Are IRQ numbers greater than 255 allowed with MSI?

I assume you're on x86-64 with CONFIG_NR_CPUS set to 255. In that case 
the max IRQ number is 256 + (32 * NR_CPUS) or 8416. The MSI interrupts 
will get assigned from highest IRQ to lowest, so you should expect to 
see such high numbers..

It appears that irqbalance's assumption that IRQ cannot exceed 255 is 
not valid on x86-64 (on i386 it is since NR_IRQS is 224).

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

