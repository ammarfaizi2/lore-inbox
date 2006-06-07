Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWFGRbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWFGRbI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 13:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWFGRbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 13:31:07 -0400
Received: from mga07.intel.com ([143.182.124.22]:41 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S932356AbWFGRbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 13:31:06 -0400
X-IronPort-AV: i="4.05,217,1146466800"; 
   d="scan'208"; a="47492044:sNHT815357767"
Date: Wed, 7 Jun 2006 10:26:37 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Christoph Hellwig <hch@infradead.org>,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, akpm@osdl.org,
       Rajesh Shah <rajesh.shah@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       "bibo,mao" <bibo.mao@intel.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 4/4] Make Emulex lpfc driver legacy I/O port free
Message-ID: <20060607102637.A25175@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20060606075812.GB19619@kroah.com> <448643B9.2080805@jp.fujitsu.com> <448644D6.9030907@jp.fujitsu.com> <20060607082448.GA31004@infradead.org> <4486C537.9040105@jp.fujitsu.com> <20060607124353.GA31777@infradead.org> <4486D070.2020806@jp.fujitsu.com> <20060607134034.GA4744@infradead.org> <4486DAF7.4040101@jp.fujitsu.com> <20060607145203.GA13951@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060607145203.GA13951@infradead.org>; from hch@infradead.org on Wed, Jun 07, 2006 at 03:52:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 03:52:03PM +0100, Christoph Hellwig wrote:
> On Wed, Jun 07, 2006 at 10:56:07PM +0900, Kenji Kaneshige wrote:
> > Christoph Hellwig wrote:
> > >On Wed, Jun 07, 2006 at 10:11:12PM +0900, Kenji Kaneshige wrote:
> > >
> > >>I mean the right order is
> > >>
> > >>  (1) pci_request_regions()
> > >>  (2) pci_enable_device*()
> > >
> > >
> > >no, pci_enable_device should be first.
> > >
> > >
> > 
> > I had the same wrong assumption before. But to prevent two
> > devices colliding on the same address range, pci_request_regions()
> > should be called first. Please see the following discussions:
> 
> No.  That's what the pci_driver matching is for.  Without pci_enable_device
> pci_request_regions could do the wrong thing when fixups aren't run.

I don't see how driver matching will help here. It seems wrong to
enable a device first, and then check if the resources it is
decoding actually conflict with some other device's resources.
Regarding quirks, all the ones that mess around with resources
are marked as HEADER quirks. So they should be called right
after a device is probed and before its driver can call
pci_request_regions(). What problems do you see if regions are
requested before the device is enabled?

Rajesh
