Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268570AbRIDT7Z>; Tue, 4 Sep 2001 15:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268792AbRIDT7O>; Tue, 4 Sep 2001 15:59:14 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:36106 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S268570AbRIDT7E>; Tue, 4 Sep 2001 15:59:04 -0400
Message-ID: <3B953283.E925CD72@zip.com.au>
Date: Tue, 04 Sep 2001 12:58:59 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christopher Friesen <cfriesen@nortelnetworks.com>
CC: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        Fred <fred@arkansaswebs.com>, linux-kernel@vger.kernel.org
Subject: Re: Should I use Linux to develop driver for specialized ISA card?
In-Reply-To: <E15eHup-0003ir-00@the-village.bc.nu> <01090410264000.14864@bits.linuxball> <3B950034.17909E5D@nortelnetworks.com> <200109041823.f84INqE13918@maild.telia.com> <3B952CFE.A3B6FF95@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Friesen wrote:
> 
> > 1) Why shouldn't the low-latency patches work for another architecture?
> > Andrew Morton might be interested to fix other architectures too.
> > (but most patches are not in architecture specific code)
> 
> Well, a while back I took a look at the low latency patch and saw a bunch of
> arch-specific files being modified so I assumed that it wouldn't do much on a
> different architecture.  I may have been wrong.  I guess its time for me to do
> some testing.
> 

It is now arch-neutral.   There used to be a couple of x86 tweaks,
but they became unnecessary when some softirq fixes were merged.

So for other architectures the only thing which needs changing
is the actual config entries in arch/<arch>/config.in.  If you
do take a look at this, please send me the diffs for whatever
your architecture is.

I haven't heard much from non-x86 people; there were some remaining
latency problems with PPC many months ago, but they were never
explained and I don't know if the problems remain, or if indeed
they were ever real.

It's kind of amazing that you're seeing 300 millisec stalls on
a system with no local disks - most problems occur in the
VM list walking, dirty buffer writeout, etc.  Unless you're
performing a lot of fileystem work across that FC controller?
It could be that there is an architecture- or driver-specific
problem in your setup.

-
