Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVESQG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVESQG0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 12:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbVESQG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 12:06:26 -0400
Received: from alog0180.analogic.com ([208.224.220.195]:34723 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261432AbVESQF4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 12:05:56 -0400
Date: Thu, 19 May 2005 12:03:02 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Steven Rostedt <rostedt@goodmis.org>
cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org,
       "Gilbert, John" <JGG@dolby.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Adrian Bunk <bunk@stusta.de>, Arjan van de Ven <arjan@infradead.org>,
       "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: Illegal use of reserved word in system.h
In-Reply-To: <1116518193.27471.10.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0505191200510.30960@chaos.analogic.com>
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>
 <20050518195337.GX5112@stusta.de> <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
 <20050519112840.GE5112@stusta.de> <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>
 <1116505655.6027.45.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.61L.0505191342460.10681@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.61.0505190853310.29611@chaos.analogic.com> <jeacmr5mzk.fsf@sykes.suse.de>
 <1116512140.15866.42.camel@localhost.localdomain>
 <Pine.LNX.4.61.0505191024110.30237@chaos.analogic.com> <je64xf450i.fsf@sykes.suse.de>
 <1116518193.27471.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2005, Steven Rostedt wrote:

> On Thu, 2005-05-19 at 17:19 +0200, Andreas Schwab wrote:
>> "Richard B. Johnson" <linux-os@analogic.com> writes:
>>
>>> It's also hard to see what is happening in 'C'. When I execute
>>> this:
>>>
>>> #include <stdio.h>
>>> #include <stdlib.h>
>>>
>>> int main(int cnt, char *argv[], char *env[], char *aux[])
>>> {
>>>     printf("Aux 0 = %s\n", aux[0]);
>>> //    printf("Aux 1 = %s\n", aux[1]);
>>> }
>>
>> There is no pointer to the aux table passed to main, you have to skip past
>> the environment.  Also, the aux table is an array of key/value pairs.
>>
>>> This shows that ld-linux.so, that got called first, didn't
>>> preserve the vector.
>>
>> It does.
>>
>
> Here's a simple program to show you your pages size ;-), Now I don't
> know enough about the elfinfo size and such to make this a real program,
> but it should at least prove a point!
>
> #include <stdio.h>
>
> int main(int argc, char **argv, char **env)
> {
>        int i;
>        long *p;
>
>        for (i=0; env[i]; i++);
>        p = (long*)(&env[i+1]);
>        for (i=0; i < 10; i++) {
>                long type = *p++;
>                if (type == 6)
>                        printf("pagesz = 0x%lx (%ld)\n",*p,*p);
>                p++;
>        }
>
>        return 0;
> }
>
> -- Steve

Well this just shows that the table is somewhere on the stack
after the environment.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
