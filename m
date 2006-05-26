Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbWEZDdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWEZDdN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 23:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWEZDdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 23:33:13 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:60799 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030204AbWEZDdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 23:33:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=SEoK2KarVvNEgFhZ8Sbu4aqqpJxYLalTYy6Y+ssrotRb+HDWaQSsHUwyLgsUHiBtN1/dyBbglGak2AP53ipMixwkbK/ETuQhM6yeNvdwmPgV7QZY2A86KdNPMXan7mIPpURS8Oa/LXCppVmakrhR+TW17rTKCrx2eA3kUpnByVA=  ;
Message-ID: <447676F4.7090503@yahoo.com.au>
Date: Fri, 26 May 2006 13:33:08 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050831 Debian/1.7.8-1sarge2
X-Accept-Language: en
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/33] readahead: common macros
References: <20060524111246.420010595@localhost.localdomain> <348469539.42623@ustc.edu.cn> <44754708.5090406@yahoo.com.au> <348553673.03597@ustc.edu.cn>
In-Reply-To: <348553673.03597@ustc.edu.cn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang wrote:

>On Thu, May 25, 2006 at 03:56:24PM +1000, Nick Piggin wrote:
>
>>>+#define PAGES_BYTE(size) (((size) + PAGE_CACHE_SIZE - 1) >> 
>>>PAGE_CACHE_SHIFT)
>>>+#define PAGES_KB(size)	 PAGES_BYTE((size)*1024)
>>>
>>>
>>Don't really like the names. Don't think they do anything for clarity, but
>>if you can come up with something better for PAGES_BYTE I might change my
>>mind ;) (just forget about PAGES_KB - people know what *1024 means)
>>
>
>No, they are mainly for concision. Don't you think it's cleaner to write
>        PAGES_KB(VM_MAX_READAHEAD)
>than
>        (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE
>
>

No. Apart from semantics being different (which I'll address below), anybody
with any business looking at this code will immediately know and understand
what the latter line means. Not so for the former.

>Admittedly the names are somewhat awkward though :)
>
>
>>Also: the replacements are wrong: if you've defined VM_MAX_READAHEAD to be
>>4095 bytes, you don't want the _actual_ readahead to be 4096 bytes, do you?
>>It is saying nothing about minimum, so presumably 0 is the correct choice.
>>
>
>The macros were first introduced exact for this reason ;)
>
>It is rumored that there will be 64K page support, and this macro
>helps round up the 16K sized VM_MIN_READAHEAD. The eof_index also
>needs rounding up.
>

But VM_MIN_READAHEAD of course should be rounded up, for the same
reasons I said VM_MAX_READAHEAD should be rounded down.

So OK as a bug fix, but it needs to be in its own patch, not in a "common
macros" one, and sufficiently commented (and preferably outside your core
adaptive readahead code so it can be quickly merged up)

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
