Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWEOImx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWEOImx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 04:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWEOImw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 04:42:52 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:2234 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964836AbWEOImw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 04:42:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=gqtfpeoo+FDfwRZWUp2BUK7XrhUsXFwyy2ArfQlLso3tDSi63+yTsp3wZXLITJussKFCHHphjt6v/rXblz4A6Ny/Ie4EGDe024zKKN9tvnh7ipNMe4dSzIyTyqhggTuLPn+d1VeCeB6iizroTQGTFxI/NPOjgQwryBuX1Z9x6KQ=  ;
Message-ID: <44683F05.5050709@yahoo.com.au>
Date: Mon, 15 May 2006 18:42:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Antti Salmela <asalmela@iki.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at mm/vmscan.c:428 (2.6.17-rc4-git2, Dualcore AMD
 x86-64)
References: <20060515082508.GA6950@asalmela.iki.fi>
In-Reply-To: <20060515082508.GA6950@asalmela.iki.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antti Salmela wrote:
> My Dualcore AMD x86-64 desktop has been a little bit unstable as long as I
> remember, but at last I had enough willpower to enable netconsole to see
> if anything was reported after a lockup. For some reason these
> BUG messages made now their way to local log file too.
> 
> May 15 06:51:43 enigma kernel: ----------- [cut here ] --------- [please bite here ] ---------
> May 15 06:51:43 enigma kernel: Kernel BUG at mm/vmscan.c:428
> May 15 06:51:43 enigma kernel: invalid opcode: 0000 [1] PREEMPT SMP 

Thanks for reporting.

Either you have an active page on the inactive list, or your hardware has
flipped a bit in page->flags. I was going to say the latter is more likely,
however -- AFAIKS, the first oops should cause that page to be lost from the
LRU list, so the second oops shouldn't happen if the flip a single bad bit,
and should be pretty unlikely if it is a random error.

Still, anything explainable by a single bit flip is worth running memtest86+
overnight for.

Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
