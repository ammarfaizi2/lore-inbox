Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWDZXKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWDZXKI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 19:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWDZXKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 19:10:07 -0400
Received: from main.gmane.org ([80.91.229.2]:39116 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932407AbWDZXKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 19:10:06 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Roman Kononov <kononov195-far@yahoo.com>
Subject: Re: C++ pushback
Date: Wed, 26 Apr 2006 18:00:52 -0500
Message-ID: <e2ou35$u5r$1@sea.gmane.org>
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com> <20060426200134.GS25520@lug-owl.de> <Pine.LNX.4.64.0604261305010.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-255-17-86.dsl.emhril.ameritech.net
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <Pine.LNX.4.64.0604261305010.3701@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 26 Apr 2006, Jan-Benedict Glaw wrote:
>> There's one _practical_ thing you need to keep in mind: you'll either
>> need 'C++'-clean kernel headers (to interface low-level kernel
>> functions) or a separate set of headers.
> 
> I suspect it would be easier to just do
> 
> 	extern "C" {
> 	#include <linux/xyz.h>
> 	...
> 	}
> 
> instead of having anything really C++'aware in the headers.
> 
> If by "clean" you meant that the above works, then yeah, there might be 
> _some_ cases where we use C++ keywords etc in the headers, but they should 
> be pretty unusual and easy to fix.
> 
> The real problem with C++ for kernel modules is:
> 
>  - the language just sucks. Sorry, but it does.
Sorry, you do not know the language, and your statement is not 
credible. I think that C sucks.

>  - some of the C features we use may or may not be usable from C++ 
>    (statement expressions?)
Statement expressions are working fine in g++. The main difficulties are:
    - GCC's structure member initialization extensions are syntax
      errors in G++: struct foo_t foo={.member=0};
    - empty structures are not zero-sized in g++, unless they are like
      this one: struct really_empty_t { char dummy[0]; };

>  - the compilers are slower, and less reliable. This is _less_ of an issue 
>    these days than it used to be (at least the reliability part), but it's 
>    still true.
G++ compiling heavy C++ is a bit slower than gcc. The g++ front end is 
reliable enough. Do you have a particular bug in mind?

>  - a lot of the C++ features just won't be supported sanely (ie the kernel 
>    infrastructure just doesn't do exceptions for C++, nor will it run any 
>    static constructors etc).
A lot of C++ features are already supported sanely. You simply need to 
understand them. Especially templates and type checking. C++ 
exceptions are not very useful tool in kernels. Static constructor 
issue is trivial. I use all C++ features (except exceptions) in all 
projects: Linux kernel modules, embedded real-time applications, 
everywhere. They _really_ help a lot.

>
> Anyway, it should all be doable. Not necessarily even very hard. But I 
> doubt it's worth it.
> 
> 		Linus

I think that allowing C++ code to co-exist with the kernel would be a 
step forward.

