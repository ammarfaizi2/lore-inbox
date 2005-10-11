Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbVJKNj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbVJKNj0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 09:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVJKNjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 09:39:25 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:51805 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750883AbVJKNjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 09:39:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=MguW/qttmHDEV310DdeeC3ZE1V4N/iv7JqpeFnNjSDhNvX3UwatnqJxoewmouEzfo3NipSKmqqGZe4+jA3cBNTJ/CsWWOgHgXnvC2NSVCTofDXbbWmLT8FDZSyTkWTdBq1pQukXIzKyBJESCrH9I5MysA2P9MkSuDGEra7J2sco=  ;
Message-ID: <434BC095.4050305@yahoo.com.au>
Date: Tue, 11 Oct 2005 23:39:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050914 Debian/1.7.11-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.14-rc2-mm2] core remove PageReserved
References: <434B7F19.5040808@yahoo.com.au> <1129035883.23677.48.camel@localhost.localdomain>
In-Reply-To: <1129035883.23677.48.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2005-10-11 at 19:00 +1000, Nick Piggin wrote:
> 
>>A last caveat: the ZERO_PAGE is now refcounted and managed with rmap
>>(and thus mapcounted and count towards shared rss).
> 
> 
> 32000 processes each with 2G mapped as zero pages appears to allow the
> refcount to overflow ?
> 

That's right (though I count only 8192 required with 4K page size) -
close to impossible on 32-bit architectures, though not so the 64-bit
ones, which still use 32-bits for count and mapcount.

I was a bit worried about this too, but Hugh didn't think it was a
really big a deal - I guess because the real solution for the refcount
overflow on 64-bit is to expand the refcount type.

Note also that we can exclude ZERO_PAGE from being refcounted, which
may be desirable for a scalability perspective on big NUMA machines.

The aim with this patch is to provide a patch which is as simple as
possible in order to get the mechanism right. But you raise a valid
concern and we do need to discuss these peripheral issues and sort
them out before it gets merged upstream.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
