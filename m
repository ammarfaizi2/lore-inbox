Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279274AbRJWGLe>; Tue, 23 Oct 2001 02:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279273AbRJWGLZ>; Tue, 23 Oct 2001 02:11:25 -0400
Received: from femail11.sdc1.sfba.home.com ([24.0.95.107]:11919 "EHLO
	femail11.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S279272AbRJWGLL>; Tue, 23 Oct 2001 02:11:11 -0400
Message-ID: <3BD508C2.3A0DB6C2@didntduck.org>
Date: Tue, 23 Oct 2001 02:05:54 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: george anzinger <george@mvista.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: How should we do a 64-bit jiffies?
In-Reply-To: <1164.1003813848@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Mon, 22 Oct 2001 08:12:24 -0700,
> george anzinger <george@mvista.com> wrote:
> >I am working on POSIX timers where there is defined a CLOCK_MONOTONIC.
> >The most reasonable implementation of this clock is that it is "uptime"
> >or jiffies.  The problem is that it is most definitely not MONOTONIC
> >when it rolls back to 0 :(  Thus the need for 64-bits.
> 
> If you want to leave existing kernel code alone so it still uses 32 bit
> jiffies, just maintain a separate high order 32 bit field which is only
> used by the code that really needs it.  On 32 bit machines, the jiffie
> code does
> 
>   old_jiffies = jiffies++;
>   if (jiffies < old_jiffies)
>         ++high_jiffies;
> 
> You will need a spin lock around that on 32 bit systems, but that is
> true for anything that tries to do 64 bit counter updates on a 32 bit
> system.  None of your suggestions will work on ix86, it does not
> support atomic updates on 64 bit fields in hardware.

cmpxchg8b does, but it's a bit indirect.

-- 

						Brian Gerst
