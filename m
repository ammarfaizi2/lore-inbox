Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266874AbUFYWDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266874AbUFYWDo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 18:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266876AbUFYWDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 18:03:44 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:53208 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266874AbUFYWDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 18:03:42 -0400
Date: Sat, 26 Jun 2004 00:03:34 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [2.6 patch] fix arch/i386/pci/Makefile
Message-ID: <20040625220334.GK18303@fs.tum.de>
References: <20040625001513.GB18303@fs.tum.de> <20040625180115.GC28162@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040625180115.GC28162@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 07:01:15PM +0100, Matthew Wilcox wrote:
> On Fri, Jun 25, 2004 at 02:15:14AM +0200, Adrian Bunk wrote:
> > This problem occurs with
> >   CONFIG_ACPI_PCI=y && (CONFIG_X86_VISWS=y || CONFIG_X86_NUMAQ=y)
> 
> That combination certainly doesn't make sense.  No VisWS or NUMAQ systems
> have ACPI.  How did you manage to turn this on given:
> 
> menu "ACPI (Advanced Configuration and Power Interface) Support"
>         depends on !X86_VISWS
>         depends on !IA64_HP_SIM
>         depends on IA64 || X86
> 
> If you apply the following patch, does it help?
> 
> --- drivers/acpi/Kconfig        30 Mar 2004 12:42:25 -0000      1.11
> +++ drivers/acpi/Kconfig        25 Jun 2004 18:00:29 -0000
> @@ -3,7 +3,7 @@
>  #
>  
>  menu "ACPI (Advanced Configuration and Power Interface) Support"
> -       depends on !X86_VISWS
> +       depends on !X86_VISWS && !X86_NUMAQ
>         depends on !IA64_HP_SIM
>         depends on IA64 || X86

Yes thanks, this fixes it.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

