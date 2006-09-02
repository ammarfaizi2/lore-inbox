Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWIBIo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWIBIo6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 04:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWIBIo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 04:44:57 -0400
Received: from mx1.suse.de ([195.135.220.2]:6341 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750858AbWIBIo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 04:44:56 -0400
Date: Sat, 2 Sep 2006 01:44:40 -0700
From: Greg KH <gregkh@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Matthias Hentges <oe@hentges.net>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: 2.6.18-rc5-mm1
Message-ID: <20060902084440.GA13361@suse.de>
References: <20060901015818.42767813.akpm@osdl.org> <1157158847.20509.10.camel@mhcln03> <20060901183028.1c6da4df.akpm@osdl.org> <44F93EB3.8050500@goop.org> <44F942B9.6050102@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F942B9.6050102@goop.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 02, 2006 at 01:37:13AM -0700, Jeremy Fitzhardinge wrote:
> Jeremy Fitzhardinge wrote:
> >The NULL EIP is desc->handle_irq in do_IRQ():
> >
> >        asm volatile(
> >            "       xchgl  %%ebx,%%esp      \n"
> >            "       call   *%%edi           \n"
> >            "       movl   %%ebx,%%esp      \n"
> >            : "=a" (arg1), "=d" (arg2), "=c" (arg3), "=b" (ebx)
> >            :  "0" (irq),   "1" (desc),  "2" (regs),  "3" (isp),
> >               "D" (desc->handle_irq)
> >            : "memory", "cc"
> >        );
> >
> >In my case, the IRQ is 0xdb = 219, which is an MSI interrupt for 
> >libata (the AHCI SATA controller, presumably).  The exception happens 
> >just after the SATA driver has probed all the hard disks.
> >
> >So it seems to me that the suspects are 1) sata, or 2) MSI.  I'll try 
> >turning off MSI to see if it helps.
> 
> Yes, that fixed it; with MSI disabled I can boot successfully.
> 
> : ezr:pts/0; cd hg/linux-2.6/patches/broken-out/
> : ezr:pts/0; ls *msi* | wc -l
> 23
> 
> Hm, where to start...

There are 9 MSI patches in my tree that you can just remove.  They were
just recently (a few hours ago) replaced with a total rewrite due to a
number of different problems that were found.  So I'd suggest just
waiting till the next -mm release to see if it works properly or not.

thanks,

greg k-h

-- 
VGER BF report: H 0
