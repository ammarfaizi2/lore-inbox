Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030619AbVIBA6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030619AbVIBA6s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 20:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030620AbVIBA6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 20:58:47 -0400
Received: from fmr18.intel.com ([134.134.136.17]:10222 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030619AbVIBA6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 20:58:47 -0400
Subject: RE: [RFC/PATCH]reconfigure MSI registers after resume
From: Shaohua Li <shaohua.li@intel.com>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E502409A1201A@orsmsx404.amr.corp.intel.com>
References: <C7AB9DA4D0B1F344BF2489FA165E502409A1201A@orsmsx404.amr.corp.intel.com>
Content-Type: text/plain
Date: Fri, 02 Sep 2005 09:03:13 +0800
Message-Id: <1125622993.4010.6.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-01 at 23:20 +0800, Nguyen, Tom L wrote:
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
Just when you called pci_disable_msi, reconfiguring MSI registers should
be done. Is there any pain of reconfiguring MSI registers?
I don't understand why should we have the assumption. If you disabled
the ability, you must reconfigure it to me. This is the easy logic.

Thanks,
Shaohua

