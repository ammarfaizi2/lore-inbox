Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWFBEmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWFBEmZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 00:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWFBEmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 00:42:25 -0400
Received: from colo.lackof.org ([198.49.126.79]:55738 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1751120AbWFBEmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 00:42:25 -0400
Date: Thu, 1 Jun 2006 22:42:21 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       "bibo,mao" <bibo.mao@intel.com>, akpm@osdl.org,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, kaneshige.kenji@jp.fujitsu.com
Subject: Re: [BUG](-mm)pci_disable_device function clear bars_enabled element
Message-ID: <20060602044221.GB1501@colo.lackof.org>
References: <447E91CE.7010705@intel.com> <20060601024611.A32490@unix-os.sc.intel.com> <20060601171559.GA16288@colo.lackof.org> <20060601113625.A4043@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060601113625.A4043@unix-os.sc.intel.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 11:36:26AM -0700, Rajesh Shah wrote:
> On Thu, Jun 01, 2006 at 11:15:59AM -0600, Grant Grundler wrote:
> > +   The device driver needs to call pci_request_region() to make sure
> > +no other device is already using the same resource. The driver is expected
> > +to determine MMIO and IO Port resource availability _before_ calling
> > +pci_enable_device().  Conversely, drivers should call pci_release_region()
> > +_after_ calling pci_disable_device(). The idea is to prevent two devices
> > +colliding on the same address range.
> > +
> A quick look in the drivers directory shows that _lots_ of drivers
> violate this rule. In fact, I suspect Kaneshige-san made the original
> incorrect assumption since there were so many drivers out there
> which do it in the wrong order.

That's ok. It's not a big deal normally.
It's just when BIOS is broken and assigns overlapping ranges to
multiple devices or mis-routes MMIO address space that we need
this to work right.  The vast majority of BIOS's do get it right
and that's why I'm not terribly worried.

If there is consensus the drivers are wrong, then it's pretty
easy to fix and we don't have to panic.

Do you agree with the change in the text?

thanks,
grant
