Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161046AbVKDA45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161046AbVKDA45 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbVKDA4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:56:55 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:51571 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1161038AbVKDA4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:56:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=fEbtE3IW5uyz3p5YCnoxzt4owmhODg098oPQ57ibYOY7ERrrx27YbhXix+cEmAycf4022CqBqDu2QFdb6Xz++ismUYM2u6+wKhUjVorKsDsoLOP3EFLHwmneZ5Dx9I5MKIA0af7Rwut4Ry0KmylUvSDSapAjRAXxDCuCxliPzlo=  ;
Message-ID: <436AB241.2030403@yahoo.com.au>
Date: Fri, 04 Nov 2005 11:58:41 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Mel Gorman <mel@csn.ul.ie>, Dave Hansen <haveblue@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <4366C559.5090504@yahoo.com.au> <4366D469.2010202@yahoo.com.au> <Pine.LNX.4.58.0511011014060.14884@skynet><20051101135651.GA8502@elte.hu> <1130854224.14475.60.camel@localhost><20051101142959.GA9272@elte.hu> <1130856555.14475.77.camel@localhost><20051101150142.GA10636@elte.hu> <1130858580.14475.98.camel@localhost><20051102084946.GA3930@elte.hu> <436880B8.1050207@yahoo.com.au><1130923969.15627.11.camel@localhost> <43688B74.20002@yahoo.com.au><255360000.1130943722@[10.10.2.4]> <4369824E.2020407@yahoo.com.au> <306020000.1131032193@[10.10.2.4]> <1131032422.2839.8.camel@laptopd505.fenrus.org>  <Pine.LNX.4.64.0511030747450.27915@g5.osdl.org> <Pine.LNX.4.58.0511031613560.3571@skynet>  <Pine.LNX.4.64.0511030842050.27915@g5.osdl.org> <309420000.1131036740@[10.10.2.4]>  <Pine.LNX.4.64.0511030918110.27915@g5.osdl.org> <311050000.1131040276@[10.10.2.4]> <1131040786.2839.18.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0511031006550.27915@g5.osdl.org> <312300000.1131041824@[10.10.2.4]>
In-Reply-To: <312300000.1131041824@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:

>>These days we have things like per-cpu lists in front of the buddy 
>>allocator that will make fragmentation somewhat higher, but it's still 
>>absolutely true that the page allocation layout is _not_ random.
> 
> 
> OK, well I'll quit torturing you with incorrect math if you'll concede
> that the situation gets much much worse as memory sizes get larger ;-)
> 

Let me add that as memory sized get larger, people are also looking
for more tlb coverage and less per page overhead.

Looks like ppc64 is getting 64K page support, at which point higher
order allocations (eg. for stacks) basically disappear don't they?

x86-64 I thought were also getting 64K page support but I can't
find a reference to it right now - at the very least I know Andi
wants to support larger soft pages for it.

ia64 is obviously already well covered.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
