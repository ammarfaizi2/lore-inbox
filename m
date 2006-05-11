Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWEKXxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWEKXxT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 19:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWEKXxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 19:53:19 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:14005 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1750837AbWEKXxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 19:53:18 -0400
Message-ID: <4463CE5D.1030301@myri.com>
Date: Fri, 12 May 2006 01:53:01 +0200
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
       "Andrew J. Gallatin" <gallatin@myri.com>
Subject: Re: [PATCH 4/6] myri10ge - First half of the driver
References: <Pine.GSO.4.44.0605101438410.498-100000@adel.myri.com> <adahd3x7d0b.fsf@cisco.com>
In-Reply-To: <adahd3x7d0b.fsf@cisco.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>  > +#define myri10ge_pio_copy(to,from,size) __iowrite64_copy(to,from,size/8)
>
> Why do you need this wrapper?  Why not just call __iowrite64_copy()
> without the obfuscation?  Anyone reading the code will just have to
> search back to this define and mentally translate the size back and
> forth all the time.
>   

Well, I know that abstraction layer is bad. But in this case I really
think that a name like myri10ge_pio_copy(size) is way less obfuscating
than __iowrite64_copy(size/8).
Will fix it if it really matters.


>  > +int myri10ge_hyper_msi_cap_on(struct pci_dev *pdev)
>  > +{
>  > +	uint8_t cap_off;
>  > +	int nbcap = 0;
>  > +
>  > +	cap_off = PCI_CAPABILITY_LIST - 1;
>  > +	/* go through all caps looking for a hypertransport msi mapping */
>
> This looks like something that should be fixed up in the general PCI
> quirk handling rather than in every driver...
>
>  > +static int
>  > +myri10ge_use_msi(struct pci_dev *pdev)
>  > +{
>  > +	if (myri10ge_msi == 1 || myri10ge_msi == 0)
>  > +		return myri10ge_msi;
>  > +
>  > +	/*  find root complex for our device */
>  > +	while (pdev->bus && pdev->bus->self) {
>  > +		pdev = pdev->bus->self;
>  > +	}
>
> Similarly looks like generic PCI code (if it's needed at all).  If I
> understand correctly you're trying to check if MSI has a chance at
> working on the system, but a network device driver has no business
> walking up the PCI hierarchy.
>   

Right, I will look at moving all this to the core PCI code.


Thanks for all the comments.

Brice

