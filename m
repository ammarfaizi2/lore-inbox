Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267827AbUBRSoK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 13:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267829AbUBRSoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 13:44:10 -0500
Received: from mail.kroah.org ([65.200.24.183]:16804 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267827AbUBRSoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 13:44:03 -0500
Date: Wed, 18 Feb 2004 10:01:25 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Marc Zyngier <mzyngier@freesurf.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: EISA & sysfs.
Message-ID: <20040218180125.GC2924@kroah.com>
References: <20040217235431.GF6242@redhat.com> <wrpfzd87mg6.fsf@panther.wild-wind.fr.eu.org> <20040218111612.GM6242@redhat.com> <wrp1xos5s2o.fsf@panther.wild-wind.fr.eu.org> <20040218155317.GQ6242@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218155317.GQ6242@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 03:53:17PM +0000, Dave Jones wrote:
> 
> ok, that stops it hanging at least, it now barfs a little failure
> message, and a calltrace.  This seems awfully verbose for a failure
> path that isn't unreasonable IMO.
> 
> kernel: kobject_register failed for hp100 (-17)
> kernel: Call Trace:
> kernel:  [<c01d3662>] kobject_register+0x31/0x39
> kernel:  [<c0221d0c>] bus_add_driver+0x2e/0x83
> kernel:  [<c01db6db>] pci_register_driver+0x6b/0x87
> kernel:  [<c78078ad>] hp100_module_init+0x12/0x22 [hp100]
> kernel:  [<c013c0fc>] sys_init_module+0x14e/0x25e
> kernel:  [<c010b697>] syscall_call+0x7/0xb

It's not "unresonable", it just means that someone messed up and we are
now letting the user/developer know.  It's normally because someone
named their driver the same name as another one.

Actually, it's nice to see this message get printed out, and not the
"normal" oops that happens around this area for this case.  Something
must be working correctly :)

I'll go fix that printk to put the proper KERN_ level on it...

thanks,

greg k-h
