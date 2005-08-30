Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVH3DQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVH3DQO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 23:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbVH3DQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 23:16:14 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:49498 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932110AbVH3DQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 23:16:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Vfo5LBUI1+TI32xtQoGtHQYicspz+5qJ6KQjYs2nNiLjm/qSFlLTc5bVmNRhTyMmipp4RG2pK8o5UZ2mwgho6oBja9OWSSHDJp2u+ueaHJz/Qi5o3Oa5Da14so2FE6LtFTNjo/5namB30okhuqzD8xjN6PpkINRHQDfpSYKTtQg=  ;
Message-ID: <4313CA1E.3000605@yahoo.com.au>
Date: Tue, 30 Aug 2005 12:53:18 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Sonny Rao <sonnyrao@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make radix tree gang lookup faster by using a bitmap
 search
References: <1125159996.5159.8.camel@mulgrave>	 <20050827105355.360bd26a.akpm@osdl.org> <1125276312.5048.22.camel@mulgrave>	 <20050828175233.61cada23.akpm@osdl.org> <1125278389.5048.30.camel@mulgrave>	 <20050828183531.0b4d6f2d.akpm@osdl.org> <1125285994.5048.40.camel@mulgrave>	 <4312830C.8000308@yahoo.com.au>	 <20050829164144.GC9508@localhost.localdomain>	 <4313AEC9.3050406@yahoo.com.au> <1125369981.5089.106.camel@mulgrave>
In-Reply-To: <1125369981.5089.106.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

>On Tue, 2005-08-30 at 10:56 +1000, Nick Piggin wrote:
>
>
>>Gang lookup is mainly used on IO paths but also on truncate,
>>which is a reasonably fast path on some workloads (James,
>>this is my suggestion for what you should test - truncate).
>>
>
>Actually, I don't think I can test this.  In order to show a difference
>between index 5 and index 6 on 32 bit, I'd have to deal with files > 4GB
>in size.  My 32 bit machines are the voyagers and only have 4GB discs.
>
>The machine with all the huge discs, is, naturally, ia64.
>
>

Sorry, I meant for testing your gang lookup speedups.

For testing regular lookups, yeah that's more difficult. For a
microbenchmark you can use sparse files, which can be a good
trick for testing pagecache performance without the IO.

Nick


Send instant messages to your online friends http://au.messenger.yahoo.com 
