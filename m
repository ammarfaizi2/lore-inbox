Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281512AbRLGOVU>; Fri, 7 Dec 2001 09:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281541AbRLGOVK>; Fri, 7 Dec 2001 09:21:10 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:41961 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S281512AbRLGOUu>; Fri, 7 Dec 2001 09:20:50 -0500
Message-ID: <3C10D03B.1050405@antefacto.com>
Date: Fri, 07 Dec 2001 14:20:43 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: horrible disk thorughput on itanium
In-Reply-To: <p73r8q86lpn.fsf@amdsim2.suse.de.suse.lists.linux.kernel> <Pine.LNX.4.33.0112070710120.747-100000@mikeg.weiden.de.suse.lists.linux.kernel> <9upmqm$7p4$1@penguin.transmeta.com.suse.lists.linux.kernel> <p73n10v6spi.fsf@amdsim2.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> torvalds@transmeta.com (Linus Torvalds) writes:
> 
>>"putc()" is a standard function.  If it sucks, let's get it fixed.  And
>>instead of changing bonnie, how about pinging the _real_ people who
>>write sucky code?
>>
> 
> It is easy to fix. Just do #define putc putc_unlocked
> There is just a slight problem: it'll fail if your application is threaded
> and wants to use the same FILE from multiple threads.
> 
> It is a common problem on all OS that eventually got threadsafe stdio. 
> I bet putc sucks on Solaris too.
> 
> -Andi


Interesting thread on this:
http://sources.redhat.com/ml/bug-glibc/2001-11/msg00079.html

for glibc 2.2.4 with the following program with input file
of 354371 lines of text(/usr/share/doc/*), where the average line
length was 37 chars.

getc/putc
real 
2.181s
user 
2.150s
sys 
0.030s
getc_unlocked/putc_unlocked
real 
0.326s
user 
0.280s
sys 
0.040s

I.E. 669% faster!

Padraig.

-------------------
#include <stdio.h>

#ifndef  _REENTRANT
#    undef getc
#    define getc(x)   getc_unlocked(x)
#    undef putc
#    define putc(x,y) putc_unlocked(x,y)
#endif //_REENTRANT

void main(void)
{
     int c;
     while((c=getc(stdin))!=EOF) putc(c,stdout);
}


