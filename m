Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUA3PY0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 10:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbUA3PYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 10:24:25 -0500
Received: from northgate.starhub.net.sg ([203.117.1.53]:60680 "EHLO
	northgate.starhub.net.sg") by vger.kernel.org with ESMTP
	id S261731AbUA3PYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 10:24:22 -0500
Date: Fri, 30 Jan 2004 23:24:15 +0800
From: R Chan <rspchan@starhub.net.sg>
Subject: Re: [CRYPTO]: Miscompiling sha256.c by gcc 3.2.3 and arch pentium3,4
In-reply-to: <PLEIIGNDLGEDDKABPLHBAECPCHAA.dparis@w3works.com>
To: Dave Paris <dparis@w3works.com>
Cc: linux-kernel@vger.kernel.org, jmorris@redhat.com
Message-id: <401A771F.7060300@starhub.net.sg>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6)
 Gecko/20040113
References: <PLEIIGNDLGEDDKABPLHBAECPCHAA.dparis@w3works.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've narrowed the problem - it seems to be a specific optimisation bug with
gcc-3.2.3-24 that comes with RedHat 3ES. The problem is not kernel 
related (sorry!)
as the guts of the file exhibits the same problem when compiled in user 
space.
(All the non-sha256 test vectors in tcrypt.ko pass BTW.)

The older gcc32 that comes with Fedora Cora 1 and the gcc33 there get it 
right.

For the actual files please check bug #114610 in 
https://bugzilla.redhat.com.
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=114610
 - the bug report includes sha256.c, tcrypt.c, and types.h necessary to 
demonstrate
the problem in user space.





Dave Paris wrote:

>Has this been demonstrated on *any* system/arch using GCC 3.2.3 (or other
>3.2 series) or is it limited in scope to the description below?  Does it
>seem to do this with other implementations (other than sha256.c) or other
>kernels?  Just trying to get an idea if this is a complier optimization bug
>or something much more limited in scope.
>
>My personal lab is currently being unboxed and I won't be able to run my own
>tests for another week or so.  (apologies in advance)
>
>In any case, this is *extremely* serious from a number of angles.
>
>Kind Regards,
>-dsp
>
>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org
>[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of James Morris
>Sent: Friday, January 30, 2004 9:40 AM
>To: R CHAN
>Cc: linux-kernel@vger.kernel.org; David S. Miller
>Subject: Re: [CRYPTO]: Miscompiling sha256.c by gcc 3.2.3 and arch
>pentium3,4
>
>
>On Fri, 30 Jan 2004, R CHAN wrote:
>
>  
>
>>2.6.2-rc2 sha256.c is miscompiled with gcc 3.2.3.
>>(User space is RedHat 3ES.)
>>
>>Just an observation:
>>
>>gcc 3.2.3 is miscompiling sha256.c when using
>>-O2 -march=pentium3
>>or pentium4.
>>
>>gcc 3.3.x is ok, or the problem disappears
>>if I use arch=i686 or reduce the optimisation level to -O2.
>>
>>Sympthoms are all the sha256 test vectors fail.
>>If I extract the guts of the file to compile in user space
>>the same problem occurs.
>>    
>>
>
>Have you noticed if this happens for any of the other crypto algorithms?
>
>
>
>- James
>--
>James Morris
><jmorris@redhat.com>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>
>
>  
>

