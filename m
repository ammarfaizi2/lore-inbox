Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbVF1Pwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVF1Pwv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 11:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVF1Pwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 11:52:50 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:21900 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262101AbVF1Pws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 11:52:48 -0400
Message-ID: <42C17028.6050903@yahoo.com.au>
Date: Wed, 29 Jun 2005 01:43:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Anton Blanchard <anton@samba.org>
Subject: Re: [patch 2] mm: speculative get_page
References: <42C0AAF8.5090700@yahoo.com.au> <20050628040608.GQ3334@holomorphy.com> <42C0D717.2080100@yahoo.com.au> <20050627.220827.21920197.davem@davemloft.net> <20050628141903.GR3334@holomorphy.com>
In-Reply-To: <20050628141903.GR3334@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Mon, Jun 27, 2005 at 10:08:27PM -0700, David S. Miller wrote:
> 
>>BTW, I disagree with this assertion.  spin_unlock() does imply a
>>memory barrier.
>>All memory operations before the release of the lock must execute
>>before the lock release memory operation is globally visible.
> 
> 
> The affected architectures have only recently changed in this regard.
> ppc64 was the most notable case, where it had a barrier for MMIO
> (eieio) but not a general memory barrier. PA-RISC likewise formerly had
> no such barrier and was a more normal case, with no barrier whatsoever.
> 
> Both have since been altered, ppc64 acquiring a heavyweight sync
> (arch nomenclature), and PA-RISC acquiring 2 memory barriers.
> 

Parisc looks like it's doing the extra memory barrier to "be safe" :P

Re the ppc64 chageset: It looks to me like lwsync is the lightweight
sync, and eieio is just referred to as the lightER (than sync) weight
sync. What's more, it looks like eieio does order stores to system
memory and is not just an MMIO barrier.

But nit picking aside, is it true that we need a load barrier before
unlock? (store barrier I agree with) The ppc64 changeset in question
indicates yes, but I can't quite work out why. There are noises in the
archives about this, but I didn't pinpoint a conclusion...

Send instant messages to your online friends http://au.messenger.yahoo.com 
