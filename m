Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWC1VmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWC1VmY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 16:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWC1VmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 16:42:24 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:1255 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S932236AbWC1VmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 16:42:23 -0500
Message-ID: <4429ADBC.50507@free.fr>
Date: Tue, 28 Mar 2006 23:42:20 +0200
From: Zoltan Menyhart <Zoltan.Menyhart@free.fr>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Fix unlock_buffer() to work the same way as bit_unlock()
References: <200603281853.k2SIrGg28290@unix-os.sc.intel.com>
In-Reply-To: <200603281853.k2SIrGg28290@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> Nick Piggin wrote on Tuesday, March 28, 2006 12:11 AM
> 
>>Also, I think there is still the issue of ia64 not having the
>>correct memory consistency semantics. To start with, all the bitops
>>and atomic ops which both modify their operand and return a value
>>should be full memory barriers before and after the operation,
>>according to Documentation/atomic_ops.txt.
>
> I suppose the usage of atomic ops is abused, it is used in both lock
> and unlock path.  And it naturally suck because it now requires full
> memory barrier.  A better way is to define 3 variants: one for lock
> path, one for unlock path, and one with full memory fence.

I agree. As I wrote a few days ago:

Why not to use separate bit operations for different purposes?

- e.g. "test_and_set_bit_N_acquire()" for lock acquisition
- "test_and_set_bit()", "clear_bit()" as they are today
- "release_N_clear_bit()"...

Thanks,

Zoltan

