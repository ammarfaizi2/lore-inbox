Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbWD0Dg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWD0Dg3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 23:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWD0Dg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 23:36:29 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:16570 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964914AbWD0Dg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 23:36:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Qv+M+8COusswyspmIDc+lV1yHQgrCTGSo6cmDLuX6gplZLGu6qftp262dDfGGBoSoP4Oejfdw4fjzzLEgBIcD84WZ8em9L2e9Z5bM1TwTx1nobCGa4ObHWXpLS0WL9hDBapY586Fqto4N/99WUx3SjjaLn4XsObulxjhH7n+94w=  ;
Message-ID: <44503C34.3070901@yahoo.com.au>
Date: Thu, 27 Apr 2006 13:36:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Abu-Nassar <djanssen1@hotmail.com>
CC: linux-kernel@vger.kernel.org, karl.kiniger@med.ge.com
Subject: Re: Using remap_pfn_range causes system hang on app close in 2.6.15
 & up
References: <BAY101-F13D9FEC07E274B8565DD3BF4BC0@phx.gbl>
In-Reply-To: <BAY101-F13D9FEC07E274B8565DD3BF4BC0@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Abu-Nassar wrote:

>>
>> Nick Piggin wrote:
>> Well, I think I said it shouldn't oops like this... I don't think it
>> is particularly robust WRT error cases or concurrent page faults
>> (between mmap and ioctl).
>>
>> As we established earlier with a debug patch, the reason for the oops
>> is that VM_PFNMAP has been cleared from your vma->vm_flags for some
>> reason. This is causing the unmap code to mistakenly try to remove
>> reverse maps and refcounts from the struct pages.
>>
>> I don't know why VM_PFNMAP should be getting cleared. But if it
>> remains set then the oops should go away.
>
>
>
> As one of my tests, I manually added the VM_PFNMAP flag before calling 
> remap_pfn_range().  This did not resolve the issue.  Also, I checked 
> the kernel source (vanilla Fedora Core 5) and VM_PFNMAP is always 
> added inside remap_pfn_range() anyway, along with VM_IO & VM_RESERVED.


Yes, VM_PFNMAP is being removed after the remap_pfn_range.

> Note that the kernel oops I posted only happened rarely.  Most of the 
> time, the system completely froze immediately when the file descriptor 
> was closed and I didn't get any oops message.


Quite likely to do all sorts of weird stuff because it will attempt to free
these pages to the page allocator which may get allocated for kernel 
internal
use for example.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
