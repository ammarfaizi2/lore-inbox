Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965272AbWGJWXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965272AbWGJWXY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965274AbWGJWXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:23:23 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:33195 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965272AbWGJWXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:23:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=vJVNx+9aFdSmmtxrry30NER9pFQy1iJKWWAWCIc2TLOnDHcmM15JMzMdCMCKubf/mG8O0IK+B2I1JTWTMsOkZqYp20noBGYDOHPpa4aJnGd+mtfnI6y3BjE24dQUG1xAUX++iOmRLvOVlnkFYL/4UyTLsc8MJUPJ2nDycClJSHs=  ;
Message-ID: <44B29461.40605@yahoo.com.au>
Date: Tue, 11 Jul 2006 03:54:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Joshua Hudson <joshudson@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [OT] 'volatile' in userspace
References: <44B0FAD5.7050002@argo.co.il>	 <MDEHLPKNGKAHNMBLJOLKMEPGNAAB.davids@webmaster.com>	 <20060709195114.GB17128@thunk.org> <20060709204006.GA5242@nospam.com>	 <20060710034250.GA15138@thunk.org> <bda6d13a0607101000w6ec403bbq7ac0fe66c09c6080@mail.gmail.com>
In-Reply-To: <bda6d13a0607101000w6ec403bbq7ac0fe66c09c6080@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Hudson wrote:
>>
>> So this would tend to confirm the rule of thumb: use of "volatile" in
>> a userspace progam tends to indicate a bug.
>>
>>                                                 - Ted
> 
> 
> No. vfork(), setjmp(), signal().
> 
> Yes, I use vfork. So far, the only way I have found for the parent to
> know whether or not the child's exec() failed is this way:
> 
> volatile int failed;
> pid_t pid;
> 
> failed = 0;
> if (0 == (pid = vfork())) {
>   execve(argv[0], argv, envp);
>   failed = errno;
>   _exit(0);
> }
> if (pid < 0) {
>   /* can't fork */
> }
> if (failed) {
>   /* wait for pid (clean up zombie) */
>   errno = failed;
>   /* can't exec: update state */
> }

May not be portable because you're apparently not supposed to assume
anything about the memory sharing semantics (eg. it may share memory
or it may not -- AFAIK if your code doesn't work correctly after
replacing vfork with fork, then it is buggy).

What's wrong with _exit(exec() == -1 ? 0 : errno);
and picking up the status with wait(2) ?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
