Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbUCSU6k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 15:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbUCSU6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 15:58:40 -0500
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:41479
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S261225AbUCSU5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 15:57:24 -0500
Date: Fri, 19 Mar 2004 12:54:50 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Sergey Vlasov <vsu@altlinux.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: hpt366-0.37.patch.bz2 K.O.
In-Reply-To: <20040319202335.4179737f.vsu@altlinux.ru>
Message-ID: <Pine.LNX.4.10.10403191251180.2569-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So the point is that I know there will not be a version greater than two
on this asic?

I post fixes for problems people pay to have fixed.
If there are other problems, you are free to fix it yourself.

I have been doing this for only the past 6 years, there is just a tiny bit
of insight I might have.  Hey apply or not.

Regards,

Andre Hedrick
LAD Storage Consulting Group

On Fri, 19 Mar 2004, Sergey Vlasov wrote:

> On Fri, 19 Mar 2004 04:53:22 -0800 (PST) Andre Hedrick wrote:
> 
> > http://www.kernel.org/pub/linux/kernel/people/hedrick/ide-2.4.25/hpt366-0.37.patch.bz2
> > 
> > Fixes fifo dma data corruption on RocketRaid404
> > Fixes native HPT372 detection/setup for HPT372/HPT372A/HPT372N
> > 
> > HPT372N's previous code seems kooky, but then again do not have specific
> > hardware rev in question.
> 
>  static void __init init_setup_hpt37x (struct pci_dev *dev, ide_pci_device_t *d)
>  {
> +	if (d->device == PCI_DEVICE_ID_TTI_HPT372) {
> +		unsigned int class_rev;
> +		static char *chipset_names[] = {"HPT372", "HPT372A", "HPT372N"};
> +
> +		pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
> +		class_rev &= 0xff;
> +		d->name = chipset_names[class_rev];
> +	}
> +
>  	ide_setup_pci_device(dev, d);
>  }
> 
> This will blow up if a chip with the same PCI ID and a revision larger
> than 2 ever appears.
> 
> Also, hpt366_init_one() is __devinit, but it calls d->init_setup, and
> all init_setup_*() functions are __init - does not look good.  Hmm,
> this is present in many drivers, also in 2.6.x... apparently this is
> safe because such devices cannot be hotplugged.
> 

