Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317891AbSGZSBu>; Fri, 26 Jul 2002 14:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317893AbSGZSBu>; Fri, 26 Jul 2002 14:01:50 -0400
Received: from rj.SGI.COM ([192.82.208.96]:31625 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S317891AbSGZSBt>;
	Fri, 26 Jul 2002 14:01:49 -0400
Date: Fri, 26 Jul 2002 11:05:09 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lock assertion macros for 2.5.28
Message-ID: <20020726180509.GA793994@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20020725233047.GA782991@sgi.com> <20020726120918.GA22049@reload.namesys.com> <20020726174258.GC793866@sgi.com> <20020726185416.A18629@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020726185416.A18629@infradead.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 06:54:16PM +0100, Christoph Hellwig wrote:
> On Fri, Jul 26, 2002 at 10:42:58AM -0700, Jesse Barnes wrote:
> > On Fri, Jul 26, 2002 at 04:09:18PM +0400, Joshua MacDonald wrote:
> > > In reiser4 we are looking forward to having a MUST_NOT_HOLD (i.e.,
> > > spin_is_not_locked) assertion for kernel spinlocks.  Do you know if any
> > > progress has been made in that direction?
> > 
> > Well, I had that in one version of the patch, but people didn't think
> > it would be useful.  Maybe you'd like to check out Oliver's comments
> > at http://marc.theaimsgroup.com/?l=linux-kernel&m=102644431806734&w=2
> > and respond?  If there's demand for MUST_NOT_HOLD, I'd be happy to add
> > it since it should be easy.  But if you're using it to enforce lock
> > ordering as Oliver suggests, then there are probably more robust
> > solutions.
> 
> Why don't you just generalize the scsi version that already support this?
> 
> reinventing the wheel everywhere..

Well, I wouldn't go that far.  The macros are really simple and
implementing a MUST_NOT_HOLD should be easy too.  It could also be
done in a much more useful way than how ASSERT_LOCK works, by tracking
where the locks where acquired for example.

Did you check out the thread above?  Having ASSERT_LOCK(&lock, 0)
doesn't seem that useful by itself.  A lot of the scsi code does
things like:

  ASSERT_LOCK(&lock, 0);
  ...
  spin_lock(&lock);

What does that buy you?  The suggestions for tracking where the lock
was acquired (in the thread above) seem much more useful.

Thanks,
Jesse
