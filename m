Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267562AbUBRRRb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 12:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267556AbUBRRRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 12:17:30 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:25812 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267562AbUBRRRX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 12:17:23 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: mzyngier@freesurf.fr, Dave Jones <davej@redhat.com>
Subject: Re: EISA & sysfs.
Date: Wed, 18 Feb 2004 18:23:22 +0100
User-Agent: KMail/1.5.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040217235431.GF6242@redhat.com> <20040218155317.GQ6242@redhat.com> <wrp8yj04ba8.fsf@panther.wild-wind.fr.eu.org>
In-Reply-To: <wrp8yj04ba8.fsf@panther.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402181823.22034.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Consider this:
- both CONFIG_EISA and CONFIG_PCI are defined
- hp100_isa_init() returns an error (ie. -ENODEV)
- eisa_driver_register() and pci_module_init() are called
- hp100_module_init() returns -ENODEV,
  module fails to load, so hp100_module_exit() is not called
- &hp100_eisa_driver and &hp100_pci_driver are still happily
  registered with sysfs

This is far too common mistake... :-(

On Wednesday 18 of February 2004 17:12, Marc Zyngier wrote:
> >>>>> "Dave" == Dave Jones <davej@redhat.com> writes:
>
> Dave> kernel: kobject_register failed for hp100 (-17)
>
> -17 == -EEXIST.
>
> Looks like the driver was already loaded once, or managed to leave
> some sh*t into sysfs.
>
> Dave> Something also seems awry someplace else..
>
> Dave> (15:54:51:root@mindphaser:linux-2.6.2)# cat /proc/modules  | grep
> hp100 Dave> (15:54:55:root@mindphaser:linux-2.6.2)# rmmod hp100
> Dave> ERROR: Module hp100 does not exist in /proc/modules
> Dave> (15:55:18:root@mindphaser:linux-2.6.2)# modprobe hp100
> Dave> FATAL: Module hp100 already in kernel.
> Dave> (15:55:25:root@mindphaser:linux-2.6.2)# cat /proc/modules | grep
> hp100 Dave> (15:55:33:root@mindphaser:linux-2.6.2)#
>
> Dave> Odd.
>
> I've already seen that with half-initialized modules...
>
> 	M.

