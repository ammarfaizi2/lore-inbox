Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751668AbWEaQWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbWEaQWn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 12:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbWEaQWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 12:22:43 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:51827 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751635AbWEaQWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 12:22:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=lxk/oyKqxlmXHSmT8h71voJblvZ29YqR8j3r2rDGG66i+l8drORCm7sFM29zafeE3VKvBqLITurklNII8MlcJ7lcRW9IjZeB9XHqd7y5eFR0WQM/BEze3KjWZ5nvAjvudG8OOvJRBPaRtqOHy2rR7XEPlA759lmfZoR6PrGIYkI=  ;
Message-ID: <447DC2CC.5060900@yahoo.com.au>
Date: Thu, 01 Jun 2006 02:22:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org> <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org> <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org> <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au> <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org> <447CE43A.6030700@yahoo.com.au> <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org> <447D9A41.8040601@yahoo.com.au> <Pine.LNX.4.64.0605310740530.24646@g5.osdl.org> <447DAEDE.5070305@yahoo.com.au> <Pine.LNX.4.64.0605310809250.24646@g5.osdl.org> <447DB765.6030702@yahoo.com.au> <Pine.LNX.4.64.0605310840000.24646@g5.osdl.org> <447DC22C.5070503@yahoo.com.au>
In-Reply-To: <447DC22C.5070503@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Linus Torvalds wrote:
> 
>> Tell me WHERE you can unplug in that sequence. I will tell you where 
>> you can NOT unplug:
> 
> 
> ...
> 
>>  - you can NOT just unplug in the path _after_ "readpage()", because 
>> the    IO may have been started by SOMEBODY ELSE that just did 
>> read-ahead, and    didn't unplug (on _purpose_ - the whole point of 
>> doing read-ahead is to    allow concurrent IO execution, so a 
>> read-aheader that unplugs is broken    by definition)
> 
> 
> Umm, this happens with the current lock_page() after readpage. And
> with per-task plugs, you do not unplug anybody else.

If this wasn't clear: I don't mean per-task plugs as in "the task
explicitly plugs and unplugs the block device"[*]; I mean really
per-task plugs.

[*] That would be crazy anyway because that would imply some random
     task can plug an filled request queue that is going full tilt.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
