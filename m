Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319165AbSIDNSH>; Wed, 4 Sep 2002 09:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319166AbSIDNSH>; Wed, 4 Sep 2002 09:18:07 -0400
Received: from stine.vestdata.no ([195.204.68.10]:2214 "EHLO stine.vestdata.no")
	by vger.kernel.org with ESMTP id <S319165AbSIDNSF>;
	Wed, 4 Sep 2002 09:18:05 -0400
Date: Wed, 4 Sep 2002 15:22:18 +0200
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: Alexander Viro <viro@math.psu.edu>, Xavier Bestel <xavier.bestel@free.fr>,
       Anton Altaparmakov <aia21@cantab.net>, david.lang@digitalinsight.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
Message-ID: <20020904152218.A6228@vestdata.no>
References: <20020904144909.Z6228@vestdata.no> <200209041254.g84CstS22167@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209041254.g84CstS22167@oboe.it.uc3m.es>; from ptb@it.uc3m.es on Wed, Sep 04, 2002 at 02:54:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 02:54:55PM +0200, Peter T. Breuer wrote:
> > > Sure. So what?  What's wrong with a O_DIRDIRECT flag that makes all
> > > opens retrace the path from the root fs _on disk_ instead of from the 
> > > directory cache? 
> > 
> > Did you read Antons post about this?
> 
> Yep. My reply is out there.

I think you missed one. Anton explained in detail what NTFS would have
to do to write a single byte if _nothing_ was cached on the client. I
think it failed to mention that the whole operation would have to be
executed with a lock - so mouch for distributed operation.

> > Why do you want a filesystem if you're not going to use any filesystem
> > operations? If all you want to do is to split your shared device into
> 
> But I said we DO want to use FS operations. Just nowhere near as often
> as we want to treat the data streaming through the file system (i.e.
> "strawman"), so the speed of metadata operations on the FS is not
> apparently an issue.

Remember that append causes metadata updates, so the only thing you can
do without worrying about the speed of metadata updates is read/rewrite.
(assuming you hack the filesystems to turn of timestamp-updates)
And even those operations are highly dependent on "metadata operations"
- they need metadata to know where to read/rewrite. Again, read Antons
post about this.

> > multipe (static) logical units use a logical volume manager. 
> 
> My experiments with the current lvm have convinced me that it is a
> horror show with no way sometimes of rediscovering its own consistent
> state even on one node. I'd personally prefer there to be no lvm, right
> now!

Currently there is no volume-manager with cluster support on linux
(unless Veritas has one?), but both Sistina and IBM are working on it
for LVM2 and EVMS - I'm sure patches will be accepted to speed up the
process.

> > If you _do_ need a filesystem, use something like gfs. Have you looked
> > at it at all?
> 
> The point is not to choose a file system, but to be able to use
> whichever one is preferable _at the time_. This is important.
> Different FSs have different properties, and if one is 10% faster than
> another for a different data load, then the faster FS can be put
> in and 10% more data can be collected in the time slot allocated (and
> these time slots cost "the earth" :-).

Are you refering to that some filesystems can handle certain workloads
better than others? E.g. reiserfs is really fast for manipulating
directory-structures, adding new files or removing old ones? But didn't
you say that all you cared about was read and rewrite? That all other
filesystem-operations were so rare that nobody would notice?

In addition to this beeing technically impossible (to create a _working_
solution) I think the motivation is seriously flawed. The "solution"
you're proposing wouldn't be suitable for any viable problem.



-- 
Ragnar Kjørstad
Big Storage
