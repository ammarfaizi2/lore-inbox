Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbUKUQfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbUKUQfS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 11:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbUKUQb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 11:31:56 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33285 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261235AbUKUQ3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 11:29:17 -0500
Date: Sun, 21 Nov 2004 17:29:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Len Brown <len.brown@intel.com>, Chris Wright <chrisw@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
Message-ID: <20041121162915.GB2961@stusta.de>
References: <20041115152721.U14339@build.pdx.osdl.net> <1100819685.987.120.camel@d845pe> <20041118230948.W2357@build.pdx.osdl.net> <1100941324.987.238.camel@d845pe> <20041120124001.GA2829@stusta.de> <Pine.LNX.4.58.0411200940410.20993@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411200940410.20993@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 10:28:27AM -0800, Linus Torvalds wrote:
>...
> So I think the simpler fix is just this one-liner: we should not disable
> preexisting links, because non-PCI devices may depend on the same routing
> information, and thus the comments about "being activated on use" is not
> actually true.

I can confirm this patch fixes the problem for me in an otherwise 
unmodified 2.6.10-rc2.

> 		Linus
> 
> ===== drivers/acpi/pci_link.c 1.34 vs edited =====
> --- 1.34/drivers/acpi/pci_link.c	2004-11-01 23:40:09 -08:00
> +++ edited/drivers/acpi/pci_link.c	2004-11-20 09:43:56 -08:00
> @@ -685,9 +685,6 @@
>  	acpi_link.count++;
>  
>  end:
> -	/* disable all links -- to be activated on use */
> -	acpi_ut_evaluate_object(link->handle, "_DIS", 0, NULL);
> -
>  	if (result)
>  		kfree(link);

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

