Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262667AbSKYIlR>; Mon, 25 Nov 2002 03:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262670AbSKYIlR>; Mon, 25 Nov 2002 03:41:17 -0500
Received: from ns.tasking.nl ([195.193.207.2]:15373 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S262667AbSKYIlQ>;
	Mon, 25 Nov 2002 03:41:16 -0500
Message-ID: <3DE1E384.8000801@netscape.net>
Date: Mon, 25 Nov 2002 09:47:00 +0100
From: David Zaffiro <davzaffiro@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: nl, en-us
MIME-Version: 1.0
To: willy@w.ods.org
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compiling x86 with and without frame pointer
References: <19005.1037854033@kao2.melbourne.sgi.com> <20021121050607.GA1554@mark.mielke.cc> <3DDCA7C9.9040501@netscape.net> <20021121192045.GE3636@alpha.home.local>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can understand why not omitting framepointers generates better 
compressible code, since every function will start with:
	push   %ebp
	mov    %esp,%ebp
and end with:
	leave
	ret

But it's harder to find a reason why -fomit-frame-pointer is better 
compressible that -momit-leaf-frame-pointer (but it's probably related 
to a lot of mov's with stackpointer involved), especially since 
"-momit-leaf-frame-pointer" makes a trade-off between both other 
options: it omits framepointers for leaf functions (callees that aren't 
callers as well) and it doesn't for branch-functions.
The mixture of functions with frame-pointers and those without is 
probably causing bzip to compress less optimal.

Anyway it makes me wonder, whether kernelcompilation shouldn't be 
configurable between a "optimize for (compressed image) size" and a 
"optimize for speed" option... I'd go for speed... (and always omitting 
frame-pointers doesn't seem to as fast as omitting them only in leaf 
functions).


> Well, I tried on a 2.4.18+patches with gcc 2.95.3. bzImage is :
> 538481 bytes with -fomit-frame-pointer
> 538510 bytes with no particular flag
> 542137 bytes with -momit-leaf-frame-pointer.
> 
> So -fomit-frame-pointer shows the same as other's observation, but in this
> particular case, -momit-leaf-frame-pointer made a slightly bigger kernel.

