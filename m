Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312392AbSC3FH4>; Sat, 30 Mar 2002 00:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312394AbSC3FHq>; Sat, 30 Mar 2002 00:07:46 -0500
Received: from 24-25-196-177.san.rr.com ([24.25.196.177]:18705 "HELO
	acmay.homeip.net") by vger.kernel.org with SMTP id <S312392AbSC3FHh>;
	Sat, 30 Mar 2002 00:07:37 -0500
Date: Fri, 29 Mar 2002 21:07:35 -0800
From: andrew may <acmay@acmay.homeip.net>
To: Neil Spring <nspring@cs.washington.edu>
Cc: Marek Zawadzki <mzawadzk@cs.stevens-tech.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: TCP hashing function
Message-ID: <20020329210735.N1097@ecam.san.rr.com>
In-Reply-To: <Pine.NEB.4.33.0203281945150.16010-100000@girardin.cs.stevens-tech.edu> <20020329080757.GA32052@cs.washington.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2002 at 12:08:18AM -0800, Neil Spring wrote:
> On Thu, Mar 28, 2002 at 08:11:27PM -0500, Marek Zawadzki wrote:
> > Hello,
> 
> >  static __inline__ int dcp_hashfn(__u32 laddr, __u16 lport,
> >                                   __u32 faddr, __u16 fport)
> >  {
> >          int h = ((laddr ^ lport) ^ (faddr ^ fport));
> >          h ^= h>>16;
> >          h ^= h>>8;
> >          /* make it always < size : */
> >          return h & (MY_HTABLE_SIZE - 1);   /* MY_HT... = 128 */
> >  }
> > 
> > Although I am treating it as a blackbox and it works fine for me, my
> > professor pointed the following about this function:
> 
> If you're a student, you should probably try to figure
> this out for yourself; it's the only way to learn.  

Add one to the homework on the list tally.

> > If both IP addresses have the same upper 16 bits (like 155.246.10.5 and
> > 155.246.120.30), then the 1st 4-way XOR will put 16 bits of zero in h.
> > Then "h ^= h>>16" will preserve the upper 16 bits as zero.  Then
> > "h ^= h>>8" will preserve the upper 24 bits!
> > [...]

Look at the size and see why it doesn't matter.
