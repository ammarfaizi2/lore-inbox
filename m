Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263671AbUFFOZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263671AbUFFOZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 10:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbUFFOZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 10:25:28 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:39353 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263671AbUFFOZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 10:25:21 -0400
Message-ID: <40C32A44.6050101@elegant-software.com>
Date: Sun, 06 Jun 2004 10:29:24 -0400
From: Russell Leighton <russ@elegant-software.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: clone() <-> getpid() bug in 2.6?
References: <40C1E6A9.3010307@elegant-software.com> <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have read the discussion on this issue and I wanted to get 
confirmation of my understanding...

Issue:
    It seems glibc is caching getpid() which is wrong and breaks 
programs like mine.

    You are using an older version of  glibc than I and that is why you 
could run the test program.

Given the above, that means that:
    Upgrading my kernel on the FedoraCore2 system won't help because the 
bug is in glibc

    Assuming that this is a "new" feature of glibc, any others upgrading 
would then starting seeing this bug

Linus Torvalds wrote:

>On Sat, 5 Jun 2004, Russell Leighton wrote:
>  
>
>>I have a test program (see attached) that shows what looks like a bug in 
>>2.6.5-1.358 (FedoraCore2)...and breaks my program :(
>>
>>In summary, I am doing:
>>
>> clone(run_thread, stack + sizeof(stack) -1,
>>            CLONE_FS|CLONE_FILES|CLONE_VM|SIGCHLD, NULL))
>>
>>According to the man page the child process should have its own pid as 
>>returned by getpid()...much like fork().
>>
>>In 2.6 the child receives the parent's pid from getpid(), while 2.4 
>>works as documented:
>>
>>In 2.4 the test program does:
>> parent pid: 26647
>> clone returned pid: 26648
>> thread reported pid: 26648
>>
>>In 2.6 the test program does:
>> parent pid: 16665
>> thread reported pid: 16665
>> clone returned pid: 16666
>>    
>>
>
>Hmm.. The above is the correct behaviour if you use CLONE_THREAD 
>("getpid()" will then return the _thread_ ID), but it shouldn't happen 
>without that. And clearly you don't have it set.
>
>And indeed, it doesn't happen for me on my system:
>
>	parent pid: 13552
>	thread reported pid: 13553
>	clone returned pid: 13553
>
>so I wonder if either the Fedora libc always adds that CLONE_THREAD thing
>to the clone() calls, or whether the FC2 kernel is buggy.
>
>Arjan?
>
>		Linus
>
>
>  
>

