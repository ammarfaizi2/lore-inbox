Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbUJZDwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbUJZDwd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 23:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbUJZDtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 23:49:12 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:44436 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262086AbUJZDsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 23:48:22 -0400
Message-ID: <417DC8F2.7000902@yahoo.com.au>
Date: Tue, 26 Oct 2004 13:48:02 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: lowmem_reserve (replaces protection)
References: <20041025170128.GF14325@dualathlon.random> <Pine.LNX.4.44.0410252147330.30224-100000@chimarrao.boston.redhat.com> <20041026015825.GU14325@dualathlon.random>
In-Reply-To: <20041026015825.GU14325@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Mon, Oct 25, 2004 at 09:48:25PM -0400, Rik van Riel wrote:
> 
>>On Mon, 25 Oct 2004, Andrea Arcangeli wrote:
>>
>>
>>>This is a forward port to 2.6 CVS of the lowmem_reserve VM feature in
>>>the 2.4 kernel.
>>>
>>>	http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.9/lowmem_reserve-1
>>
>>-       unsigned long           protection[MAX_NR_ZONES];
>>+       unsigned long           lowmem_reserve[MAX_NR_ZONES];
>>
>>The gratituous renaming of variable and function names makes
>>it hard to see what this patch actually changed.  Hard enough
>>that I'm not sure what the behavioural difference is supposed
>>to be.
> 
> 
> the behavioural difference is the API and the fact the feaure is now
> enabled with sane values (the previous code was disabled by default and
> it was unusable with that API). besides fixing the API the patch nukes
> dozens of useless lines of code and a buffer overflow.  The sysctl
> definitely needs renaming or it'd break the ABI with userspace, it's far
> from a gratituous rename. since I was foroced to change the sysctl name
> accordingly with the new 2.4 API, I thought renaming the variable that
> is set by the sysctl was also required, otherwise the sysctl is called
> lowmem_reserve and the variable is still called protection. Clearly it's
> much cleaner if _both_ sysctl and variable are called lowmem_reserve.
> 
> I could have used protection2 to still use the "protection" name, but
> lowmem_reserve (btw, the same name I used first in 2.4, before
> protection ever existed in 2.6) looks nicer to me.
> 

I'd say go with the name change. "protection" is fairly vague...
OTOH, lowmem_reserve doesn't quite carry the meaning that it is
_protecting_ lower zones from higher zone allocations... maybe
lowmem_protection? But I don't mind too much.

I see classzone_idx snuck in, can we leave that as alloc_type please?

Otherwise, looks great.
