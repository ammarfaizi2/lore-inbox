Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWCWS7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWCWS7G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 13:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbWCWS7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 13:59:06 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:4282 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932432AbWCWS7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 13:59:05 -0500
Date: Thu, 23 Mar 2006 12:58:12 -0600
From: Jon Mason <jdmason@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Jon Mason <jdmason@us.ibm.com>, Muli Ben-Yehuda <mulix@mulix.org>,
       Muli Ben-Yehuda <muli@il.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/3] x86-64: Calgary IOMMU - hook it in
Message-ID: <20060323185812.GB30099@us.ibm.com>
References: <20060320084848.GA21729@granada.merseine.nu> <200603231736.44223.ak@suse.de> <20060323173047.GA30099@us.ibm.com> <200603231848.19041.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603231848.19041.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 06:48:18PM +0100, Andi Kleen wrote:
> On Thursday 23 March 2006 18:30, Jon Mason wrote:
> 
> > We have a recent modification to this chunk which does both generic and
> > em64t.  Since IBM only ships this chip on em64t systems, have the option
> > on amd64 seems wrong.
> 
> Please read again what I wrote.

Oh, I agree that it should be there for the generic option, but I think
it is legitimate to have it disabled for MK8.  I'll defer to you though
:-)

> 
> > Because we need to know the size of the translation tables early, so
> > that we can alloc them from bootmem.
> 
> But __setup is parsed during the bootmem phase too. early arguments are only
> needed for things called by setup_arch

I actually tried __setup during development of this code, and it didn't
work.  The problem was that __setup, while called early, it is not
called until after setup_arch (and we need to know our table size when
detect_calgary is called at the end of setup_arch).

Thanks,
Jon

> -Andi
>  
