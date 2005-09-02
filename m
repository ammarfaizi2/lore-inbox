Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbVIBT6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbVIBT6b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 15:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbVIBT6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 15:58:31 -0400
Received: from fmr24.intel.com ([143.183.121.16]:21985 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751029AbVIBT6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 15:58:30 -0400
Date: Fri, 2 Sep 2005 12:58:22 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       "Li, Shaohua" <shaohua.li@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH]reconfigure MSI registers after resume
Message-ID: <20050902125822.A11794@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <C7AB9DA4D0B1F344BF2489FA165E502409A45B38@orsmsx404.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E502409A45B38@orsmsx404.amr.corp.intel.com>; from tom.l.nguyen@intel.com on Thu, Sep 01, 2005 at 01:59:32PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 01:59:32PM -0700, Nguyen, Tom L wrote:
> On Thursday, September 01, 2005 1:10 PM Andrew Morton wrote:
> > Is it not possible to do this in some single centralized place?
> Existing pci_save_state(dev)/pci_restore_state(dev) covers only 64 bytes
> of PCI header. One solution is to extend these APIs to cover up to 256
> bytes. What do you think?
> 
No, we can't have these generic functions blindly save/restore
device specific parts of the config space (offset 64+). I know
of several chipset devices which have read-clear or write-clear
bits where reading/writing would have bad side effects. If at
all the pci core does this, it needs to explicitly walk the
capability list and save/restore the well known capability
registers only.

Rajesh

