Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbVCOA0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVCOA0q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 19:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVCOAZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 19:25:05 -0500
Received: from fmr24.intel.com ([143.183.121.16]:15808 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262156AbVCOAXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 19:23:46 -0500
Date: Mon, 14 Mar 2005 16:23:31 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
       tony.luck@intel.com, linux-ia64@vger.kernel.org, davidm@hpl.hp.com,
       hch@lst.de
Subject: Re: Fix irq_affinity write from /proc for IPF
Message-ID: <20050314162330.A22861@unix-os.sc.intel.com>
References: <20050314155004.A22573@unix-os.sc.intel.com> <20050314155923.4847aea3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050314155923.4847aea3.akpm@osdl.org>; from akpm@osdl.org on Mon, Mar 14, 2005 at 03:59:23PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 03:59:23PM -0800, Andrew Morton wrote:
> Ashok Raj <ashok.raj@intel.com> wrote:
> >
> 
> "ia64" is preferred, please.  Nobody knows what an IPF is.

Right!. Sorry about that.
> 
> 
> Is it not possible for ia64's ->set_affinity() handler to do this deferring?
> 

There are other places where we re-program, and its fine to call the 
current version of set_affinity directly, like when we are doing cpu offline
and trying to force migrate irqs for ia64.

Changing the default set_affinity() for ia64 would result in many changes, 
this still keeps the same purpose of those access functions, and 
differentiates the proc write cases alone without changing the meaning 
of those handler functions. (and a smaller patch)

this would further complicate the force migrate irq's when we consider 
MSI interrupts as well. Since it would have its own set_affinity, and we need
to hack into MSI's set affinity handler as well which would complicate things.

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
