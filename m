Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWBWSAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWBWSAZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 13:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWBWSAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 13:00:24 -0500
Received: from fmr20.intel.com ([134.134.136.19]:41925 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932403AbWBWSAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 13:00:23 -0500
Message-ID: <43FDF811.3090309@linux.intel.com>
Date: Thu, 23 Feb 2006 18:59:45 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org, ak@suse.de, torvalds@osdl.org, akpm@osdl.org,
       mingo@elte.hu
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> <1140707358.4672.67.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0602230933080.1579@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.64.0602230933080.1579@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Thu, 23 Feb 2006, Arjan van de Ven wrote:
> 
>> This patch puts the infrastructure in place to allow for a reordering of
>> functions based inside the vmlinux. The general idea is that it is possible
>> to put all "common" functions into the first 2Mb of the code, so that they
>> are covered by one TLB entry. This as opposed to the current situation where
>> a typical vmlinux covers about 3.5Mb (on x86-64) and thus 2 TLB entries.
>> (This patch depends on the previous patch to pin head.S as first in the order)
> 
> Hello Arjan,
> 	Assuming that functions defined in an object file are related and 
> hence benefit from cache spatial locality, doesn't this affect this 
> greatly? It would seem that with regards to the kernel image on x86, (2MB) 
> TLB usage isn't as scarce a resource as icache.

this is probably a mixed blessing; right now frequent and non-frequent 
code are highly intermixed, so even in the current situation the icache 
isn't optimally used.

So what you sort of want is a thing better than pure "sort", a sort that 
keeps existing order *within the hot functions*, but move the "cold" 
ones out. That is thankfully independent of the infrastructure; I'll 
keep that in mind when making the next version of the order list, it's a 
good idea.

