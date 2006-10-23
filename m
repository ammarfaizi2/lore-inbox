Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751852AbWJWJNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbWJWJNX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 05:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbWJWJNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 05:13:23 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:13962 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751852AbWJWJNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 05:13:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=FmepfrgaU5/0BCWnp3pKEiHVaxbuZx7EdfiqJ/avqop50+LHWQ1EXw0LYqZPPD+gbHhW8MtLznVwEJxciXDENB5QsXobhCJUrMOKlmkK7v5jXkMINUz5VtgEYFRfDEHSD8gYlA5kIzWSzltvppPMRd1R+Y/QZ6SrGlawWNDZiDw=  ;
Message-ID: <453C87A6.4060602@yahoo.com.au>
Date: Mon, 23 Oct 2006 19:13:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmalloc : optimization, cleanup, bugfixes
References: <453C3A29.4010606@intel.com> <20061022214508.6c4f30c6.akpm@osdl.org> <200610231036.10418.dada1@cosmosbay.com>
In-Reply-To: <200610231036.10418.dada1@cosmosbay.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
> [PATCH] vmalloc : optimization, cleanup, bugfixes
> 
> This patch does three things
> 
> 1) reorder 'struct vm_struct' to speedup lookups on CPUS with small cache 
> lines. The fields 'next,addr,size' should be now in the same cache line, to 
> speedup lookups.
> 
> 2) One minor cleanup in __get_vm_area_node()
> 
> 3) Bugfixes in vmalloc_user() and vmalloc_32_user()
> NULL returns from __vmalloc() and __find_vm_area() were not tested.

Hmm, so they weren't. As far as testing the return of __find_vm_area,
you can just turn that into a BUG_ON(!area), because at that point,
we've established that the vmalloc succeeded.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
