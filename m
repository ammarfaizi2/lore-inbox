Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293224AbSBWWMQ>; Sat, 23 Feb 2002 17:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293220AbSBWWMG>; Sat, 23 Feb 2002 17:12:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34579 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293231AbSBWWLy>;
	Sat, 23 Feb 2002 17:11:54 -0500
Message-ID: <3C781351.DCB40AD3@zip.com.au>
Date: Sat, 23 Feb 2002 14:10:25 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: yodaiken@fsmlabs.com, Robert Love <rml@tech9.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
In-Reply-To: <3C773C02.93C7753E@zip.com.au>, <1014444810.1003.53.camel@phantasy> <3C773C02.93C7753E@zip.com.au> <1014449389.1003.149.camel@phantasy> <3C774AC8.5E0848A2@zip.com.au> <20020223043815.B29874@hq.fsmlabs.com> <1014488408.846.806.camel@phantasy> <20020223120648.A1295@hq.fsmlabs.com> <3C781037.EA4ADEF5@linux-m68k.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> 
> Hi,
> 
> yodaiken@fsmlabs.com wrote:
> 
> > Right. Without preemption it is safe to do
> >         c = smp_get_cpuid();
> >        ...
> >         x = ++local_cache[c]
> >        ..
> >
> >        y = ++different_local_cache[c];
> >       ..
> 
> Just add:
>         smp_put_cpuid();
> 
> Is that so much worse?
> 

ooh.  me likee.

#define smp_get_cpuid() ({ preempt_disable(); smp_processor_id(); })
#define smp_put_cpuid() preempt_enable()

Does rml likee?

-
