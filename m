Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVCLJiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVCLJiu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 04:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVCLJiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 04:38:50 -0500
Received: from one.firstfloor.org ([213.235.205.2]:34474 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261155AbVCLJh5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 04:37:57 -0500
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: greg@kroah.com, tom.l.nguyen@intel.com, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org, seto.hidetoshi@jp.fujitsu.com
Subject: Re: [PATCH 1/6] PCI Express Advanced Error Reporting Driver
References: <200503120012.j2C0CIj4020297@snoqualmie.dp.intel.com>
From: Andi Kleen <ak@muc.de>
Date: Sat, 12 Mar 2005 10:37:55 +0100
In-Reply-To: <200503120012.j2C0CIj4020297@snoqualmie.dp.intel.com> (tlnguyen@snoqualmie.dp.intel.com's
 message of "Fri, 11 Mar 2005 16:12:18 -0800")
Message-ID: <m1psy5xkzw.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

long <tlnguyen@snoqualmie.dp.intel.com> writes:

I haven't read your code in detail, just a high level remark.

> +6. Enabling AER Aware Support in PCI Express Device Driver
> +
> +To enable AER aware support requires a software driver to configure
> +the AER capability structure within its device, to initialize its AER
> +aware callback handle and to call pcie_aer_register. Sections 6.1,
> +6.2, and 6.3 describe how to enable AER aware support in details.

[...]

There is currently discussion underway for a generic portable PCI 
error reporting interface for drivers. This is already being worked
on by some PPC64 and IA64 people. I don't think it would be a good idea
to add another incompatible PCI-E specific interface.

So I would recommend to not apply pcie_aer_register() et.al.
and coordinate with the others working on this area on a common
interface.

This would only impact the device driver interface; having
a PCI Express specific interface in sysfs is probably ok.

Otherwise we would end up with tons of ifdefs in the drivers
supporting multiple error reporting interfaces for different platforms, 
which would be bad.

Also in general I think the necessary callbacks should
be part of the basic device; not provided in a separate structure.

-Andi

