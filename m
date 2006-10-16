Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422649AbWJPPql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422649AbWJPPql (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbWJPPqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:46:40 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:34730 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161003AbWJPPqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:46:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=PDCAuVKsg3eWpyUev9s7wmJDN0EpFGS9lxjLhkikNGp3eFpEwAN/JJjRjrtSXb5klE1tQEwKstf4tu6RQNbHvaTeUO8yIl9XsBC9jK1es1qs1lzdR78WgwKnS4tlC8k7EVv1KBe42ZAz4vhnedjbF9Py8dPmHuaQ/mHdFB2omxk=  ;
Message-ID: <4533A95B.6080100@yahoo.com.au>
Date: Tue, 17 Oct 2006 01:46:35 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Randy Dunlap <rdunlap@xenotime.net>
CC: "alpha @ steudten Engineering" <alpha@steudten.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: INFO: possible circular locking dependency detected
References: <453391A4.5090100@steudten.org>	<4533980C.10403@yahoo.com.au> <20061016084255.10f133b6.rdunlap@xenotime.net>
In-Reply-To: <20061016084255.10f133b6.rdunlap@xenotime.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> On Tue, 17 Oct 2006 00:32:44 +1000 Nick Piggin wrote:
> 
> 
>>alpha @ steudten Engineering wrote:
>>
>>>=======================================================
>>>[ INFO: possible circular locking dependency detected ]
>>>2.6.18-1.2189self #1
>>>-------------------------------------------------------
>>>kswapd0/186 is trying to acquire lock:
>>> (&inode->i_mutex){--..}, at: [<c0326e32>] mutex_lock+0x21/0x24
>>>
>>>but task is already holding lock:
>>> (iprune_mutex){--..}, at: [<c0326e32>] mutex_lock+0x21/0x24
>>>
>>>which lock already depends on the new lock.
>>
>>Thanks. __grab_cache_page wants to clear __GFP_FS, because it is
>>holding the i_mutex so we don't want to reenter the filesystem in
>>page reclaim.
>>
>>This would be an easy two liner, except those funny page_cache_alloc
>>routines which take a mapping rather than a gfp_t argument :P
> 
> 
> and it would be only one email, but you forgot spaces there,
> so it's too ugly to use.  ;)  i.e., please add spaces around
> the '&'.
> 
> and it's an attachment :(

Oh yeah, it was an attachment because I didn't want anyone to see how
ugly it is ;)

It's just a quick hack to see if it works. I'll send out a real patch
when I get time to code and test it properly.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
