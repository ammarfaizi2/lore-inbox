Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbVBDUPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbVBDUPp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263049AbVBDUPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:15:44 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:8424 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262709AbVBDUOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:14:38 -0500
Message-ID: <4203D793.1040604@nortel.com>
Date: Fri, 04 Feb 2005 14:14:11 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Arjan van de Ven <arjan@infradead.org>, linuxppc-dev@ozlabs.org,
       Linux kernel <linux-kernel@vger.kernel.org>, linuxppc64-dev@ozlabs.org
Subject: Re: question on symbol exports
References: <41FECA18.50609@nortelnetworks.com> <1107243398.4208.47.camel@laptopd505.fenrus.org> <41FFA21C.8060203@nortelnetworks.com> <1107273017.4208.132.camel@laptopd505.fenrus.org> <20050204203050.GA5889@dmt.cnet>
In-Reply-To: <20050204203050.GA5889@dmt.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've added the ppc64 list to the addressees, in case they are interested.


Marcelo Tosatti wrote:
> On Tue, Feb 01, 2005 at 04:50:16PM +0100, Arjan van de Ven wrote:

>>afaik one doesn't need to do a tlb flush in code that clears the dirty
>>bit, as long as you use the proper vm functions to do so. 
>>(if those need a tlb flush, those are supposed to do that for you
>>afaik).

> Yep, and "proper VM function" is include/asm-generic/pgtable.h::ptep_clear_flush_dirty(),
> which on PPC flushes the TLB.

It turns out that to call ptep_clear_flush_dirty() on ppc64 from a 
module I needed to export the following symbols:

__flush_tlb_pending
ppc64_tlb_batch
hpte_update

>>Also note that your code isn't dealing with 4 level pagetables.... And
>>pagetable walking in drivers is basically almost always a mistake and a
>>sign that something is wrong.

> Or a sign that the core kernel lacks helper functions :) 

Absolutely.  It'd be so nice if there was a simple va_to_ptep() helper 
function available.

Chris
