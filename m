Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292395AbSBUOfk>; Thu, 21 Feb 2002 09:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292397AbSBUOfc>; Thu, 21 Feb 2002 09:35:32 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:41944 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S292396AbSBUOfV>;
	Thu, 21 Feb 2002 09:35:21 -0500
Message-ID: <3C7504E8.3000604@debian.org>
Date: Thu, 21 Feb 2002 15:32:08 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux kernel config converter
In-Reply-To: <Pine.LNX.4.21.0202211456380.2650-100000@serv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2002 14:35:19.0276 (UTC) FILETIME=[FC634AC0:01C1BAE4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:

> Hi,
> 
> On Thu, 21 Feb 2002, Giacomo Catenazzi wrote:
> 
> 
>>1) default: Eric proposed to include defaults in configuration,
>>    but it seems that is a bad things, and defaults should be arch
>>    specific. (I don't remember the discussion, but you can
>>    parse the kbuild list, torque.net time)
>>
> 
> The defaults are just 1:1 representation of the current define_xxx
> statements. These can be of course later moved or depreciated or whatever.


Ok. But actually the defaults come mainly from config.def.
The define_xxx are uset to set a symbols in some situations.


BTW for people who like the old configure (or fix it):
: if xxx
:   define_bool CONFIG_FOO
: else
:   bool CONFIG_FOO
: fi
is incorrect. You should revert the definition order
(before bool than define_bool) else xconfig will break.


>>2) One of the problem in actual configure are the dependencies.
>>    FOO depend on BAR and BEER.
>>    Wat are the possible value of FOO if BAR=m, BEER=y.
>>    In kernel we have some drivers thet need foo to be n or y,
>>    in other cases: n or m.
>>    The logical operators hide the true dependency table.
>>    (don't expect developers read the docs: the logical operators
>>    seems like C operators, so they use like C, but they forget
>>    the third case (=m) ).
>>
> 
> For most cases I've seen it can be very simply defined with:
> 	(a && b && ...) = min(a, b, ...)
> 	(a || b || ...) = max(a, b, ...)
> 	for 'n'=0, 'm'=1, 'y'=2


With this you have a value (i.e. n,m,y).
How is the actual symbol range?

CONFIG_FOO:
  dep: (FREE? && BEER?)

how you tell configuration rools that
FOO can be only min/max of (FREE? && BEER?)

> Do you have some real examples?


No by hand. But I can search in rules.

>>Do you use the python identation mode?
>>
> 
> No python. Just c, flex and bison. :-)


I mean: Do you use pythons mode to tell when a
help description end (no tab: new symbol), few spaces:
is symbol help or configuration symbols)

	giacomo

 


