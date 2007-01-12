Return-Path: <linux-kernel-owner+w=401wt.eu-S1751600AbXALE4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbXALE4z (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 23:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbXALE4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 23:56:54 -0500
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:20356 "HELO
	smtp104.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751588AbXALE4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 23:56:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=mzN4euW2uNrS+pTGyIhE9p+TbwivaRbPtnUsorBKVMbc6lhqtYxy/HtG0CVABOjsO5YhZwyxBTh/DJHSp91aTBjISYJZWKDyPDvEotNIWqljnB5TjjQJb8WoSVlUBu/EpkwbKwnPyYzjhwkrKaD85vCO77w9NFjqx4dCftFI6Vg=  ;
X-YMail-OSG: cMFsvDEVM1mQoj3MkZx7yWiFeCdsK6F78y8_Elboj2CSZmFXc1Uwn5xkvZ08lBLJsCEhfUpaMAv0NcvmP5jmoS27Jxr6ZE_SPMH4uxKpzdecrvXHyV988FT5Q5V1hLspyCACxWXny3ZyU74-
Message-ID: <45A714F8.6020600@yahoo.com.au>
Date: Fri, 12 Jan 2007 15:56:24 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Bill Davidsen <davidsen@tmr.com>, Andrew Morton <akpm@osdl.org>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>  <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>  <6d6a94c50701102150w4c3b46d0w6981267e2b873d37@mail.gmail.com>  <20070110220603.f3685385.akpm@osdl.org>  <6d6a94c50701102245g6afe6aacxfcb2136baee5cbfa@mail.gmail.com>  <20070110225720.7a46e702.akpm@osdl.org>  <45A5E1B2.2050908@yahoo.com.au> <6d6a94c50701102354l7ab41a3bp4761566204f1d992@mail.gmail.com> <45A5F157.9030001@yahoo.com.au> <45A6F70E.1050902@tmr.com> <45A70EF9.40408@yahoo.com.au> <Pine.LNX.4.64.0701112044070.3594@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701112044070.3594@woody.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 12 Jan 2007, Nick Piggin wrote:
> 
>>We are talking about about fragmentation. And limiting pagecache to try to
>>avoid fragmentation is a bandaid, especially when the problem can be solved
>>(not just papered over, but solved) in userspace.
> 
> 
> It's not clear that the problem _can_ be solved in user space.
> 
> It's easy enough to say "never allocate more than a page". But it's often 
> not REALISTIC.
 >
> Very basic issue: the perfect is the enemy of the good. Claiming that 
> there is a "proper solution" is usually a total red herring. Quite often 
> there isn't, and the "paper over" is actually not papering over, it's 
> quite possibly the best solution there is.

Yeah *smallish* higher order allocations are fine, and we use them all the
time for things like stacks or networking.

But Aubrey (who somehow got removed from the cc list) wants to do order 9
allocations from userspace in his nommu environment. I'm just trying to be
realistic when I say that this isn't going to be robust and a userspace
solution is needed.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
