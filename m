Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266679AbUI0LSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266679AbUI0LSt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 07:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266683AbUI0LSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 07:18:49 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:14642
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S266679AbUI0LSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 07:18:44 -0400
Message-Id: <s1580520.021@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Mon, 27 Sep 2004 13:19:24 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <ak@muc.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: i386 entry.S problems
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@muc.de> 27.09.04 12:58:57 >>>
>"Jan Beulich" <JBeulich@novell.com> writes:
>>
>> I don't think so. Otherwise, why would arch/i386/Makefile
specifically
>> deal with this situation?
>
>It shouldn't be enabled for 2.95, there are known miscompilations
>caused by it there.  The i386 Makefile enforces this:
>
>cflags-$(CONFIG_REGPARM) 	+= $(shell if [ $(GCC_VERSION) -ge 0300
] ; then echo "-mregparm=3"; fi ;)

But that is exactly what I'm trying to account for: As we appear to all
agree, with CONFIG_REGPARM but too old a gcc (which is unknown at
configuration time and thus the user can't be prevented from turning
this option on), mismatches between assembly and C would result. Thus
the need for checking the gcc version in (some) assembly files (of
course this implies that for preprocessing assembly files one would not
try to use a different gcc than that used for compiling the C stuff).

I do, however, believe that it is an inherent weakness of gcc that it
doesn't decorate names of functions employing non-standard parameter
passing schemes in some way (i.e. similar to the __stdcall decoration on
Windows); with such functionality, it'd be much easier and safer to use
mixed schemes.

>However this points to a bug in that when someone sets this
>on 2.95 the assembly functions who check for CONFIG_REGPARM
>explicitely will be subtly miscompiled. Perhaps having 
>a #error for this case would be better, although that
>would break allyesconfig on prehistoric compilers. Maybe 
>it needs to be special cased in autoconf.h

Jan
