Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266242AbUHMRLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266242AbUHMRLc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 13:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUHMRKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 13:10:34 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:63441 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266242AbUHMRJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 13:09:21 -0400
Date: Fri, 13 Aug 2004 10:08:45 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Dominik Brodowski <linux@dominikbrodowski.de>,
       Rusty Russell <rusty@rustcorp.com.au>, Greg KH <greg@kroah.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [UPDATED PATCH 1/2] export module parameters in sysfs for modules _and_ built-in code
Message-ID: <20040813170845.GA25666@beaverton.ibm.com>
References: <20040801165407.GA8667@dominikbrodowski.de> <1091426395.430.13.camel@bach> <20040802214710.GB7772@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802214710.GB7772@dominikbrodowski.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I finally tried this out, nice.

Is someone pushing it? I don't see it in 2.6.8-rc4-mm1.

-- Patrick Mansfield

On Mon, Aug 02, 2004 at 11:47:10PM +0200, Dominik Brodowski wrote:

> Create a new /sys top-level directory named "parameters", and make all
> to-be-sysfs-exported module parameters available as attributes to kobjects.
> Currently, only module parameters in _modules_ are exported in /sys/modules/,
> while those of "modules" built into the kernel can be set by the kernel command 
> line, but not read or set via sysfs.
> 
> For modules, a symlink
> 
> brodo@mondschein param $ ls -l /sys/module/ehci_hcd/ | grep param
> lrwxrwxrwx  1 brodo brodo    0  1. Aug 17:50 parameters -> ../../parameters/ehci_hcd
> 
> is added. Removal of double module parameters export for modules is sent in a second
> patch, so the diffstat
> 
>  include/linux/module.h      |    2
>  include/linux/moduleparam.h |   14 +
>  kernel/module.c             |   16 +
>  kernel/params.c             |  368 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 399 insertions(+), 1 deletion(-)
> 
> looks worse than it is.
> 
> Much of this work is based on the current code for modules only to be found in
> linux/kernel/module.c; many thanks to Rusty Russell for his code and his
> feedback!
> 
> Signed-off-by: Dominik Brodowski <linux@brodo.de>
