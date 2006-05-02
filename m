Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWEBWJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWEBWJy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 18:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWEBWJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 18:09:54 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:40635 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932242AbWEBWJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 18:09:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=mTsihCTd99WTTA8exLY98UFxVq8SszG25qtSst9m8Zk3Z1knqX+Iz4+ztFTo17cs4VtrIfOfJs/KbYzpVdHq/0pIuAvKxq1PHO4BUBE5kP30urV4y8PSasUrfoNsNafMViSmhwm9F0eXWtEx/I8SE6EWxwAyhvFO4CLNmDFVXUQ=  ;
Message-ID: <44574E49.3030600@yahoo.com.au>
Date: Tue, 02 May 2006 22:19:21 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: blaisorblade@yahoo.it, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 00/14] remap_file_pages protection support
References: <20060430172953.409399000@zion.home.lan> <4456D5ED.2040202@yahoo.com.au> <4456D85E.6020403@yahoo.com.au> <20060502112409.GA28159@elte.hu>
In-Reply-To: <20060502112409.GA28159@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> originally i tested this feature with some minimal amount of RAM 
> simulated by UML 128MB or so. That's just 32 thousand pages, but still 
> the improvement was massive: context-switch times in UML were cut in 
> half or more. Process-creation times improved 10-fold. With this feature 
> included I accidentally (for the first time ever!) confused an UML shell 
> prompt with a real shell prompt. (before that UML was so slow [even in 
> "skas mode"] that you'd immediately notice it by the shell's behavior)

Cool, thanks for the numbers.

> 
> the 'have 1 vma instead of 32,000 vmas' thing is a really, really big 
> plus. It makes UML comparable to Xen, in rough terms of basic VM design.
> 
> Now imagine a somewhat larger setup - 16 GB RAM UML instance with 4 
> million vmas per UML process ... Frankly, without 
> sys_remap_file_pages_prot() the UML design is still somewhat of a toy.

Yes, I guess I imagined the common case might have been slightly better,
however with reasonable RAM utilisation, fragmentation means I wouldn't
be surprised if it does easily get close to that worst theoretical case.

My request for numbers was more about the Intel/glibc people than Paolo:
I do realise it is a problem for UML. I just like to see nice numbers :)

I think UML's really neat, so I'd love to see this get in. I don't see
any fundamental sticking point, given a few iterations, and some more
discussion.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
