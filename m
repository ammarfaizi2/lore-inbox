Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422681AbWIGDUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422681AbWIGDUu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 23:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422683AbWIGDUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 23:20:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4804 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422681AbWIGDUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 23:20:48 -0400
Date: Wed, 6 Sep 2006 20:19:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.18-rc5-mm1: strange /proc/interrupts contents on HPC nx6325
Message-Id: <20060906201953.d96ee183.akpm@osdl.org>
In-Reply-To: <200609062117.31125.rjw@sisk.pl>
References: <200609062117.31125.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sep 2006 21:17:30 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Hi,
> 
> [I'm not quite sure who should be on the Cc list.]

I know ;)

> The contents of /proc/interrupts look strange on the HPC nx6325 I'm currently using
> (2.6.18-rc5-mm1, 64-bit kernel):
> 
>            CPU0       CPU1       
>   0:      18073          0    <NULL>-edge     timer
>   1:        163          0   IO-APIC-edge     i8042
>   8:          0          0   IO-APIC-edge     rtc
>   9:        120          0   IO-APIC-fasteoi  acpi
>  12:        149          0   IO-APIC-edge     i8042
>  14:         24          0   IO-APIC-edge     ide0
>  16:       4796          0   IO-APIC-fasteoi  libata
>  19:         75          0   IO-APIC-fasteoi  ehci_hcd:usb1, ohci_hcd:usb2, ohci_hcd:usb3
>  20:          7          0   IO-APIC-fasteoi  yenta, ohci1394, sdhci:slot0
>  23:        672          0   IO-APIC-fasteoi  eth0
> 4348:        188          0   PCI-MSI-<NULL>  HDA Intel
> NMI:         89         59 
> LOC:      18036      18171 
> ERR:          0

This is due to a gruesome hack (IMO) in the genirq code (handle_irq_name())
which magically "knows" about the various types of IRQ handler, but doesn't
know about the MSI ones.  It should be converted to a field in irq_desc, or
a callback or something.  

I already had a whine about this then forgot about it, but it seems that
code can't be changed by whining at it ;)

