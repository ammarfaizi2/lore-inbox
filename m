Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWBERFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWBERFr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 12:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbWBERFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 12:05:47 -0500
Received: from ns2.suse.de ([195.135.220.15]:28810 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751188AbWBERFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 12:05:46 -0500
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org, bharata@in.ibm.com
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes 2.6.16-rc1[2] on 2 node X86_64
Date: Sun, 5 Feb 2006 18:03:58 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>
References: <20060205163618.GB21972@in.ibm.com>
In-Reply-To: <20060205163618.GB21972@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602051803.59437.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 February 2006 17:36, Bharata B Rao wrote:
> Hi,
> 
> I am seeing a kernel crash with 2.6.16-rc1 and rc2 but not on any
> 2.6.15 kernels (rc and 2.6.15.2). Arch is x86_64.
> 
> The kernel crashes when I run an application which does:
> 	- mmap (0, size, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS)
> 	- mbind the memory to the 1st node with policy MPOL_BIND
> 	- write to that memory
> 
> The crash time log on 2.6.16-rc2 looks like this:
> 
> Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:
> <ffffffff801614df>{__rmqueue+63}

There's another report of it. The boot logs seem ok, so I guess
mbind broke somehow. I suppose it's related to the mempolicy changes
that went into 2.6.16-rc1. I'll try to take a look tomorrow if
Christoph doesn't beat it.

OOM with mbind seems to have broken also - it oopses too.

-Andi
