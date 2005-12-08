Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932749AbVLHXnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932749AbVLHXnW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 18:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbVLHXnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 18:43:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:11756 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932733AbVLHXnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 18:43:22 -0500
Date: Fri, 9 Dec 2005 00:43:20 +0100
From: Andi Kleen <ak@suse.de>
To: Rohit Seth <rohit.seth@intel.com>
Cc: Andi Kleen <ak@suse.de>, Ravikiran G Thirumalai <kiran@scalex86.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, zach@vmware.com, shai@scalex86.org,
       nippung@calsoftinc.com
Subject: Re: [discuss] [patch] x86_64:  align and pad x86_64 GDT on page boundary
Message-ID: <20051208234320.GB11190@wotan.suse.de>
References: <20051208215514.GE3776@localhost.localdomain> <1134083357.7131.21.camel@akash.sc.intel.com> <20051208231141.GX11190@wotan.suse.de> <1134084367.7131.32.camel@akash.sc.intel.com> <20051208232610.GY11190@wotan.suse.de> <1134085511.7131.53.camel@akash.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134085511.7131.53.camel@akash.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 03:45:11PM -0800, Rohit Seth wrote:
> On Fri, 2005-12-09 at 00:26 +0100, Andi Kleen wrote:
> 
> > Well if the Xen people have such requirements they can submit
> > separate patches. Currently they don't seem to be interested
> > at all in submitting patches to mainline, so we must work
> > with the VM hackers who are interested in this (scalex86, VMware) 
> > And AFAIK they only care about not having false sharing in there.
> > 
> 
> 
> Agreed.  
> 
> Though do we need to have full page allocated for each gdt (256 bytes)
> then? ...possibly use kmalloc.

For scalex I think it needs to be page aligned because that is what
the effective cacheline size for remote nodes is in their setup. 
That would be difficult for kmalloc because it cannot guarantee that
alignment nor avoid false sharing. For the BP case it's ok as 
long as the beginning is correctly aligned and the rest 
is read-only.

-Andi

