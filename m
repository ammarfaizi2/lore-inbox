Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbULBIYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbULBIYj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 03:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbULBIYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 03:24:39 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:48279 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261439AbULBIYg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 03:24:36 -0500
Message-ID: <41AED140.4000306@andrew.cmu.edu>
Date: Thu, 02 Dec 2004 03:24:32 -0500
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Imanpreet Singh Arora <imanpreet@gmail.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What if?
References: <41AE5BF8.3040100@gmail.com> <20041202044034.GA8602@thunk.org>
In-Reply-To: <20041202044034.GA8602@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:

>The way the kernel will deal with C++ language being a complete
>disaster (where something as simple as "a = b + c + d +e" could
>involve a dozen or more memory allocations, implicit type conversions,
>and overloaded operators) is to not use it.  Think about the words of
>wisdom from the movie Wargames: "The only way to win is not to play
>the game".
>

I think this oft-repeated argument is a strawman, since C++ and C are 
identical on primitive types, and for non-primitive types, C can't use 
operators anyway.  So translating some C++ thing like your example where 
[a,...,e] are all "struct foo", we would have a C function called 
"bar(a,b,c,d,e)".  Well, guess what, without looking at its definition, 
it could be doing all sorts of things too.  In C++ you look at the 
struct definition and the C++ standard, in C you look at the function.  
How is that so different?  In C, functions are arbitrary but operators 
are not.  In C++, both are arbitrary.  Considering that Linux wraps 
almost everything into function calls, there would be little difference 
in the end.

That's not to say I think C++ is a good idea for the kernel; It isn't.  
C++ is more complex in the sense it requires more analysis to figure out 
what the CPU is really doing, thus it does entail a higher cost.  It's 
not that bad for an expert, and in a large part it depends on how many 
of the advanced features you use; Don't use them and your code is 
practically the same as in C.  So it really boils down to what you 
*gain* compared to that extra analysis cost.  For a kernel, there is 
really not much gain.  "Some cost vs. little gain" implies "not worthwhile".

For example, filesystems would probably be more cleanly implemented as 
classes with virtual functions, but as the kernel code shows, with a 
little extra effort you can achieve the same thing with structs of 
function pointers in plain C.  Extra effort is easy to come by when you 
have thousands of contributors, so there's no real difference.  The case 
is similar with many other C++ features.

The C language was developed for writing the original Unix kernel and 
utilities, and not suprisingly it has all the features you need for 
that.  C++ was developed for improved development of user applications, 
mostly through more effective reuse of code.  So again, not suprisingly, 
applications are what it is best at.  Let's also try not to mix up "use 
the right tool for the right job" with "use the best tool for my normal 
job for all problems".  Many people who espouse one language above all 
others need to look outside of their own usual problem area.

 - Jim Bruce

