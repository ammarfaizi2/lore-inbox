Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbTBJElY>; Sun, 9 Feb 2003 23:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261660AbTBJElY>; Sun, 9 Feb 2003 23:41:24 -0500
Received: from unthought.net ([212.97.129.24]:4232 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S261615AbTBJElX>;
	Sun, 9 Feb 2003 23:41:23 -0500
Date: Mon, 10 Feb 2003 05:51:07 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Andrew Morton <akpm@digeo.com>
Cc: David Lang <david.lang@digitalinsight.com>, riel@conectiva.com.br,
       andrea@suse.de, ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org,
       axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210045107.GD1109@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Andrew Morton <akpm@digeo.com>,
	David Lang <david.lang@digitalinsight.com>, riel@conectiva.com.br,
	andrea@suse.de, ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org,
	axboe@suse.de
References: <Pine.LNX.4.50L.0302100211570.12742-100000@imladris.surriel.com> <Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com> <20030209203343.06608eb3.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030209203343.06608eb3.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 09, 2003 at 08:33:43PM -0800, Andrew Morton wrote:
> David Lang <david.lang@digitalinsight.com> wrote:
> >
> > note that issuing a fsync should change all pending writes to 'syncronous'
> > as should writes to any partition mounted with the sync option, or writes
> > to a directory with the S flag set.
> 
> We know, at I/O submission time, whether a write is to be waited upon. 
> That's in writeback_control.sync_mode.
> 
> That, combined with an assumption that "all reads are synchronous" would
> allow the outgoing BIOs to be appropriately tagged.

This may be a terribly stupid question, if so pls. just tell me  :)

I assume read-ahead requests go elsewhere?  Or do we assume that someone
is waiting for them as well?

If we assume they are synchronous, that would be rather unfair
especially on multi-user systems - and the 90% accuracy that Rik
suggested would seem exaggerated to say the least (accuracy would be
more like 10% on a good day).

> It's still approximate.  An exact solution would involve only marking I/O as
> synchronous when some process actually waits on its completion.  I do not
> believe that all the extra lookup and locking infrastructure and storage
> which this would require is justified.  Certainly not in a first iteration.

Just a quirk; NFS file servers.

The client does read-ahead - the nfsd on the server-side will wait for
the read request, thus the read is synchronous...  But it's not.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
