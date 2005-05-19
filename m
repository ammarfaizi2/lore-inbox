Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVESRJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVESRJx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 13:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVESRJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 13:09:53 -0400
Received: from alog0403.analogic.com ([208.224.222.179]:54407 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261171AbVESRJt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 13:09:49 -0400
Date: Thu, 19 May 2005 13:06:25 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Steven Rostedt <rostedt@goodmis.org>
cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org,
       "Gilbert, John" <JGG@dolby.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Adrian Bunk <bunk@stusta.de>, Arjan van de Ven <arjan@infradead.org>,
       "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: Illegal use of reserved word in system.h
In-Reply-To: <1116519739.4075.2.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0505191304540.31202@chaos.analogic.com>
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>
 <20050518195337.GX5112@stusta.de> <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
 <20050519112840.GE5112@stusta.de> <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>
 <1116505655.6027.45.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.61L.0505191342460.10681@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.61.0505190853310.29611@chaos.analogic.com> <jeacmr5mzk.fsf@sykes.suse.de>
 <1116512140.15866.42.camel@localhost.localdomain>
 <Pine.LNX.4.61.0505191024110.30237@chaos.analogic.com> <je64xf450i.fsf@sykes.suse.de>
 <Pine.LNX.4.61.0505191150070.30960@chaos.analogic.com>
 <1116519739.4075.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2005, Steven Rostedt wrote:

> On Thu, 2005-05-19 at 11:58 -0400, Richard B. Johnson wrote:
>
>>
>> 0 = 00000020
>> 1 = ffffe400
>> 2 = 00000021
>> 3 = ffffe000
>> 4 = 00000010	Seems to start here?
>> 5 = bfebfbff	Some bits
>> 6 = 00000006	AT_PAGESZ
>> 7 = 00001000	Correct
>> 8 = 00000011	AT_CLKTCK
>> 9 = 00000064	Correct
>> 10 = 00000003
>> 11 = 08048034
>> 12 = 00000004
>> 13 = 00000020
>> 14 = 00000005
>> 15 = 00000003
>>
>> Nothing that makes any sense with the extra stuff in front.
>> I don't know where it came from.
>>
>
> You forgot to include ARCH_DL_INFO which is defined in asm-i386/elf.h
> as:
>
> #define ARCH_DLINFO						\
> do {								\
> 		NEW_AUX_ENT(AT_SYSINFO,	VSYSCALL_ENTRY);	\
> 		NEW_AUX_ENT(AT_SYSINFO_EHDR, VSYSCALL_BASE);	\
> } while (0)
>
> AT_SYSINFO = 32 or 0x20  and AT_SYSINFO_EHDR = 33 or 0x21
>
> -- Steve

Okay, good. At least I have the right vector. Now to find
a clean way to use it. The whole idea was to not have to
use kernel headers, BTW.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
