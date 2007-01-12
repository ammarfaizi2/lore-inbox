Return-Path: <linux-kernel-owner+w=401wt.eu-S1030475AbXALCsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030475AbXALCsE (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 21:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbXALCsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 21:48:04 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:33344 "HELO
	smtp108.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030478AbXALCsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 21:48:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=4ev7wBI3cDVgq1Ms8o5rcKJkxs/vz9kVsEBSGAgi4TrSdrrNL23O+xNbkgV2/dUxNYbVAiwQulrpKhhhUR20EP6yN4fZzp2YMv1m7pZbyoHxSIPjiOxWbWJzFvtC5qdVutNXjhllFbGJs8QAlvdAtdCPLwluI9FqeaOUyBBpfx4=  ;
X-YMail-OSG: fOzZejwVM1kRG4_befp6u_ytGVzaYmds1z8jQ0.05ssV7Yu_dtFVW8On10A_F_rs1lGUnWNaRjiwafE1qelYXfXk4Y1xWks3MB8afxNgi2Bm79rtdR.LCKqpIcdf6N37AbW0Nm9AVlkZcPo-
Message-ID: <45A6F6C2.80905@yahoo.com.au>
Date: Fri, 12 Jan 2007 13:47:30 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Aubrey <aubreylee@gmail.com>
CC: Roy Huang <royhuang9@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, mjt@tls.msk.ru,
       Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>	 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>	 <6d6a94c50701102150w4c3b46d0w6981267e2b873d37@mail.gmail.com>	 <20070110220603.f3685385.akpm@osdl.org>	 <6d6a94c50701102245g6afe6aacxfcb2136baee5cbfa@mail.gmail.com>	 <20070110225720.7a46e702.akpm@osdl.org>	 <45A5E1B2.2050908@yahoo.com.au>	 <6d6a94c50701102354l7ab41a3bp4761566204f1d992@mail.gmail.com>	 <afe668f90701110005ya2e8187pc6604c5aad24cc84@mail.gmail.com> <6d6a94c50701111812q64035fcdheeadfaaf0da9a68c@mail.gmail.com>
In-Reply-To: <6d6a94c50701111812q64035fcdheeadfaaf0da9a68c@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aubrey wrote:
> On 1/11/07, Roy Huang <royhuang9@gmail.com> wrote:
> 
>> On a embedded systerm, limiting page cache can relieve memory
>> fragmentation. There is a patch against 2.6.19, which limit every
>> opened file page cache and total pagecache. When the limit reach, it
>> will release the page cache overrun the limit.
> 
> 
> The patch seems to work for me. But some suggestions in my mind:
> 
> 1) Can we limit the total page cache, not the page cache per each file?
>    think about if total memory is 128M, 10% of it is 12.8M, here if
> one application is running, it can use 12.8M vfs cache, then the
> performance will probably not be impacted. However, the current patch
> limit the page cache per each file, which means if only one
> application runs it can only use CONFIG_PAGE_LIMIT pages cache. It may
> be small to the application.
> ------------------snip---------------
> if (mapping->nrpages >= mapping->pages_limit)
>               balance_cache(mapping);
> ------------------snip---------------
> 
> 2) A percent number should be better to control the value. Can we add
> a proc interface to make the value tunable?

Even a global value isn't completely straightforward, and a per-file value
would be yet more work.

You see, it is hard to do any sort of directed reclaim at these pages.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
