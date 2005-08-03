Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbVHCMOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbVHCMOF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 08:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVHCMNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 08:13:49 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:37308 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262264AbVHCMNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 08:13:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=5B7Iut2CB6eVqsNYpaRbFsXy04hAEWLRsQjsnkh/us5Yq4q4CJ13DEYWpqryWZVWdnoqthPVXtgloALPQitZ0AI+8kBQOUCQPZu8BZTi9jJGic7CPxCF08+oaG5wt+Zlly2PGCYWrp1Wtphck7cS6iHhzo4HVm7Xnf2Iit20hWY=  ;
Message-ID: <42F0B4D6.5030604@yahoo.com.au>
Date: Wed, 03 Aug 2005 22:13:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
References: <OF3BCB86B7.69087CF8-ON42257051.003DCC6C-42257051.00420E16@de.ibm.com> <Pine.LNX.4.58.0508020829010.3341@g5.osdl.org> <Pine.LNX.4.61.0508021645050.4921@goblin.wat.veritas.com> <Pine.LNX.4.58.0508020911480.3341@g5.osdl.org> <Pine.LNX.4.61.0508021809530.5659@goblin.wat.veritas.com> <Pine.LNX.4.58.0508021127120.3341@g5.osdl.org> <Pine.LNX.4.61.0508022001420.6744@goblin.wat.veritas.com> <Pine.LNX.4.58.0508021244250.3341@g5.osdl.org> <Pine.LNX.4.61.0508022150530.10815@goblin.wat.veritas.com> <42F09B41.3050409@yahoo.com.au> <Pine.LNX.4.61.0508031231540.13845@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0508031231540.13845@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

> Stupidity was the reason I thought handle_mm_fault couldn't be inline:
> I was picturing it static inline within mm/memory.c, failed to make the
> great intellectual leap you've achieved by moving it to include/linux/mm.h.
> 

Well it was one of my finer moments, so don't be too hard on
yourself.

> 
> No, I don't think it would break anything: it's just an historic oddity,
> used to be -1 for failure, and only got given a name recently, I think
> when wli added the proper major/minor counting.
> 
> Your version of the patch looks less hacky to me (not requiring
> VM_FAULT_WRITE_EXPECTED arg), though we could perfectly well remove
> that at leisure by adding VM_FAULT_WRITE case into all the arches in
> 2.6.14 (which might be preferable to leaving the __inline obscurity?).
> 

Well depends on what they want I suppose. Does it even make sense
to expose VM_FAULT_WRITE to arch code if it will just fall through
to VM_FAULT_MINOR?

With my earlier VM_FAULT_RACE thing, you can squint and say that's
a different case to VM_FAULT_MINOR - and accordingly not increment
the minor fault count. Afterall, minor faults *seem* to track count
of modifications made to the pte entry minus major faults, rather
than the number of times the hardware traps. I say this because we
increment the number in get_user_pages too.

But...

> I don't mind either way, but since you've not yet found an actual
> error in mine, I'd prefer you to make yours a tidyup patch on top,
> Signed-off-by your own good self, and let Linus decide whether he
> wants to apply yours on top or not.  Or perhaps the decision rests
> for the moment with Robin, whether he gets his customer to test
> yours or mine - whichever is tested is the one which should go in.
> 

I agree that for the moment we probably just want something that
works. I'd be just as happy to go with your patch as is for now.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
