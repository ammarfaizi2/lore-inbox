Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWBWN54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWBWN54 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 08:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWBWN54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 08:57:56 -0500
Received: from fmr17.intel.com ([134.134.136.16]:23192 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751241AbWBWN5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 08:57:55 -0500
Message-ID: <43FDBF55.3060502@linux.intel.com>
Date: Thu, 23 Feb 2006 14:57:41 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Patch to make the head.S-must-be-first-in-vmlinux order explicit
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> <200602231442.19903.ak@suse.de>
In-Reply-To: <200602231442.19903.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thursday 23 February 2006 14:19, Arjan van de Ven wrote:
>> This patch puts the code from head.S in a special .bootstrap.text
>> section.
>>
>> I'm working on a patch to reorder the functions in the kernel (I'll post
>> that later), but for x86-64 at least the kernel bootstrap requires that the
>> head.S functions are on the very first page/pages of the kernel text. This
>> is understandable since the bootstrap is complex enough already and not a
>> problem at all, it just means they aren't allowed to be reordered. This
>> patch puts these special functions into a separate section to document this,
>> and to guarantee this in the light of possibly reordering the rest later.
>>
>> (So this patch doesn't fix a bug per se, but makes things more robust by
>> making the order of these functions explicit)
> 
> I don't think the 64bit kernel code requires this actually

It didn't boot at first until I fixed this ;)

> (or at least
> it shouldn't), but arch/x86_64/boot/compressed/head.S
> seems to have the entry address hardcoded. Perhaps you can just change this
> to pass in the right address?

the issue is that the address will be a link time thing, which means 
lots of complexity. and it's only a handful of functions, so pinning 
these few explicitly looked to me like the best simple solution (eg 
anything else will be fragile and failures in this area are near 
impossible to debug, even when it'll work now complexity means it may 
fail in the future ;( )

