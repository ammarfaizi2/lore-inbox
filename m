Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbVIATdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbVIATdR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 15:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbVIATdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 15:33:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48081 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965182AbVIATdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 15:33:17 -0400
Date: Thu, 1 Sep 2005 12:31:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: greg@kroah.com, shaohua.li@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH]reconfigure MSI registers after resume
Message-Id: <20050901123137.514f79dc.akpm@osdl.org>
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E502409A1201A@orsmsx404.amr.corp.intel.com>
References: <C7AB9DA4D0B1F344BF2489FA165E502409A1201A@orsmsx404.amr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Nguyen, Tom L" <tom.l.nguyen@intel.com> wrote:
>
> On Wednesday, August 31, 2005 2:44 PM Greg KH wrote:
> >>On Thu, Aug 18, 2005 at 01:35:46PM +0800, Shaohua Li wrote:
> >> Hi,
> >> It appears pci_enable_msi doesn't reconfigure msi registers if it
> >> successfully look up a msi for a device. It assumes the data and
> address
> >> registers unchanged after calling pci_disable_msi. But this isn't
> always
> >> true, such as in a suspend/resume circle. In my test system, the
> >> registers unsurprised become zero after a S3 resume. This patch fixes
> my
> >> problem, please look at it. MSIX might have the same issue, but I
> >> haven't taken a close look.
> 
> > Tom, any comments on this?
> 
> In the cases of suspend/resume, a device driver needs to restore its PCI
> configuration space registers, which include the MSI/MSI-X capability
> structures if a device uses MSI/MSI-X. I think reconfiguring MSI
> data/address each time a driver calls pci_enable_msi may not be
> necessary.
> 

So what is the alternative to Shaohua's fix?  Restore all the msi registers
on resume?
