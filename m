Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTGOF2T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 01:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbTGOF2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 01:28:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64399 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262499AbTGOF2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 01:28:17 -0400
Date: Tue, 15 Jul 2003 07:43:04 +0200
From: Jens Axboe <axboe@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
Message-ID: <20030715054304.GC833@suse.de>
References: <20030713191921.GI16313@dualathlon.random> <20030714054918.GD843@suse.de> <Pine.LNX.4.55L.0307140922130.17091@freak.distro.conectiva> <20030714131206.GJ833@suse.de> <20030714195138.GX833@suse.de> <Pine.LNX.4.55L.0307141708210.8994@freak.distro.conectiva> <20030714202434.GS16313@dualathlon.random> <1058214881.13313.291.camel@tiny.suse.com> <20030714224528.GU16313@dualathlon.random> <1058229360.13317.364.camel@tiny.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058229360.13317.364.camel@tiny.suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14 2003, Chris Mason wrote:
> On Mon, 2003-07-14 at 18:45, Andrea Arcangeli wrote:
> > On Mon, Jul 14, 2003 at 04:34:41PM -0400, Chris Mason wrote:
> > > patch.  It's a good starting point for the question "can we do better
> > > for reads?" (clearly the answer is yes).
> > 
> > Jens's patch will block every writers until the parallel sync readers go
> > away.  if we add a 5 seconds delay for every write, sure readers will
> > run faster too in contest, and in turn it's not obvious to me it's
> > necessairly a good starting point.  
> 
> For real server workloads I agree the patch isn't a good idea.  But
> Jens' workload had a small number of kernel compilers (was it one proc
> or make -j4 or so?), so clearly the writers could still make progress. 
> This doesn't mean I want the patch but it does mean the numbers are
> worth thinking about ;-)
> 
> If we go back to Jens' numbers:
> 
> ctar_load:
> Kernel            [runs]        Time    CPU%    Loads   LCPU%   Ratio
> 2.4.22-pre5            3        235     114.0   25.0    22.1    1.75
> 2.4.22-pre5-axboe      3        194     138.1   19.7    20.6    1.46
>                                                ^^^^^^
> The loads column is the number of times ctar_load managed to run during
> the kernel compile, and the patched kernel loses each time.  This must
> partially be caused by the lower run time overall, but it is still
> important data.  It would be better if contest gave us some kind of
> throughput numbers (avg load time or something).

Well, look at the ratio given the run times listed. You'll see that they
are extremely close (0.1064 for 2.4.22-pre5 vs 0.1015 for
2.4.22-pre5-axboe).

It just shows that we are not hitting the possible bad problems in these
work loads.

-- 
Jens Axboe

