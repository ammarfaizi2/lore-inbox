Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293279AbSBWX62>; Sat, 23 Feb 2002 18:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293281AbSBWX6S>; Sat, 23 Feb 2002 18:58:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60932 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293279AbSBWX6J>;
	Sat, 23 Feb 2002 18:58:09 -0500
Message-ID: <3C782C34.2CC0E417@zip.com.au>
Date: Sat, 23 Feb 2002 15:56:36 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
In-Reply-To: <1014505987.1003.1104.camel@phantasy>,
		<3C773C02.93C7753E@zip.com.au>,
		<1014444810.1003.53.camel@phantasy> <3C773C02.93C7753E@zip.com.au>
		<1014449389.1003.149.camel@phantasy> <3C774AC8.5E0848A2@zip.com.au>
		<20020223043815.B29874@hq.fsmlabs.com> <1014488408.846.806.camel@phantasy>
		<20020223120648.A1295@hq.fsmlabs.com> <3C781037.EA4ADEF5@linux-m68k.org> 
		<3C781351.DCB40AD3@zip.com.au>  <1014505987.1003.1104.camel@phantasy> <1014507951.850.1140.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Sat, 2002-02-23 at 18:13, Robert Love wrote:
> > On Sat, 2002-02-23 at 17:10, Andrew Morton wrote:
> >
> > > ooh.  me likee.
> > >
> > > #define smp_get_cpuid() ({ preempt_disable(); smp_processor_id(); })
> > > #define smp_put_cpuid() preempt_enable()
> > >
> > > Does rml likee?
> >
> > Yah, that works.
> 
> OK, I still likee, but I was just thinking, if we are going to add have
> to add something why not consider the irq-safe atomic ops?  It is
> certainly the most optimal.
> 

For the situation Victor described:

	const int cpu = smp_get_cpuid();

	per_cpu_array_foo[cpu] = per_cpu_array_bar[cpu] +
					per_cpu_array_zot[cpu];

	smp_put_cpuid();

It's a nice interface - it says "pin down and return the current
CPU ID".

-
