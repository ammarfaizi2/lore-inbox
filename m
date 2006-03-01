Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWCADat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWCADat (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 22:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWCADat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 22:30:49 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:49515 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750756AbWCADas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 22:30:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=mJM+3+K+YNrJeXnORcSV6YPJjPNvZnNwg7p0dU6F/zaG0hnMIBbtnY9Q2qaAGMCf+tSNLAwT0a3+9PQ3yAnlEvikEhiFH8SvB7XjJZ79vU590x9KIZzbW1FfbPICiNwjrj4mNjXJj2+xBmPP1+uzEoMaEQbvMm60ASqNxFiVCIU=  ;
Message-ID: <44051562.8070708@yahoo.com.au>
Date: Wed, 01 Mar 2006 14:30:42 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: michal.k.k.piotrowski@gmail.com, linux-kernel@vger.kernel.org,
       rml@novell.com
Subject: Re: 2.6.16-rc5-mm1
References: <20060228042439.43e6ef41.akpm@osdl.org>	<6bffcb0e0602280701h1d5cbeaar@mail.gmail.com>	<6bffcb0e0602280820ic87332k@mail.gmail.com>	<440503E5.1070100@yahoo.com.au>	<20060228184450.dd831456.akpm@osdl.org>	<4405108B.4050701@yahoo.com.au> <20060228192115.473673ab.akpm@osdl.org>
In-Reply-To: <20060228192115.473673ab.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>Andrew Morton wrote:
>>
>>>Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>>>
>>>
>>>>>>Feb 28 15:13:42 ltg01-sid kernel: BUG: warning at
>>>>>>/usr/src/linux-mm/fs/inotify.c:533/inotify_d_instantiate()
>>>>>>Feb 28 15:13:42 ltg01-sid kernel:  [show_trace+13/15] show_trace+0xd/0xf
>>>>>>Feb 28 15:13:42 ltg01-sid kernel:  [dump_stack+21/23] dump_stack+0x15/0x17
>>>>>>Feb 28 15:13:42 ltg01-sid kernel:  [inotify_d_instantiate+47/98]
>>>>>>inotify_d_instantiate+0x2f/0x62
>>>>>>Feb 28 15:13:42 ltg01-sid kernel:  [d_instantiate+70/114]
>>>>>>d_instantiate+0x46/0x72
>>>>>>Feb 28 15:13:42 ltg01-sid kernel:  [ext3_add_nondir+44/64]
>>>>>>ext3_add_nondir+0x2c/0x40
>>>>>>Feb 28 15:13:42 ltg01-sid kernel:  [ext3_link+163/217] ext3_link+0xa3/0xd9
>>>>>>Feb 28 15:13:42 ltg01-sid kernel:  [vfs_link+292/379] vfs_link+0x124/0x17b
>>>>>>Feb 28 15:13:42 ltg01-sid kernel:  [sys_linkat+157/218] sys_linkat+0x9d/0xda
>>>>>>Feb 28 15:13:42 ltg01-sid kernel:  [sys_link+20/25] sys_link+0x14/0x19
>>>>>>Feb 28 15:13:42 ltg01-sid kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
>>>>>>
>>>>>>Here is dmesg http://www.stardust.webpages.pl/files/mm/2.6.16-rc5-mm1/mm-dmesg
>>>>>>Here is config http://www.stardust.webpages.pl/files/mm/2.6.16-rc5-mm1/mm-config
>>>>>
>>>>>
>>>>>This patch is causing that warning
>>>>>inotify-lock-avoidance-with-parent-watch-status-in-dentry.patch
>>>>>
>>>>
>>>>The warning is harmless really. I guess it can be removed.
>>>
>>>
>>>?    How did DCACHE_INOTIFY_PARENT_WATCHED get set on that dentry?
>>>
>>
>>I guess it is because I don't clear it on +ve => -ve conversions.
>>We _could_ do that AFAIKS, by hooking into d_delete, but it would
>>have to be yet another fsnotify hook there because it will have to
>>be done under lock.
>>
> 
> 
> How could a -ve dentry become the source of a link?  We should be sure we
> know why this happened before ignoring it..
> 

The source of a link? That wouldn't get d_instantiate called on it, would it?
I figured this was the destination.

I can reproduce a similar looking oops by unlinking a PARENT_WATCHED file, then
touching it again.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
