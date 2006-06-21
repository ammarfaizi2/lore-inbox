Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWFUBzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWFUBzq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 21:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWFUBzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 21:55:46 -0400
Received: from mga05.intel.com ([192.55.52.89]:18348 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750755AbWFUBzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 21:55:44 -0400
X-IronPort-AV: i="4.06,158,1149490800"; 
   d="scan'208"; a="55966737:sNHT38246544"
Date: Tue, 20 Jun 2006 18:50:16 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       discuss@x86-64.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>,
       Len Brown <len.brown@intel.com>,
       Kimball Murray <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 11/25] i386 irq:  Dynamic irq support
Message-ID: <20060620185015.F10402@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com> <11508425191063-git-send-email-ebiederm@xmission.com> <1150842520235-git-send-email-ebiederm@xmission.com> <11508425201406-git-send-email-ebiederm@xmission.com> <1150842520775-git-send-email-ebiederm@xmission.com> <11508425213394-git-send-email-ebiederm@xmission.com> <115084252131-git-send-email-ebiederm@xmission.com> <11508425213795-git-send-email-ebiederm@xmission.com> <11508425222427-git-send-email-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <11508425222427-git-send-email-ebiederm@xmission.com>; from ebiederm@xmission.com on Tue, Jun 20, 2006 at 04:28:24PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 04:28:24PM -0600, Eric W. Biederman wrote:
> The current implementation of create_irq() is a hack but it is the
> current hack that msi.c uses, and unfortunately the ``generic'' apic
> msi ops depend on this hack.  Thus we are stuck this hack of assuming
> irq == vector until the depencencies in the generic msi code are removed.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  arch/i386/kernel/io_apic.c |   48 ++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 48 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
> index 16966f4..04f78ff 100644
> --- a/arch/i386/kernel/io_apic.c
> +++ b/arch/i386/kernel/io_apic.c
> @@ -2497,6 +2497,54 @@ static int __init ioapic_init_sysfs(void
>  
>  device_initcall(ioapic_init_sysfs);
>  
> +#ifdef CONFIG_PCI_MSI
> +/*

It would be really good to decouple MSI implementation from IO
APICs, since there's really no real hardware dependence here.
This code can actually go to arch/xxx/pci/msi-apic.c

Rajesh
