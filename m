Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbSJ2PVq>; Tue, 29 Oct 2002 10:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261973AbSJ2PVq>; Tue, 29 Oct 2002 10:21:46 -0500
Received: from [198.149.18.6] ([198.149.18.6]:34227 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S261963AbSJ2PVn>;
	Tue, 29 Oct 2002 10:21:43 -0500
Date: Tue, 29 Oct 2002 09:28:00 -0600
From: Nathan Straz <nstraz@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] AIM Independent Resource Benchmark  results for kernel-2.5.44
Message-ID: <20021029152800.GB2030@sgi.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <fa.d95885v.1d14t8c@ifi.uio.no> <037101c27c84$70015ce0$9865fea9@PCJohn> <20021028182839.GA2030@sgi.com> <20021028231738.GC15779@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021028231738.GC15779@unthought.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2002 at 12:17:38AM +0100, Jakob Oestergaard wrote:
> On Mon, Oct 28, 2002 at 12:28:39PM -0600, Nathan Straz wrote:
> > > The AIM7/AIM9 new_raph is broken code.  The convergence loop termination
> > > conditional looks something like:
> > >    if (delta == 0) break;
> > > for a type "double" delta.  You ought to change that to be something
> > > like:
> > >    if (delta <= 0.00000001L) break;
> > 
> > I usually specify the compiler flag -ffloat-store and that fixes the
> > issue for me.  
> 
> Maybe that will work as a work-around.  But it is nothing but a
> work-around. The previous poster was right - the code is broken.

/me looks at the code

	/*
	 * Step 4: if |p - p0| < TOL then terminate successfully
	 */
	delta = fabs(p - p0);
	if (delta == 0.0)
		break;

Ok, I'll admit that the code does look broken, especially with regard to
the comment *in* the code.  

Is anyone from Caldera still maintaining this code or shall I create a
CVS module as part of LTP?

-- 
Nate Straz                                              nstraz@sgi.com
sgi, inc                                           http://www.sgi.com/
Linux Test Project                                  http://ltp.sf.net/
