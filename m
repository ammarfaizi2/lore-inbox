Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261492AbSJPXPJ>; Wed, 16 Oct 2002 19:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261491AbSJPXPJ>; Wed, 16 Oct 2002 19:15:09 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:52608 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261475AbSJPXPH>; Wed, 16 Oct 2002 19:15:07 -0400
Subject: Re: [Lse-tech] Re: Skb initialization patch
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@digeo.com, hartner@austin.ibm.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, lse-tech@lists.sourceforge.net,
       lse-tech-admin@lists.sourceforge.net, mkanand@linux.ibm.com
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFD5DE9802.84A266C1-ON87256C54.007E4D9D@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Wed, 16 Oct 2002 18:20:48 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 10/16/2002 05:20:48 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




  > Looks like we were trying to take advantage of this feature by
  > initializing before freeing it and this is good for UNI but for SMP
  > there is no guarantee that the freed skbs will be given back to the
  > same CPU.

>There are not guarentees, but %99 of the time what is supposed to
>happen is that either the per-cpu skb_head_pool[] or the per-cpu slab
>cache give back the data on the same processor.

>If this isn't happening, fix the head pool or SLAB.  Because if
>you fix it there you'll fix the SMP behavior of every other SLAB
>cache in the kernel, not just SKBs.
Are you saying that the skbs do not migrate between the per cpu
pools (hotlist) if you have enough skbs in the hotlist/slab cache.
There is always going to be migration of objects between CPUs
even if you have enough objects per cpu pool.  There are other
elements come into picture such as memory reclaim etc.,
Moreover there is no guarantee that once a skb is allocated from
cpu 0 pool, it would be freed to cpu 0 pool.

>If the current cpu's skb_head_pool[] is being depleted in your
>tests, it should go to the per-cpu SLAB pool, if that is being
>depleted and thus it is going to other cpu's pools you should
>work on making SLAB not hit that case so often.
If the per cpu SLAB pool is depleted, it goes to the general
slab pool. As I pointed out earlier you cannot eliminate this
completely.

BTW SLAB is where I started the investigation, I will go back
to that later. We can modify SLAB cache to hold more objects
per cpu, but that won't eliminate the migration of objects.

>2.5.38 is really old too, results with current 2.5.x would be
>appreciated.  If you are unable to run your tests with current
>2.5.x kernels, work to fix those problems instead of telling me
>"I can't test with current 2.5.x"

>Also, I would really appreciate it if you could walk through the
>2.5.x versions between the "good" and "bad" performance points
>you noted in postings yesterday.  Please do not walk off to other
>tasks such as this SKB initialization patch when we have regressions
>in other areas.

I am working on the problem I posted yesterday. This skb init patch
was done long time ago. I just collected data on new kernels.




Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   http://www-124.ibm.com/developerworks/opensource/linuxperf
   http://www-124.ibm.com/developerworks/projects/linuxperf
   Phone:838-8088; Tie-line:678-8088



