Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268225AbUI2Gaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268225AbUI2Gaj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 02:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268229AbUI2Gah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 02:30:37 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:34734 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S268216AbUI2Gaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 02:30:30 -0400
Date: Wed, 29 Sep 2004 15:26:29 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [PATCH][3/4] Add hotplug support to drivers/acpi/numa.c
In-reply-to: <20040927130616.B30443@unix-os.sc.intel.com>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: tokunaga.keiich@jp.fujitsu.com, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net, lhns-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <20040929152629.68d17796.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20040920092520.A14208@unix-os.sc.intel.com>
 <20040920094719.H14208@unix-os.sc.intel.com>
 <20040924012301.000007c6.tokunaga.keiich@jp.fujitsu.com>
 <20040924013255.00000337.tokunaga.keiich@jp.fujitsu.com>
 <20040927130616.B30443@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2004 13:06:16 -0700 Keshavamurthy Anil S wrote:
> On Fri, Sep 24, 2004 at 01:32:55AM +0900, Keiichiro Tokunaga wrote:
> > +void acpi_numa_node_init(acpi_handle handle)
> Why is this function returning void? I expect
> this to return int, what do you think?
> > +
> > +	if (acpi_bus_get_device(handle, &node_dev)) {
> > +		printk(KERN_ERR"Unknown handle.\n");
> > +		return_VOID;
> > +	}
> Why do you need to call acpi_bus_get_device?

I wrote it for printk()s and ACPI_DEBUG_PRINT() to log.

        if (! _cnt) {                                                           
                ACPI_DEBUG_PRINT((ACPI_DB_INFO,                                 
                                  "nid of <%s> is not detected.\n",             
                                  acpi_device_bid(node_dev))); 
                goto cancel;                                                    
        }
        ...
        status = acpi_attach_data(handle, acpi_numa_data_handler, data);        
        if (ACPI_FAILURE(status)) {                                             
                printk(KERN_ERR"Failed to attach NUMA data for <%s>.\n",        
                       acpi_device_bid(node_dev));                              
                goto cancel;                                                    
        }

        printk(KERN_INFO"Container <%s> is NUMA node.\n",                       
               acpi_device_bid(node_dev));

> > +	acpi_walk_namespace(ACPI_TYPE_PROCESSOR,
> > +			    handle,
> > +			    (u32) 1,
> > +			    find_processor,
> > +			    data,
> > +			    (void **)&cnt);
> Why are you looking for processor device here?
> Please remove this acpi_walk_namespace function.

The reason why the acpi_walk_namespace() is used here was to
find a container object which is identical to a NUMA node.  My code
was assuming that a container having CPU and/or memory was
NUMA node sinece the current Linux seemed to assume so.

> > +	/*
> > diff -puN /dev/null include/acpi/numa.h
> > +#ifndef MAX_PXM_DOMAINS
> > +#define MAX_PXM_DOMAINS (256)
> > +#endif
> Why defining it again, It is already defined in asm-ia64/acpi.h file

Sorry, that's a stuff that I forgot to remove.  I will remove it.

Thanks,
Keiichiro Tokunaga
