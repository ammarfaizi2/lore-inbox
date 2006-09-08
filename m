Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWIHSwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWIHSwe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 14:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbWIHSwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 14:52:34 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:38185 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1750936AbWIHSwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 14:52:32 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=ufAK+S9TCpKKWb3E0BlsTxVvq8VKaSg6q1W2NCftahO4fgYSihCAzD0KCievX/xK79iIJveYt8zZPzpdP2ht30houyf56cf7hlHiAjw6augFcSirsOaHSBDKvtesqBya;
X-IronPort-AV: i="4.09,134,1157346000"; 
   d="scan'208"; a="76797588:sNHT18332649"
Date: Fri, 8 Sep 2006 13:52:29 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc5] PCI: sort device lists breadth-first
Message-ID: <20060908185228.GA16197@humbolt.us.dell.com>
Reply-To: Matt Domsch <Matt_Domsch@dell.com>
References: <20060908031422.GA4549@lists.us.dell.com> <20060908112035.f7a83983.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908112035.f7a83983.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 11:20:35AM -0700, Andrew Morton wrote:
> On Thu, 7 Sep 2006 22:14:22 -0500
> Matt Domsch <Matt_Domsch@dell.com> wrote:
> 
> > @@ -189,6 +189,8 @@ static int __init pcibios_init(void)
> >  
> >  	pcibios_resource_survey();
> >  
> > +	if (!(pci_probe & PCI_NO_SORT))
> > +		pci_sort_breadthfirst();
> >
> > ...
> >
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1055,3 +1055,95 @@ EXPORT_SYMBOL(pci_scan_bridge);
> >  EXPORT_SYMBOL(pci_scan_single_device);
> >  EXPORT_SYMBOL_GPL(pci_scan_child_bus);
> >  #endif
> > +
> > +static int pci_sort_bf_cmp(const struct pci_dev *a, const struct pci_dev *b)
> > +static void pci_insertion_sort_klist(struct pci_dev *a, struct list_head *list,
> > +static void pci_sort_breadthfirst_klist(void)
> > +static void pci_insertion_sort_devices(struct pci_dev *a, struct list_head *list,
> > +static void pci_sort_breadthfirst_devices(void)
> > +void pci_sort_breadthfirst(void)
> 
> I think all these functions can+should be __init?
> 
> > +extern void pci_sort_breadthfirst(void);
> 
> In which case this needs the __init tag too (new rule, due to frv (at least)).

Will fix up immediately.  I also see that it's making indirect calls
through the (*cmp)() pointer, which is interesting only of there's
other code that's going to be doing insertion sorting.  For now, a
direct call to the comparison function would be a little cleaner.

Thanks for the review!
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
