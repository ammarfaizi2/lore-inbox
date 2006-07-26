Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030383AbWGZE5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbWGZE5o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 00:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbWGZE5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 00:57:44 -0400
Received: from mga06.intel.com ([134.134.136.21]:61710 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030383AbWGZE5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 00:57:43 -0400
X-IronPort-AV: i="4.07,181,1151910000"; 
   d="scan'208"; a="104471524:sNHT37344755"
Subject: Re: [PATCH 5/5] PCI-Express AER implemetation: pcie_portdrv error
	handler
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Greg KH <greg@kroah.com>, Tom Long Nguyen <tom.l.nguyen@intel.com>
In-Reply-To: <20060724193752.GD7448@austin.ibm.com>
References: <1152688203.28493.214.camel@ymzhang-perf.sh.intel.com>
	 <1152854749.28493.286.camel@ymzhang-perf.sh.intel.com>
	 <1152854873.28493.289.camel@ymzhang-perf.sh.intel.com>
	 <1152854937.28493.291.camel@ymzhang-perf.sh.intel.com>
	 <1152855040.28493.294.camel@ymzhang-perf.sh.intel.com>
	 <1152855124.28493.297.camel@ymzhang-perf.sh.intel.com>
	 <1152855338.28493.300.camel@ymzhang-perf.sh.intel.com>
	 <20060724193752.GD7448@austin.ibm.com>
Content-Type: text/plain
Message-Id: <1153889791.3984.3.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 26 Jul 2006 12:56:31 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-25 at 03:37, Linas Vepstas wrote:
> Hi,
> 
> Sorry for a late reply...
> 
> On Fri, Jul 14, 2006 at 01:35:38PM +0800, Zhang, Yanmin wrote:
> > 
> > --- linux-2.6.17/drivers/pci/pcie/portdrv_pci.c	2006-06-22 16:27:35.000000000 +0800
> > +++ linux-2.6.17_aer/drivers/pci/pcie/portdrv_pci.c	2006-06-22 16:46:29.000000000 +0800
> > +
> > +static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
> > +					enum pci_channel_state error)
> > +{
> > +	/* If fatal, save cfg space for possible link reset at upstream */
> > +	if (error == pci_channel_io_frozen)
> > +		pcie_portdrv_save_config(dev);
> 
> If the channel is frozen, is the config space still readable? 
> In my case, I had to save config space data early on before
> the bus error. 
You are right.

> 
> What's more, I discovered that I had to save the pci config 
> space data before device drivers do thier probe. During the probe, 
> device drivers will change the config. For example, they'll enable
> interrupts and dma. If you turn these on, and then do the probe,
> you'll get spectacuar failures.
> 
> To be safe, I found the best thing to do was to save the pci
> config space state as it was during boot, before the PCI probe 
> routines ran.
Thanks. I will try.

> 
> --linas
