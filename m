Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWELUlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWELUlP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 16:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWELUlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 16:41:15 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:53192
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751381AbWELUlO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 16:41:14 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [patch 3/9] Add Intel HW RNG driver
Date: Fri, 12 May 2006 22:48:38 +0200
User-Agent: KMail/1.9.1
References: <20060512103522.898597000@bu3sch.de> <20060512103647.777856000@bu3sch.de> <20060512110807.GB19254@master.mivlgu.local>
In-Reply-To: <20060512110807.GB19254@master.mivlgu.local>
Cc: akpm@osdl.org, Deepak Saxena <dsaxena@plexity.net>,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605122248.38797.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 May 2006 13:08, you wrote:
> > +static struct pci_device_id pci_tbl[] = {
> 
> Should be const.

Sure, will fix that for every driver.

> > +	for_each_pci_dev(pdev) {
> > +		ent = pci_match_id(pci_tbl, pdev);
> > +		if (ent)
> > +			goto found;
> > +	}
> > +	/* Device not found. */
> > +	goto out;
> 
> 	if (!pci_dev_present(pci_tbl))
> 		goto out;

Good idea. I just copied the code from the old driver.

> > +	err = hwrng_register(&intel_rng);
> > +	if (err) {
> > +		printk(KERN_ERR PFX "RNG registering failed (%d)\n",
> > +		       err);
> > +		goto out;
> 
> 		goto err_unmap;

oops.

-- 
Greetings Michael.
