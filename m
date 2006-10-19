Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423255AbWJSGae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423255AbWJSGae (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 02:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161335AbWJSGae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 02:30:34 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:848 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161334AbWJSGad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 02:30:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=NyDZ4ZCXVEPOFup5CTakPTQEZ/B4c5AOTzGEJQMIQlFeUVEg+J8RA96s4JgSZD3PLdP0lZ2DUJ1x31Sdd9uv3yS1nkcgE5lCcbTujUImAMsWSM5lC3AmUKUUOyNpH4cl3A9Ue/E3RxXGLURZmXWKd3EAdAlcB01uMjSxrsgsTT0=  ;
Message-ID: <45371B80.7060007@yahoo.com.au>
Date: Thu, 19 Oct 2006 16:30:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "alpha @ steudten Engineering" <alpha@steudten.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: INFO: possible circular locking dependency detected
References: <453391A4.5090100@steudten.org>	<4533980C.10403@yahoo.com.au> <20061018230243.6b40e8e8.akpm@osdl.org>
In-Reply-To: <20061018230243.6b40e8e8.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 17 Oct 2006 00:32:44 +1000
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
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
> 
> 
> We want to be able to enter page reclaim while holding i_mutex.  Think what
> the effect of not doing this would be upon write() (!)
> 
> This warning is more fallout from ntfs's insistence on taking i_mutex in
> its clear_inode().  See lengthy and unproductive discussion at
> http://lkml.org/lkml/2006/7/26/185 .

Yeah you're right. It will be a hot allocation + reclaim path for high
bandwidth writes.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
