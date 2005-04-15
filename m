Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVDOGvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVDOGvL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 02:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVDOGvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 02:51:11 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:23787 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261750AbVDOGu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 02:50:58 -0400
Date: Fri, 15 Apr 2005 08:50:48 +0200
From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
To: linux-kernel@vger.kernel.org
Cc: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com
Subject: Re: [Bug] invalid mac address after rebooting (2.6.12-rc2-mm2)
Message-ID: <20050415065048.GA16611@faui00u.informatik.uni-erlangen.de>
References: <20050323122423.GA24316@faui00u.informatik.uni-erlangen.de> <200504132124.04871.daniel.ritz@gmx.ch> <20050413224108.GA29349@faui00u.informatik.uni-erlangen.de> <200504141940.53506.daniel.ritz@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504141940.53506.daniel.ritz@gmx.ch>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 07:40:52PM +0200, Daniel Ritz wrote:
> could you apply this debuggin patch instead and send me the dmsg output
> plus output from lspci, lspci -vvvn. also please send me a hexdump from
> /proc/bus/pci/00/0b.0
> 
> i think i'm having some 3coms around so maybe i can reprocude :)
> 
> rgds
> -daniel
> 
> --- 1.81/drivers/pci/pci.c	2005-03-03 08:17:57 +01:00
> +++ edited/drivers/pci/pci.c	2005-04-05 00:37:13 +02:00
> @@ -268,7 +268,7 @@
>  		return -EIO; 
>  
>  	pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
> -	if ((pmc & PCI_PM_CAP_VER_MASK) > 2) {
> +	if ((pmc & PCI_PM_CAP_VER_MASK) > 3) {
>  		printk(KERN_DEBUG
>  		       "PCI: %s has unsupported PM cap regs version (%u)\n",
>  		       pci_name(dev), pmc & PCI_PM_CAP_VER_MASK);
> @@ -287,15 +287,19 @@
>  	 * This doesn't affect PME_Status, disables PME_En, and
>  	 * sets PowerState to 0.
>  	 */
> -	if (dev->current_state >= PCI_D3hot)
> +	printk("PCI: %s pmc: %04x, current_state, pmcsr: %08x", pci_name(dev), pmc, dev->current_state);
> +	if (dev->current_state >= PCI_D3hot) {
>  		pmcsr = 0;
> -	else {
> +		printk("0");
> +	} else {
>  		pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
> +		printk("%04x", pmcsr);
>  		pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
>  		pmcsr |= state;
>  	}
>  
>  	/* enter specified state */
> +	printk(", new: %04x\n", pmcsr);
>  	pci_write_config_word(dev, pm + PCI_PM_CTRL, pmcsr);
>  
>  	/* Mandatory power management transition delays */
> 

I send Daniel the info privately, but just for your convenience, I put
it also on my homepage [1].


-Peter

[1]: http://wwwcip.informatik.uni-erlangen.de/~siprbaum/kernel/

...._1.txt = working version (first boot)
...._2.txt = non working version (second boot)


