Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWEXRI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWEXRI7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 13:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWEXRI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 13:08:59 -0400
Received: from mga07.intel.com ([143.182.124.22]:32533 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751170AbWEXRI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 13:08:58 -0400
X-IronPort-AV: i="4.05,167,1146466800"; 
   d="scan'208"; a="41036084:sNHT3041917627"
Date: Wed, 24 May 2006 10:05:05 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Greg KH <gregkh@suse.de>, Roland Dreier <rolandd@cisco.com>,
       Brice Goglin <brice@myri.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: AMD 8131 MSI quirk called too late, bus_flags not inherited ?
Message-ID: <20060524100505.A400@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <4468EE85.4000500@myri.com> <20060518155441.GB13334@suse.de> <20060521101656.GM30211@mellanox.co.il> <447047F2.2070607@myri.com> <20060521121726.GQ30211@mellanox.co.il> <44705DA4.2020807@myri.com> <20060521131025.GR30211@mellanox.co.il> <447069F7.1010407@myri.com> <20060523041958.GA8415@suse.de> <20060524165958.GE21266@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060524165958.GE21266@mellanox.co.il>; from mst@mellanox.co.il on Wed, May 24, 2006 at 07:59:58PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 07:59:58PM +0300, Michael S. Tsirkin wrote:
> 
> Offtopic, something I wanted to bring up with respect to MSI,
> but never had the time to debug:
> 
> If I do
> 
> pci_enable_msix, pci_disable_msix
> 
> then later
> 
> pci_enable_msi
> 
> on the same device fails with the following message:
> PCI: 0000:08:00.0: Can't enable MSI.  Device already has MSI-X vectors assigned
> 
> This is not something new - has been happening since forever.
> Looks like not all MSI-X vectors get properly unassigned by pci_disable_msix.
> 
Yes, this has been reported by others too. I've been looking at
MSI code recently to fix an unrelated problem, and noticed that
the code has policies about vector reservation that prevent
what you're trying to do. I'm planning to clean up the MSI
code shortly (patches out hopefully by next week), and will
remove such policies since many people are trying to do this.

thanks,
Rajesh
