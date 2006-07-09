Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161170AbWGIVlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161170AbWGIVlF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 17:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161168AbWGIVlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 17:41:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60051 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161170AbWGIVlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 17:41:03 -0400
Date: Sun, 9 Jul 2006 14:40:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: reuben-lkml@reub.net, mingo@redhat.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, linux-acpi@vger.kernel.org, greg@kroah.com,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.18-rc1-mm1
Message-Id: <20060709144035.5ec1c451.akpm@osdl.org>
In-Reply-To: <20060709103312.5f78ad38.rdunlap@xenotime.net>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	<44B0E6E6.6070904@reub.net>
	<20060709103312.5f78ad38.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2006 10:33:12 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> > [root@tornado ~]# cat /proc/interrupts
> >             CPU0       CPU1
> >    0:     258266          0   IO-APIC-edge     timer
> >    4:        355          0   IO-APIC-edge     serial
> >    6:          5          0   IO-APIC-edge     floppy
> >    8:          1          0   IO-APIC-edge     rtc
> >    9:          0          0   IO-APIC-fasteoi  acpi
> >   14:         28          0   IO-APIC-edge     libata
> >   15:          0          0   IO-APIC-edge     libata
> >   16:          0          0   IO-APIC-fasteoi  uhci_hcd:usb5
> >   18:          0          0   IO-APIC-fasteoi  uhci_hcd:usb4
> >   19:        980          0   IO-APIC-fasteoi  uhci_hcd:usb3, serial
> >   23:        105          0   IO-APIC-fasteoi  ehci_hcd:usb1, uhci_hcd:usb2
> > 313:      82513          0   PCI-MSI-<NULL>  eth0
> > 314:      57370          0   PCI-MSI-<NULL>  libata
> 
> "We" need to fix that <NULL> there.

Seems that irq_desc[i].handle_irq is msi_irq_wo_maskbit_type or
msi_irq_w_maskbit_type and kernel/irq/chip.c:handle_irq_name() doesn't know
about that.

handle_irq_name() is a bit of a crock - this info should be in the irq_desc
struct or somewhere like that.

