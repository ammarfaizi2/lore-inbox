Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316266AbSEKTha>; Sat, 11 May 2002 15:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316268AbSEKTh3>; Sat, 11 May 2002 15:37:29 -0400
Received: from mail.eunet.ch ([146.228.10.7]:2832 "EHLO mail.kpnqwest.ch")
	by vger.kernel.org with ESMTP id <S316266AbSEKTh1>;
	Sat, 11 May 2002 15:37:27 -0400
Message-ID: <3CDD8F14.59642031@dial.eunet.ch>
Date: Sat, 11 May 2002 21:37:24 +0000
From: Mario Vanoni <vanonim@dial.eunet.ch>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-rc1aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: NFS problem after 2.4.19-pre3, not solved
In-Reply-To: <3CDC4962.4B9393D7@dial.eunet.ch> <20020510231707.M13730@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Fri, May 10, 2002 at 10:27:46PM +0000, Mario Vanoni wrote:
> > Hi Trond, hi Andrea, hi All
> >
> > In production environment, since >6 months,
> > ethernet 10Mbits/s, on backup_machine
> > mount -t nfs production_machine /mnt.
> >
> > find `listing from production_machine` | \
> > cpio -pdm backup_machine
> >
> > Volume ~320MB, nearly constant.
> >
> > Medium times:
> >
> > 2.4.17-rc1aa1: 1m58s, _the_ champion !!!
> >
> > all later's, e.g.:
> >
> > 2.4.19-pre8aa2; 4m35s
> > 2.4.19-pre8-ac1: 4m00s
> > 2.4.19-pre7-rmap13a: 4m02s
> > 2.4.19-pre7: 4m35s
> > 2.4.19-pre4: 4m20s
> >
> > the last usable was:
> >
> > 2.4.19-pre3: 2m35s, _not_ a champion
> >
> > All benchmarks don't reflect
> > some production needs,
> > <2 minutes or >4 minutes
> > is a great difference !!!
> 
> Yep.
> 
> Some time ago you told me and Trond that 2.4.19pre8 + this below below
> patch applied on top of 2.4.19pre4 returned back to the 2.4.19pre3 2.35
> levels (the 1.58-2.35 difference could be not nfs related, and I want to
> get to 2.35 first, 2.35-4.20 is a nfs thing).
> 
>         ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre8aa2/00_nfs-backout-cto-1
> 
> Could you double check that's the patch that makes the difference if
> applied on top of a vanilla 2.4.19pre4?
> 
> I cannot figure out why such a patch applied to pre4 fixes the problem,
> while it doesn't fix the problem if applied to my tree.
> 
> Maybe it wasn't that patch that fixed your problem after all, but one of
> the other nfs patches included in pre4. It would be very helpful if you
> could double check, just in case.
> 
> Many thanks for the feedback! :)
> 

All tests in chronological order, all today, all same volume ~320MB,
all same machines, source running 2.4.17-rc1aa1 since December 2001.
(Old values reported reflected situation in March 2002, a bit different)

2.4.19-pre3 vanilla
first time after boot 5m15s, then 1m56s 1m57s 1m56s 1m56s 1m57s
                      ^^^^^

2.4.19-pre4 vanilla
5m20s, then 4m00s 4m01s 4m00s 4m01s 4m01a

2.4.19-pre4-nfs-backout-cto, from pr8aa2, 2 Hunks
5m13a, then 1m57s 1m58s 1m57s 1m58s 1m59s

2.4.19-pre8 vanilla
5m05s, then 4m03s 5m20s(*) 6m00(*) 4m03s 5m02(*)
(*) heavy load on source machine

2.4.19-pre8aa2
8m58s, then 3m15s 3m17s 3m16s 3m15s 3m15s
^^^^^

2.4.19-pre8aa2-nfs-backout-cto, from pre8aa2, 5 Hunks
8m43s, then 5m12s 5m17s 5m16s, enough!
^^^^^

2.4.17-rc1aa1
2m46s, then 1m57s 1m56s 1m56s 1m56s, enough?
^^^^^

As long as the NFS problem persists,
all my machines (4) continue running 2.4.17-rc1aa1!
Stable, quick, reliable ... old, but nearly perfect.

Regards and many thanks

Mario, not in lkml.
