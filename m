Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262887AbSKYLvI>; Mon, 25 Nov 2002 06:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262901AbSKYLvI>; Mon, 25 Nov 2002 06:51:08 -0500
Received: from ns.tasking.nl ([195.193.207.2]:26898 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S262887AbSKYLvI>;
	Mon, 25 Nov 2002 06:51:08 -0500
Message-ID: <3DE21010.9050407@netscape.net>
Date: Mon, 25 Nov 2002 12:57:04 +0100
From: David Zaffiro <davzaffiro@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: nl, en-us
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: willy@w.ods.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compiling x86 with and without frame pointer
References: <19005.1037854033@kao2.melbourne.sgi.com> <20021121192045.GE3636@alpha.home.local> <3DE1E384.8000801@netscape.net> <200211251009.gAPA9np09476@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>since "-momit-leaf-frame-pointer" makes a trade-off between both
>>other options: it omits framepointers for leaf functions (callees
>>that aren't callers as well) and it doesn't for branch-functions.
> 
> 
> Which does not sound quite right for me. FP should be omitted
> only if function contains less than half dozen stack references,
> otherwise not. It does not matter whether it is a leaf function or not.

Leaf functions generally do not contain more than half dozen 
stackreferences, and are generally called more or equally often as there 
callers. The slight overhead of leaf functions that do contain a dozen 
stackreferences is much smaller than the overhead of omitting 
framepointers in /all/ branch functions including those with dozens of 
stackreferences. Maybe gcc's optimizer could be adapted in the (near) 
future to compare either speed or sizes of possibly generated code, with 
and without framepointer, if the compile is not a debug one.

But in the mean time, in most "userland" projects I've tested with, the 
-momit-leaf-frame-pointer resulted in almost te same codesize as 
compiles with framepointer, along with more or less the same speed as 
"-fomit-frame-pointer". I wouldn't know how to benchmark kernel-configs 
though, and I haven't seen anyone doing this with the framepointer 
options yet...


> OTOH, AFAIK frame pointers make debugging easier, development kernels
> are better to be compiled with fp in every func.

Honestly, I think that's a shortcoming of the debugger if that's true. 
The debugger could store the stackpointer position after a call or 
calculate it based on sub/add/push/pop's, instead of borrowing it from 
ebp.  I'm just concerned about the extra costs (in speed and size) of 
always omiting the framepointer.

(It shouldn't be impossible to debug regparm- and stdcall-functions as 
well, I wonder why this could be a problem at the moment. But just 
"omitting framepointers" at least doesn't mix up the (IMHO: somewhat 
thoughtlessly defined) i386 32-bit C-callingconvention.)

