Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317214AbSGJE1O>; Wed, 10 Jul 2002 00:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317360AbSGJE1N>; Wed, 10 Jul 2002 00:27:13 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:43204 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317214AbSGJE1M>;
	Wed, 10 Jul 2002 00:27:12 -0400
Message-ID: <3D2B4C42.4090404@us.ibm.com>
Date: Tue, 09 Jul 2002 13:49:06 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Robert Love <rml@mvista.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rick Lindsley <ricklind@us.ibm.com>, Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
References: <Pine.GSO.4.21.0207092320380.2515-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Tue, 9 Jul 2002, Arnaldo Carvalho de Melo wrote:
> 
>>Em Tue, Jul 09, 2002 at 02:47:49PM -0700, Robert Love escreveu:
>>
>>>On Tue, 2002-07-09 at 07:44, Dave Hansen wrote:
>>>
>>>>The Stanford Checker or something resembling it would be invaluable 
>>>>here.  It would be a hell of a lot better than my litle patch!
>>>
>>>The Stanford Checker would be infinitely invaluable here -- agreed.
>>>
>>>Anything that can graph call chains and do analysis... we can get it to
>>>tell us exactly who and what.
> 
> Not anything.  It can be used to find problems (and be very helpful at that)
> but it can't be used to verify anything.
> 
> The problem is that checker doesn't (and cannot) cover all code paths -
> by the time when it comes into the game the source had already passed
> through through cpp.  In other words, depending on the configuration
> you might get very different results.

I have the feeling that the filesystems' use of lots of function 
pointers will add a large amount of complexity to whatever programming 
any checker would require.  Bill Irwin and I were discussing it and we 
have ways of getting around most of them, but there are _lots_ of 
special cases.

   "Proving" correctness would obviously be ideal, but in an imperfect 
world, what are your feelings on a runtime system for detecting 
"magical/bad" BKL use?  I'm not proposing my kludgy "printk if you're 
bad" stuff, but something with much less impact.  I would like to do 
something somewhat like profile=2.  During each lock_kernel(), the 
program counter (any maybe more) could be stored in an internal kernel 
structure and retrieved later via a /proc file, just like readprofile. 
    This wouldn't have intrusive printk messages, and would be able to 
be activated by either a command-line parameter, or something else in 
/proc.  If we had this in our development kernel, interested 
developers could pay attention to the output, while the normal kernel 
developer could simply ignore it.

> Normally it's not that bad, but "can this function block?" is very nasty
> in that respect - changes of configuration can and do affect that in
> non-trivial ways.

I also wonder how it handles things like kmalloc(), which can block 
depending on arguments.

-- 
Dave Hansen
haveblue@us.ibm.com

