Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281391AbRKZCHH>; Sun, 25 Nov 2001 21:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281393AbRKZCG5>; Sun, 25 Nov 2001 21:06:57 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:46089 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S281391AbRKZCGu>;
	Sun, 25 Nov 2001 21:06:50 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15-final drivers/net/bonding.c includes user space headers 
In-Reply-To: Your message of "25 Nov 2001 13:49:33 -0800."
             <9trp1d$ppg$1@cesium.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 26 Nov 2001 13:06:37 +1100
Message-ID: <1432.1006740397@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Nov 2001 13:49:33 -0800, 
"H. Peter Anvin" <hpa@zytor.com> wrote:
>By author:    Keith Owens <kaos@ocs.com.au>
>>
>> 2.4.15-final/drivers/net/bonding.c:188: #include <limits.h>
>> 
>> Kernel code must not include use space headers.  I thought this had
>> been fixed.  It will not compile in 2.5.
>
><limits.h> is one of the compiler-provided headers, i.e. from
>/usr/lib/gcc-lib/*/*/include -- if your kbuild harness don't
>allow those headers to be included, it's broken.

kbuild 2.5 does
  '-nostdinc -I/usr/lib/gcc-lib/... gcc version ../include/'
so it allows includes from the compiler headers.  The problem is:

  bonding.c includes limits.h, picked up from gcc, OK.
  limits.h includes syslimits.h from gcc, OK.
  syslimits.h tries to include_next <limits.h> to get the user space
  limits, not OK.

Any kernel code that includes limits.h or syslimits.h is polluted by
user space headers.  net/bonding.c does not even need limits.h.

