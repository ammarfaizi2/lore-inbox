Return-Path: <linux-kernel-owner+w=401wt.eu-S1030214AbXAKIMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbXAKIMl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 03:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbXAKIMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 03:12:41 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:41082 "HELO
	smtp105.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030214AbXAKIMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 03:12:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=g7gukPZFMAe9XE1QFoBYpriE9+KwYsbHeVQQVit6TRIDh5b/sN4B50vy+GIcmAIytRFULjU2qlVHpVWinU6KPiUTFmL2Z8UTzfYnbvt/N+7DL3564KA1jCt28WqA0q7ahauCkxabm3nzUPutOlvuqATAbckODD3DSNYd0cmZKjQ=  ;
X-YMail-OSG: 2dxA7VoVM1mAijmXT6AP7rqPHyvmhwuKuGbN4fCc2xTlretsgSIoKUWPtWlgx0DclpQ4MGcNthQ3cvtTIXmerlACom3ubabzhQ7zuM_fxdI82nz9G6pPfwREnuEPfCZ68sm_bHjzXtzsBtY-
Message-ID: <45A5F157.9030001@yahoo.com.au>
Date: Thu, 11 Jan 2007 19:12:07 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Aubrey <aubreylee@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>	 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>	 <6d6a94c50701102150w4c3b46d0w6981267e2b873d37@mail.gmail.com>	 <20070110220603.f3685385.akpm@osdl.org>	 <6d6a94c50701102245g6afe6aacxfcb2136baee5cbfa@mail.gmail.com>	 <20070110225720.7a46e702.akpm@osdl.org>	 <45A5E1B2.2050908@yahoo.com.au> <6d6a94c50701102354l7ab41a3bp4761566204f1d992@mail.gmail.com>
In-Reply-To: <6d6a94c50701102354l7ab41a3bp4761566204f1d992@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aubrey wrote:
> On 1/11/07, Nick Piggin <nickpiggin@yahoo.com.au> wrote:

>> What you _really_ want to do is avoid large mallocs after boot, or use
>> a CPU with an mmu. I don't think nommu linux was ever intended to be a
>> simple drop in replacement for a normal unix kernel.
> 
> 
> Is there a position available working on mmu CPU? Joking, :)
> Yes, some problems are serious on nommu linux. But I think we should
> try to fix them not avoid them.

Exactly, and the *real* fix is to modify userspace not to make > PAGE_SIZE
mallocs[*] if it is to be nommu friendly. It is the kernel hacks to do things
like limit cache size that are the bandaids.

Of course, being an embedded system, if they work for you then that's
really fine and you can obviously ship with them. But they don't need to
go upstream.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
