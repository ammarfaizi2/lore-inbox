Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbVESNEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbVESNEX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 09:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbVESNEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 09:04:23 -0400
Received: from alog0431.analogic.com ([208.224.222.207]:60308 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262484AbVESNEP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 09:04:15 -0400
Date: Thu, 19 May 2005 09:01:19 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: "Maciej W. Rozycki" <macro@linux-mips.org>
cc: Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Kyle Moffett <mrmacman_g4@mac.com>, "Gilbert, John" <JGG@dolby.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Illegal use of reserved word in system.h
In-Reply-To: <Pine.LNX.4.61L.0505191342460.10681@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.61.0505190853310.29611@chaos.analogic.com>
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net> 
 <20050518195337.GX5112@stusta.de>  <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
  <20050519112840.GE5112@stusta.de>  <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>
 <1116505655.6027.45.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.61L.0505191342460.10681@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2005, Maciej W. Rozycki wrote:

> On Thu, 19 May 2005, Arjan van de Ven wrote:
>
>>> First off, I think we need a system-call that will return some of
>>> the information that now comes from headers. PAGE_SIZE comes to
>>> mind. You need this for mmap() but there doesn't seem to be any
>>> way to get it. getpagesize() 'C' library just returns something
>>> it's swiped from kernel headers when the library was compiled.
>>> There are other things like the following that sometimes need
>>
>> for getpagesize() I can see the point
>
> If that is the case, then that's a bug in that C library, which should be
> reported and fixed.  When starting a program, i.e. as a result of
> execve(), Linux passes the current page size in use in the auxiliary
> vector.  That value should be retrieved and used by a C library for
> platforms that support various page sizes and returned by library calls
> like getconf().  For example glibc gets it right.
>
>  Maciej
>

Would you please explain 'auxiliary' vector???

According to the documentation, the following information
is passed to a program:

#
#   %edx        Contains a function pointer to be registered with `atexit'.
#               This is how the dynamic linker arranges to have DT_FINI
#               functions called for shared libraries that have been loaded
#               before this code runs.
#
#   %esp        The stack contains the arguments and environment:
#               (%esp)                  argc
#               4(%esp)                 argv[0]
#               ...
#               (4*argc)(%esp)          NULL
#               (4*(argc+1))(%esp)      envp[0]
#               ...
#                                       NULL
#

Now, where is that 'auxiliary vevtor'??? I got a pointer to
something to be executed before calling exit, I have an
argument count, then a bunch of pointers (argv), terminating
with a NULL, then another bunch of pointers (envp) terminating
with a NULL.  Is there something after that??? If so, what's
the contents of this thing?


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
