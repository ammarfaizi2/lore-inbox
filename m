Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272134AbSISR76>; Thu, 19 Sep 2002 13:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272139AbSISR76>; Thu, 19 Sep 2002 13:59:58 -0400
Received: from quark.didntduck.org ([216.43.55.190]:775 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S272134AbSISR74>; Thu, 19 Sep 2002 13:59:56 -0400
Message-ID: <3D8A11BB.4090100@didntduck.org>
Date: Thu, 19 Sep 2002 14:04:43 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: "Richard B. Johnson" <root@chaos.analogic.com>, dvorak <dvorak@xs4all.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
References: <24181C771D3@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> On 19 Sep 02 at 13:22, Richard B. Johnson wrote:
> 
> 
>>>>>A short snippet of sys_poll, with irrelavant data removed.
>>>>>
>>>>>sys_poll(struct pollfd *ufds, .. , ..) {
>>>>>   ...
>>>>>   ufds++;
>>>>>   ...
>>>>
>>Well which one?  Here is an ioctl(). It certainly modifies one
>>of its parameter values.
> 
> 
> poll(), as was already noted. Program below should
> print same value for B= and F=, but it reports f + 8*c instead
> (where c = number of filedescriptors passed to poll).
> 
> And you must call it from assembly, as your calls to getpid() or
> ioctl() (or poll()) are wrapped in libc - and glibc's code begins with
> push %ebx because of %ebx is used by -fPIC code.
> 
> It is questinable whether we should try to not modify parameters
> passed into functions. It is definitely nice behavior, but I think
> that we should only guarantee that syscalls do not modify unused
> registers.
>                                                     Petr Vandrovec
>                                                     vandrove@vc.cvut.cz

Now that I've thought about it more, I think the best solution is to go 
through all the syscalls (a big job, I know), and declare the parameters 
as const, so that gcc knows it can't modify them, and will throw a 
warning if we try.

--
				Brian Gerst


