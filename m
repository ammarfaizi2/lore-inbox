Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbTIHMB7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 08:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbTIHMB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 08:01:59 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:56732 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S261835AbTIHMB4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 08:01:56 -0400
Message-ID: <3F5C7009.4030004@softhome.net>
Date: Mon, 08 Sep 2003 14:03:21 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: nasm over gas?
References: <rZQN.83u.21@gated-at.bofh.it> <saVL.7lR.1@gated-at.bofh.it> <soFo.16a.1@gated-at.bofh.it> <ssJa.6M6.25@gated-at.bofh.it> <tcVB.rs.3@gated-at.bofh.it>
In-Reply-To: <tcVB.rs.3@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> insecure <insecure@mail.od.ua> writes:
>>        movl    $0, 20(%esp)
>>        movl    $1000000, %edi      <----
>>        movl    $1000000, 16(%esp)  <----
>>        movl    $0, 12(%esp)
>>
>>No sane human will do that.
>>main:
>>        movl    $1000000, %edi
>>        movl    %edi, 16(%esp)	<-- save 4 bytes
>>        movl    %ebp, 12(%esp)  <-- save 4 bytes
>>        movl    $.LC27, 8(%esp)
>>
>>And this is only from a cursory examination.
> 
> Actually it is no as simple as that.  With the instruction that uses
> %edi following immediately after the instruction that populates it you cannot
> execute those two instructions in parallel.  So the code may be slower.  The
> exact rules depend on the architecture of the cpu.
> 

   It will depend on arch CPU only in case if you have unlimited i$ size.
   Servers with 8MB of cache - yes it is faster.
   Celeron with 128k of cache - +4bytes == higher probability of i$ miss 
== lower performance.

> 
>>What gives you an impression that anyone is going to rewrite linux in asm?
>>I _only_ saying that compiler-generated asm is not 'good'. It's mediocre.
>>Nothing more. I am not asm zealot.
> 
> 
> I think I would agree with that statement most compiler-generated assembly
> code is mediocre in general.  At the same time I would add most human
> generated assembly is poor, and a pain to maintain.
> 
> If you concentrate on those handful of places where you need to
> optimize that is reasonable.  Beyond that there simply are not the
> developer resources to do good assembly.  And things like algorithmic
> transformations in assembly are an absolute nightmare.  Where they are
> quite simple in C.
> 
> And if the average generated code quality bothers you enough with C
> the compiler can be fixed, or another compiler can be written that
> does a better job, and the benefit applies to a lot more code.
> 

   e.g. C-- project: something like C, where you can operate with 
registers just like another variables. Under DOS was producing .com 
files witout any overhead: program with only 'int main() { return 0; }' 
was optimized to one byte 'ret' ;-) But sure it was not complete C 
implementation.

   Sure I would prefere to have nasm used for kernel asm parts - but 
obviously gas already became standard.

P.S. Add having good macroprocessor for assembler is a must: CPP is 
terribly stupid by design. I beleive gas has no preprocessor comparable 
to masm's one? I bet they are using C's cpp. This is degradation: macros 
is the major feature of any translator I was working with. They can save 
you a lot of time and make code much more cleaner/readable/mantainable. 
CPP is just too dumb for asm...
Good old times, when people were responsible to _every_ byte of their 
programmes... Yeh... Memory/programmers are cheap nowadays...

