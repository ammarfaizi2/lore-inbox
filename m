Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbWBWQDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWBWQDL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbWBWQDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:03:11 -0500
Received: from fmr17.intel.com ([134.134.136.16]:58029 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751501AbWBWQDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:03:09 -0500
Message-ID: <43FDDCAB.6020900@linux.intel.com>
Date: Thu, 23 Feb 2006 17:02:51 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       mingo@elte.hu
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> <1140707358.4672.67.camel@laptopd505.fenrus.org> <200602231700.36333.ak@suse.de>
In-Reply-To: <200602231700.36333.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thursday 23 February 2006 16:09, Arjan van de Ven wrote:
> 
>> This patch puts the infrastructure in place to allow for a reordering of
>> functions based inside the vmlinux. The general idea is that it is possible
>> to put all "common" functions into the first 2Mb of the code, so that they
>> are covered by one TLB entry. This as opposed to the current situation where
>> a typical vmlinux covers about 3.5Mb (on x86-64) and thus 2 TLB entries.
>> (This patch depends on the previous patch to pin head.S as first in the order)
> 
> I think you would first need to move the code first for that. Currently it starts
> at 1MB, which means 1MB is already wasted of the aligned 2MB TLB entry.
> 
> I wouldn't have a problem with moving the 64bit kernel to 2MB though.

ok I am hoping that 1Mb would be enough already but I'll investigate 
this, it sure makes sense
> 
>> I think that to get to a better list we need to invite people to submit
>> their own profiles, and somehow add those all up and base the final list on
>> that. I'm willing to do that effort if this is ends up being the prefered
>> approach. Such an effort probably needs to be repeated like once a year or
>> so to adopt to the changing nature of the kernel.
> 
> Looks reasonable. 
> 
> Afaik newer gcc can even separate likely and unlikely code into different sections.
> I don't see you trying to handle that. 

last discussion about this was that it made code actually bigger because 
it now needs long rather than local jumps etc, so the gcc people aren't 
too fond of it.

> 
> Also if you're serious about saving TLBs it might be worth it to prereserve
> some memory near the main kernel mapping for modules (e.g. with a boot option) 
> and load them there. Then they would be covered with the same TLB entry too.

that's on my to-look-at list already yes
