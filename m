Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262565AbVCWATo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbVCWATo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 19:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbVCWATo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 19:19:44 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:31123 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262565AbVCWATm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 19:19:42 -0500
Message-ID: <4240B61A.9070909@yahoo.com.au>
Date: Wed, 23 Mar 2005 11:19:38 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: hugh@veritas.com, akpm@osdl.org, tony.luck@intel.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com>	<20050322034053.311b10e6.akpm@osdl.org>	<Pine.LNX.4.61.0503221617440.8666@goblin.wat.veritas.com>	<20050322110144.3a3002d9.davem@davemloft.net>	<20050322112125.0330c4ee.davem@davemloft.net>	<20050322112329.70bde057.davem@davemloft.net>	<Pine.LNX.4.61.0503221931150.9348@goblin.wat.veritas.com>	<20050322123301.090cbfa6.davem@davemloft.net>	<Pine.LNX.4.61.0503222142280.9761@goblin.wat.veritas.com>	<4240AAFA.1040206@yahoo.com.au> <20050322154459.7afb4f4f.davem@davemloft.net>
In-Reply-To: <20050322154459.7afb4f4f.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Wed, 23 Mar 2005 10:32:10 +1100
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>I think David's on the right track - I think there's something a
>>bit wrong at the top. In my reply to Andrew in this thread I
>>posted a patch which may at least get things working...
> 
> 
> We have to do the "if (ceiling)" check in every spot where
> we mask it in some way, and if it falls to zero from non-zero
> due to the masking, we skip.
> 
> That gives me a mostly working kernel.
> 

I see. Tricky.

> Bad news is that while lat_proc's fork and exec tests improve
> dramatically, shell performance is way down on sparc64.
> I'll post before and after numbers in a bit.  Note, this is
> just with Hugh's base patch plus bug fixes.
> 

That's interesting. The only "extra" stuff Hugh's should be
doing is the vma traversal.

The single walk patch seems to fit in quite well with Hugh's
updated patchset. I haven't quite worked out how to best do
hugepages, but it is easily possible. But I won't dust that
off again until Hugh's is nicely tested and working.

