Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752214AbWIHFp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbWIHFp2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 01:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752215AbWIHFp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 01:45:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:37566 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752212AbWIHFp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 01:45:27 -0400
Date: Thu, 7 Sep 2006 22:45:15 -0700
From: Greg KH <greg@kroah.com>
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Andrew Morton <akpm@osdl.org>,
       USB Development List <linux-usb-devel@lists.sourceforge.net>,
       Kernel Development List <linux-kernel@vger.kernel.org>,
       Bart Prescott <bart.prescott@elandigitalsystems.com>
Subject: Re: USB: u132-hcd: host controller driver for ELAN U132 adapter
Message-ID: <20060908054515.GB10302@kroah.com>
References: <200609051620.k85GK4d24135@elandigitalsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609051620.k85GK4d24135@elandigitalsystems.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2006 at 04:12:24PM +0100, Tony Olech wrote:
> + #include <linux/config.h>
> + #include <linux/kernel.h>
> + #include <linux/version.h>
> + #include <linux/module.h>
> + #include <linux/moduleparam.h>
> + #include <linux/delay.h>
> + #include <linux/ioport.h>
> + #include <linux/sched.h>
> + #include <linux/slab.h>
> + #include <linux/smp_lock.h>
> + #include <linux/errno.h>
> + #include <linux/init.h>
> + #include <linux/timer.h>
> + #include <linux/list.h>
> + #include <linux/interrupt.h>
> + #include <linux/usb.h>
> + #include <linux/workqueue.h>
> + #include <linux/platform_device.h>
> + #include <linux/pci_ids.h>
> + #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 16)
> + #error you need at least 2.6.16 to get mutexes
> + #endif

That check doesn't mean anything in a driver that is in the kernel tree.
You can remove it.

> + #include <asm/io.h>
> + #include <asm/irq.h>
> + #include <asm/system.h>
> + #include <asm/byteorder.h>
> + #include "../core/hcd.h"
> + #include "ohci.h"
> + #define OHCI_CONTROL_INIT OHCI_CTRL_CBSR
> + #define OHCI_INTR_INIT (OHCI_INTR_MIE | OHCI_INTR_UE | OHCI_INTR_RD | \
> +         OHCI_INTR_WDH)
> + MODULE_AUTHOR("Tony Olech - Elan Digital Systems Limited");
> + MODULE_DESCRIPTION("U132 USB Host Controller Driver");
> + MODULE_LICENSE("GPL");
> + #define INT_MODULE_PARM(n, v) static int n = v;module_param(n, int, 0444)
> + INT_MODULE_PARM(testing, 0);
> + /* Some boards misreport power switching/overcurrent*/
> + static int distrust_firmware = 1;
> + module_param(distrust_firmware, bool, 0);
> + MODULE_PARM_DESC(distrust_firmware, "true to distrust firmware power/overcurren"
> +         "t setup");
> + #define U132_INFO(format, arg...) printk(KERN_INFO "u132.%d " format "\n", \
> +         u132->sequence_num, ## arg)
> + #define ELAN_INFO(format, arg...) printk(KERN_INFO "u132 " format "\n", ## arg)
> + #define U132_WARN(format, arg...) printk(KERN_WARNING "u132.%d " format "\n", \
> +         u132->sequence_num, ## arg)
> + #define ELAN_WARN(format, arg...) printk(KERN_WARNING "u132 " format "\n", ## \
> +         arg)
> + #define U132_ERR(format, arg...) printk(KERN_ERR "u132.%d " format "\n", \
> +         u132->sequence_num, ## arg)
> + #define ELAN_ERR(format, arg...) printk(KERN_ERR "u132 " format "\n", ## arg)
> + DECLARE_WAIT_QUEUE_HEAD(u132_hcd_wait);
> + /*
> + * u132_module_lock exists to protect access to global variables
> + *
> + */
> + struct mutex u132_module_lock;

Is it supposed to be global like this?  Or can it be static?

thanks,

greg k-h
