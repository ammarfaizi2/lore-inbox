Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262524AbVESOke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbVESOke (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 10:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVESOkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 10:40:24 -0400
Received: from alog0469.analogic.com ([208.224.222.245]:45235 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262524AbVESOjw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 10:39:52 -0400
Date: Thu, 19 May 2005 10:36:17 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Steven Rostedt <rostedt@goodmis.org>
cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org,
       "Gilbert, John" <JGG@dolby.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Adrian Bunk <bunk@stusta.de>, Arjan van de Ven <arjan@infradead.org>,
       "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: Illegal use of reserved word in system.h
In-Reply-To: <1116512140.15866.42.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0505191024110.30237@chaos.analogic.com>
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>
 <20050518195337.GX5112@stusta.de> <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
 <20050519112840.GE5112@stusta.de> <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>
 <1116505655.6027.45.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.61L.0505191342460.10681@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.61.0505190853310.29611@chaos.analogic.com> <jeacmr5mzk.fsf@sykes.suse.de>
 <1116512140.15866.42.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2005, Steven Rostedt wrote:

> On Thu, 2005-05-19 at 16:06 +0200, Andreas Schwab wrote:
>> "Richard B. Johnson" <linux-os@analogic.com> writes:
>>
>>> Now, where is that 'auxiliary vevtor'??? I got a pointer to
>>> something to be executed before calling exit, I have an
>>> argument count, then a bunch of pointers (argv), terminating
>>> with a NULL, then another bunch of pointers (envp) terminating
>>> with a NULL.  Is there something after that??? If so, what's
>>> the contents of this thing?
>>
>> See create_elf_tables.  The aux table comes after the environment.
>
> As I stated earlier, the page size passed in there is ELF_EXEC_PAGESIZE
> which may not be the same as PAGE_SIZE.
>
> -- Steve

It's also hard to see what is happening in 'C'. When I execute
this:

#include <stdio.h>
#include <stdlib.h>

int main(int cnt, char *argv[], char *env[], char *aux[])
{
     printf("Aux 0 = %s\n", aux[0]);
//    printf("Aux 1 = %s\n", aux[1]);
}

I get:

Aux 0 = GLIBC_2.0

The next pointer is a NULL pointer, so 'C' has dorked something.
When I play in assembler, (crt.o startup) I get a pointer that
points to:

 	bffffb6c	- pointer of the stack
 	00000020	- dereferenced

This shows that ld-linux.so, that got called first, didn't
preserve the vector.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
