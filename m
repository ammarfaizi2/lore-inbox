Return-Path: <linux-kernel-owner+w=401wt.eu-S1030465AbXALCsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030465AbXALCsA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 21:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbXALCsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 21:48:00 -0500
Received: from mail.tmr.com ([64.65.253.246]:41839 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030465AbXALCr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 21:47:59 -0500
Message-ID: <45A6F70E.1050902@tmr.com>
Date: Thu, 11 Jan 2007 21:48:46 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>	 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>	 <6d6a94c50701102150w4c3b46d0w6981267e2b873d37@mail.gmail.com>	 <20070110220603.f3685385.akpm@osdl.org>	 <6d6a94c50701102245g6afe6aacxfcb2136baee5cbfa@mail.gmail.com>	 <20070110225720.7a46e702.akpm@osdl.org>	 <45A5E1B2.2050908@yahoo.com.au> <6d6a94c50701102354l7ab41a3bp4761566204f1d992@mail.gmail.com> <45A5F157.9030001@yahoo.com.au>
In-Reply-To: <45A5F157.9030001@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Aubrey wrote:
>> On 1/11/07, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>> What you _really_ want to do is avoid large mallocs after boot, or use
>>> a CPU with an mmu. I don't think nommu linux was ever intended to be a
>>> simple drop in replacement for a normal unix kernel.
>>
>>
>> Is there a position available working on mmu CPU? Joking, :)
>> Yes, some problems are serious on nommu linux. But I think we should
>> try to fix them not avoid them.
> 
> Exactly, and the *real* fix is to modify userspace not to make > PAGE_SIZE
> mallocs[*] if it is to be nommu friendly. It is the kernel hacks to do 
> things
> like limit cache size that are the bandaids.

Tuning the system to work appropriately for a given load is not a 
band-aid. I have been saying since 2.5.x times that filling memory with 
cached writes was a bad thing, and filling with writes to a single file 
was a doubly bad thing. Back in 2.4.NN-aa kernels, there were some 
tunables to address that, but other than adding your own 2.6 just 
behaves VERY badly for some loads.
> 
> Of course, being an embedded system, if they work for you then that's
> really fine and you can obviously ship with them. But they don't need to
> go upstream.
> 
Anyone who has a few processes which write a lot of data and many 
processes with more modest i/o needs will see the overfilling of cache 
with data from one process or even for one file, and the resulting 
impact on the performance of all other processes, particularly if the 
kernel decides to write all the data for one file at once, because it 
avoids seeks, even if it uses the drive for seconds. The code has gone 
too far in the direction of throughput, at the expense of response to 
other processes, given the (common) behavior noted.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
