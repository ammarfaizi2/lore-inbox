Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274851AbRIZHFj>; Wed, 26 Sep 2001 03:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274852AbRIZHF3>; Wed, 26 Sep 2001 03:05:29 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:51936 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S274851AbRIZHFL>; Wed, 26 Sep 2001 03:05:11 -0400
Date: Wed, 26 Sep 2001 12:38:34 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: davem@redhat.com, marcelo@conectiva.com.br, riel@conectiva.com.br,
        Andrea Arcangeli <andrea@suse.de>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, anton@samba.org, jdoelle@de.ibm.com
Subject: Re: Locking comment on shrink_caches()
Message-ID: <20010926123834.A9171@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20010926103424.A8893@in.ibm.com> <3BB16834.4393EEA3@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3BB16834.4393EEA3@zip.com.au>; from akpm@zip.com.au on Tue, Sep 25, 2001 at 10:31:32PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 10:31:32PM -0700, Andrew Morton wrote:
> Dipankar Sarma wrote:
> > 
> > John Hawkes from SGI had published some AIM7 numbers that showed
> > pagecache_lock to be a bottleneck above 4 processors. At 32 processors,
> > half the CPU cycles were spent on waiting for pagecache_lock. The
> > thread is at -
> > 
> > http://marc.theaimsgroup.com/?l=lse-tech&m=98459051027582&w=2
> > 
> 
> That's NUMA hardware.   The per-hashqueue locking change made
> a big improvement on that hardware.  But when it was used on
> Intel hardware it made no measurable difference at all.
> 
> Sorry, but the patch adds compexity and unless a significant
> throughput benefit can be demonstrated on less exotic hardware,
> why use it?

I agree that on NUMA systems, contention and lock wait times
degenerate non-linearly thereby skewing the actual impact.

IIRC, there were discussions on lse-tech about pagecache_lock and 
dbench numbers published by Juergen Doelle (on 8way Intel) and 
Anton Blanchard on 16way PPC. Perhaps they can shed some light on this.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
