Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262613AbVBYAOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbVBYAOU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 19:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbVBYALM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 19:11:12 -0500
Received: from 78.Red-217-126-86.pooles.rima-tde.net ([217.126.86.78]:62699
	"EHLO pcecito.jbrinx.dyndns.org") by vger.kernel.org with ESMTP
	id S262611AbVBYAG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 19:06:27 -0500
Message-ID: <421E6B84.606@gmail.com>
Date: Fri, 25 Feb 2005 01:04:20 +0100
From: =?ISO-8859-1?Q?Jordi_Br=EDnquez?= <jordi.brinquez@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: ca, es-es, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Possible bug on signal.h
References: <61d439b050224063362ab1465@mail.gmail.com> <Pine.LNX.4.61.0502240953470.14909@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0502240953470.14909@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to modify UML so I'm using kernel headers

but anyway there is a problem on sigaction definition on signal.h

Jordi



linux-os wrote:

> On Thu, 24 Feb 2005, Jordi Brinquez wrote:
>
>> Hi,
>>
>> I think I found a possible bug on file signal.h.
>>
>> The problem comes when you define a struct sigaction on a user program
>> and then you use the function sigaction to remap a signal handler (in
>> my case a page_fault) for my own function, this system call is
>> compiled as __NR_sigaction system call (by default this routine is
>> managed by sys_sigaction routine) and if the architecture defines
>> __ARCH_WANT_SYS_RT_SIGACTION kernel uses the routine sys_rt_sigaction
>> on the file kernel/signal.c that instead of copying the fields from
>> one structure to the other it just uses copy_from_user and
>> copy_to_user with the consequent mess with the fields.
>>
>
> You NEVER use kernel headers for user code.... EVER. If you
> are making something strange, like as you said a page-fault
> handler, then you make an in-kernel driver (module).
>
> FYI, no page-fault handler could ever work in user-mode
> anyway. A page-fault occurs because the user accesses some
> page it doesn't own (probably because it isn't in memory).
> The kernel page-fault handler checks to see if the page was
> promised. If not, it terminates the user-mode task with
> a signal. If so, it finds some free page or makes one
> available and maps it into the user's address-space before
> returning control to the user. Since the user doesn't own
> any free pages, it can't map in any.
>
>
> [SNIPPED...]
>
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
>  Notice : All mail here is now cached for review by Dictator Bush.
>                  98.36% of all statistics are fiction.
>
