Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271364AbTHMD5y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 23:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271365AbTHMD5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 23:57:54 -0400
Received: from dyn-ctb-210-9-243-246.webone.com.au ([210.9.243.246]:52746 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S271364AbTHMD5w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 23:57:52 -0400
Message-ID: <3F39B702.7000406@cyberone.com.au>
Date: Wed, 13 Aug 2003 13:56:50 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sourceforge.net>
CC: andersen@codepoet.org,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       bernd@firmix.at, Anthony.Truong@mascorp.com, alan@lxorguk.ukuu.org.uk,
       schwab@suse.de, ysato@users.sourceforge.jp, willy@w.ods.org,
       Valdis.Kletnieks@vt.edu, william.gallafent@virgin.net
Subject: Re: generic strncpy - off-by-one error
References: <1060741101.948.245.camel@cube>	 <20030813024752.GA20369@codepoet.org> <1060745910.948.268.camel@cube>
In-Reply-To: <1060745910.948.268.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Albert Cahalan wrote:

>On Tue, 2003-08-12 at 22:47, Erik Andersen wrote:
>
>>On Tue Aug 12, 2003 at 10:18:21PM -0400, Albert Cahalan wrote:
>>
>>>You're all wrong. This is some kind of programming
>>>test for sure!
>>>
>>>Let us imagine that glibc has a correct version.
>>>By exhaustive testing, I found a version that works.
>>>Here it is, along with the test code:
>>>
>>>//////////////////////////////////////////////////////
>>>#define _GNU_SOURCE
>>>#include <string.h>
>>>#include <stdlib.h>
>>>#include <stdio.h>
>>>
>>>// first correct implementation!
>>>char * strncpy_good(char *dest, const char *src, size_t count){
>>>  char *tmp = dest;
>>>  memset(dest,'\0',count);
>>>  while (count-- && (*tmp++ = *src++))
>>>    ;
>>>  return dest;
>>>}
>>>
>>char *strncpy(char * s1, const char * s2, size_t n)
>>{
>>    register char *s = s1;
>>    while (n) {
>>	if ((*s = *s2) != 0) s2++;
>>	++s;
>>	--n;
>>    }
>>    return s1;
>>}
>>
>
>That's excellent. On ppc I count 12 instructions,
>4 of which would go away for typical usage if inlined.
>Annoyingly, gcc doesn't get the same assembly from my
>attempt at that general idea:
>
>char * strncpy_5(char *dest, const char *src, size_t count){
>  char *tmp = dest;
>  while (count--){
>    if(( *tmp++ = *src )) src++;
>  }
>  return dest;
>}
>
>I suppose that gcc could use a bug report.
>

Its has different semantics though. Well taken as a whole they
are the same. When your loop finishes, count will be -1.


