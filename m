Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273623AbSISVjm>; Thu, 19 Sep 2002 17:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273664AbSISVjm>; Thu, 19 Sep 2002 17:39:42 -0400
Received: from pc-80-195-34-180-ed.blueyonder.co.uk ([80.195.34.180]:16516
	"EHLO sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S273623AbSISVjm>; Thu, 19 Sep 2002 17:39:42 -0400
Date: Thu, 19 Sep 2002 22:44:36 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Duncan Sands <duncan.sands@math.u-psud.fr>,
       lkml <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] Re: fsync 50 times slower after 2.5.27
Message-ID: <20020919224436.E2831@redhat.com>
References: <200209190222.33276.duncan.sands@math.u-psud.fr> <3D891BD1.8F774946@digeo.com> <200209192032.25933.duncan.sands@math.u-psud.fr> <3D8A4016.F364B303@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D8A4016.F364B303@digeo.com>; from akpm@digeo.com on Thu, Sep 19, 2002 at 02:22:30PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 19, 2002 at 02:22:30PM -0700, Andrew Morton wrote:

> Thanks for testing.  The semantics of sched_yield() have changed
> significantly in 2.5.  Probably correctly, but it is breaking a
> few things which were tuned for the old semantics.  Amongst those
> things are OpenOffice and, it seems, ext3 transaction batching.
> 
> The transaction batching does good things under some situations,
> and we want it to keep working.  I'll sit tight for the while, see
> where shed_yield() behaviour ends up.  If we still have a problem
> then probably a schedule_timeout(1) in there would suffice.

Actually, with a proper yield() implementation, we can achieve the
same effect by making the commit thread do the yield itself before
locking down the transaction.  Having _every_ sync thread do a yield
itself before calling for a commit is probably overkill.

--Stephen
