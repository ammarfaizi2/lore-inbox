Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319159AbSIDMu3>; Wed, 4 Sep 2002 08:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319160AbSIDMu3>; Wed, 4 Sep 2002 08:50:29 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:59666 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S319159AbSIDMu2>;
	Wed, 4 Sep 2002 08:50:28 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209041254.g84CstS22167@oboe.it.uc3m.es>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <20020904144909.Z6228@vestdata.no> from "[Ragnar Kj_rstad]" at "Sep
 4, 2002 02:49:09 pm"
To: "[Ragnar Kj_rstad]" <kernel@ragnark.vestdata.no>
Date: Wed, 4 Sep 2002 14:54:55 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>, Alexander Viro <viro@math.psu.edu>,
       Xavier Bestel <xavier.bestel@free.fr>,
       Anton Altaparmakov <aia21@cantab.net>, david.lang@digitalinsight.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago [Ragnar Kj_rstad] wrote:"
[Charset iso-8859-1 unsupported, filtering to ASCII...]
> On Wed, Sep 04, 2002 at 11:02:07AM +0200, Peter T. Breuer wrote:
> > > There is more to coherency and preserving fs structure than "don't cache
> > 
> > Sure. So what?  What's wrong with a O_DIRDIRECT flag that makes all
> > opens retrace the path from the root fs _on disk_ instead of from the 
> > directory cache? 
> 
> Did you read Antons post about this?

Yep. My reply is out there.

> > I suggest that changing FS structure is an operation that is so
> > relatively rare  in the projected environment (in which gigabytes of
> > /data/ are streaming through every second) that you can make them as
> > expensive as you like and nobody will notice. 
> 
> Why do you want a filesystem if you're not going to use any filesystem
> operations? If all you want to do is to split your shared device into

But I said we DO want to use FS operations. Just nowhere near as often
as we want to treat the data streaming through the file system (i.e.
"strawman"), so the speed of metadata operations on the FS is not
apparently an issue.

> multipe (static) logical units use a logical volume manager. 

My experiments with the current lvm have convinced me that it is a
horror show with no way sometimes of rediscovering its own consistent
state even on one node. I'd personally prefer there to be no lvm, right
now!

> If you _do_ need a filesystem, use something like gfs. Have you looked
> at it at all?

The point is not to choose a file system, but to be able to use
whichever one is preferable _at the time_. This is important.
Different FSs have different properties, and if one is 10% faster than
another for a different data load, then the faster FS can be put
in and 10% more data can be collected in the time slot allocated (and
these time slots cost "the earth" :-).

Peter
