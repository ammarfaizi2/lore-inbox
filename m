Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269968AbRHQIrh>; Fri, 17 Aug 2001 04:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269944AbRHQIr1>; Fri, 17 Aug 2001 04:47:27 -0400
Received: from elin.scali.no ([195.139.250.10]:47113 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S269981AbRHQIrW>;
	Fri, 17 Aug 2001 04:47:22 -0400
Subject: Re: [PATCH] processes with shared vm
From: Terje Eggestad <terje.eggestad@scali.no>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <oupelqbw0z4.fsf@pigdrop.muc.suse.de>
In-Reply-To: <997973469.7632.10.camel@pc-16.suse.lists.linux.kernel> 
	<oupelqbw0z4.fsf@pigdrop.muc.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 17 Aug 2001 10:46:59 +0200
Message-Id: <998038019.7627.21.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Den 17 Aug 2001 10:21:35 +0200, skrev Andi Kleen:
> Terje Eggestad <terje.eggestad@scali.no> writes:
> 
> > I figured out that it's difficult to find out from /proc
> > which processes that share VM (created with clone(CLONE_VM)). 
> > 
> > made a patch that adds in /proc/<pid>/status a VmClones field that tells
> > how many proc that uses the same VM (mm_struct).  if there are clones I
> > add another field VmFirstClone with the pid of clone with the lowest
> > pid. 
> > 
> > Needed for things like gtop that adds mem usage of groups of proc, or
> > else they add up the usage of SIZE and RSS of threads.
> > 
> > The patch need to be applied to linux/fs/proc/array.c
> 
> The basic idea is a good one (I have written a similar thing in the past ;)
> Your implementation is O(n^2) however in ps, which is not acceptable.
> Much better is it to add a new field to mm_struct that gets initialised
> on first creation with the pid, and adding a place holder in pid hash
> if that process goes away and the mm_struct is still there to avoid pid
> reuse (or alternatively link task_structs to mms and always use the pid of
> the first entry)
> 
> -Andi

Thought of all that, yes ps will have O(n^2) BUT ONLY FOR CLONED PROCS.
How many cloned procs do you usually have????

Even if I agree that there should be a linked list of all the cloned
procs, it means major changes to the data structs in the kernel.

With the number of threaded programs out there, this is "good enough".

TJ


-- 
_________________________________________________________________________

Terje Eggestad                  terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 70 Bogerud                      +47 975 31 574  (MOBILE)
N-0621 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

