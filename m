Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVF2DE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVF2DE0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 23:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVF2DE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 23:04:26 -0400
Received: from colin.muc.de ([193.149.48.1]:5643 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261510AbVF2DEQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 23:04:16 -0400
Date: 29 Jun 2005 05:04:15 +0200
Date: Wed, 29 Jun 2005 05:04:15 +0200
From: Andi Kleen <ak@muc.de>
To: Greg KH <greg@kroah.com>
Cc: Linas Vepstas <linas@austin.ibm.com>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
Subject: Re: [PATCH 1/13]: PCI Err: pci.h header file changes
Message-ID: <20050629030415.GC71992@muc.de>
References: <20050628235817.GA6324@austin.ibm.com> <20050629002951.GA17885@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050629002951.GA17885@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 05:29:51PM -0700, Greg KH wrote:
> On Tue, Jun 28, 2005 at 06:58:17PM -0500, Linas Vepstas wrote:
> > @@ -673,6 +704,7 @@ struct pci_driver {
> >  	int  (*enable_wake) (struct pci_dev *dev, pci_power_t state, int enable);   /* Enable wake event */
> >  	void (*shutdown) (struct pci_dev *dev);
> >  
> > +	struct pci_error_handlers err_handler;
> >  	struct device_driver	driver;
> >  	struct pci_dynids dynids;
> >  };
> 
> Shouldn't that be a pointer and not the whole structure?  Wouldn't that
> make it easier to "reuse" error handlers?

Yes, it's a good idea. In fact we could have a generic NIC error
handler structure then that just calls the watchdog timeout function.
I suspect that would be sufficient for most NICs.

-Andi
