Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWCBEaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWCBEaR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 23:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWCBEaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 23:30:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:44237 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750854AbWCBEaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 23:30:16 -0500
From: Andi Kleen <ak@suse.de>
To: "Tony Luck" <tony.luck@intel.com>
Subject: Re: [Patch] Move swiotlb_init early on X86_64
Date: Thu, 2 Mar 2006 05:30:08 +0100
User-Agent: KMail/1.9.1
Cc: "Zou Nan hai" <nanhai.zou@intel.com>, LKML <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>,
       "Venkatesh Pallipadi" <venkatesh.pallipadi@intel.com>
References: <1141175458.2642.78.camel@linux-znh> <12c511ca0603012015g7a5bfa8dw4295c59f5dace4f9@mail.gmail.com>
In-Reply-To: <12c511ca0603012015g7a5bfa8dw4295c59f5dace4f9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603020530.09552.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 March 2006 05:15, Tony Luck wrote:
> On 01 Mar 2006 09:10:58 +0800, Zou Nan hai <nanhai.zou@intel.com> wrote:
> > on X86_64, swiotlb buffer is allocated in mem_init, after memmap and vfs cache allocation.
> >
> > On platforms with huge physical memory,
> > large memmap and vfs cache may eat up all usable system memory
> > under 4G.
> >
> > Move swiotlb_init early before memmap is allocated can
> > solve this issue.
> 
> Shouldn't memmap be allocated from memory above 4G (if available)? Using
> up lots of <4G memory on something that doesn't need to be below 4G
> sounds like a poor use of resources.

On the really large machines it will be distributed over the nodes anyways.
But yes the single node SMP case should probably allocate it higher.

-Andi
