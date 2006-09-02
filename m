Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWIBIhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWIBIhW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 04:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWIBIhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 04:37:21 -0400
Received: from gw.goop.org ([64.81.55.164]:5783 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750840AbWIBIhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 04:37:19 -0400
Message-ID: <44F942B9.6050102@goop.org>
Date: Sat, 02 Sep 2006 01:37:13 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Andrew Morton <akpm@osdl.org>, Matthias Hentges <oe@hentges.net>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, Greg KH <gregkh@suse.de>
Subject: Re: 2.6.18-rc5-mm1
References: <20060901015818.42767813.akpm@osdl.org>	<1157158847.20509.10.camel@mhcln03> <20060901183028.1c6da4df.akpm@osdl.org> <44F93EB3.8050500@goop.org>
In-Reply-To: <44F93EB3.8050500@goop.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> The NULL EIP is desc->handle_irq in do_IRQ():
>
>         asm volatile(
>             "       xchgl  %%ebx,%%esp      \n"
>             "       call   *%%edi           \n"
>             "       movl   %%ebx,%%esp      \n"
>             : "=a" (arg1), "=d" (arg2), "=c" (arg3), "=b" (ebx)
>             :  "0" (irq),   "1" (desc),  "2" (regs),  "3" (isp),
>                "D" (desc->handle_irq)
>             : "memory", "cc"
>         );
>
> In my case, the IRQ is 0xdb = 219, which is an MSI interrupt for 
> libata (the AHCI SATA controller, presumably).  The exception happens 
> just after the SATA driver has probed all the hard disks.
>
> So it seems to me that the suspects are 1) sata, or 2) MSI.  I'll try 
> turning off MSI to see if it helps.

Yes, that fixed it; with MSI disabled I can boot successfully.

: ezr:pts/0; cd hg/linux-2.6/patches/broken-out/
: ezr:pts/0; ls *msi* | wc -l
23

Hm, where to start...

    J

-- 
VGER BF report: H 0
