Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289350AbSAJGqO>; Thu, 10 Jan 2002 01:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289352AbSAJGqE>; Thu, 10 Jan 2002 01:46:04 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:18440 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289350AbSAJGpp>; Thu, 10 Jan 2002 01:45:45 -0500
Message-ID: <3C3D375C.E4A7EE77@zip.com.au>
Date: Wed, 09 Jan 2002 22:40:28 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ville Herva <vherva@niksula.hut.fi>
CC: linux-kernel@vger.kernel.org, Jani Forssell <jani.forssell@viasys.com>
Subject: Re: Via KT133 pci corruption: stock 2.4.18pre2 oopses as well
In-Reply-To: <20020108215818.J1331@niksula.cs.hut.fi> <E16O2fD-0007Vn-00@the-village.bc.nu> <20020108221315.U1200@niksula.cs.hut.fi> <20020109144549.L1331@niksula.cs.hut.fi>, <20020109144549.L1331@niksula.cs.hut.fi>; <20020109172604.N1331@niksula.cs.hut.fi> <3C3CAF85.8BD5E2E1@zip.com.au>,
		<3C3CAF85.8BD5E2E1@zip.com.au>; from akpm@zip.com.au on Wed, Jan 09, 2002 at 01:00:53PM -0800 <20020110083413.S1200@niksula.cs.hut.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva wrote:
> 
> On Wed, Jan 09, 2002 at 01:00:53PM -0800, you [Andrew Morton] claimed:
> > Ville Herva wrote:
> > >
> > > >>EIP; c0131ce0 <sync_page_buffers+10/b0>   <=====
> >
> > Looks like a corrupted `next' pointer in the page's buffer_head
> > ring.  Your report is identical to Todd Eigenschink's repeatable
> > oops.  http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.3/0689.html
> <snip>
> > I am able to trigger this in around ten minutes on 2.4.13 and
> > later kernels.  However 2.4.13-pre6 ran the test for nine hours
> > and did not fail.
> 
> Out of curiosity: what kind of load do you use to trigger it?

Massive VM load and ext3.  I've found the buffer-list destroyed
bug.  It's incorrect buffer locking in ext3.  It used to work,
sleazily, but blockdev-in-pagecache pulled its pants down.

> > I've put the 2.4.13-pre6 -> 2.4.13 diff at http://www.zip.com.au/~akpm/1.gz
> 
> Seems your diff didn't include some bits (Maintainers changes and something
> else.)
> 
> Anyhow, I compiled 2.4.13pre6 and it collapsed in just a few minutes. My
> best guess is that network card pci dma is somehow fubar, and it writes
> stuff to where it shouldn't.

OK.  Looks like they're different things - you have hardware problems,
I have brain problems.

-
