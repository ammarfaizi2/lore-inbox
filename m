Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269909AbRHQIVz>; Fri, 17 Aug 2001 04:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269756AbRHQIVp>; Fri, 17 Aug 2001 04:21:45 -0400
Received: from ns.suse.de ([213.95.15.193]:33803 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S269274AbRHQIVe>;
	Fri, 17 Aug 2001 04:21:34 -0400
To: Terje Eggestad <terje.eggestad@scali.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] processes with shared vm
In-Reply-To: <997973469.7632.10.camel@pc-16.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 17 Aug 2001 10:21:35 +0200
In-Reply-To: Terje Eggestad's message of "17 Aug 2001 09:53:55 +0200"
Message-ID: <oupelqbw0z4.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terje Eggestad <terje.eggestad@scali.no> writes:

> I figured out that it's difficult to find out from /proc
> which processes that share VM (created with clone(CLONE_VM)). 
> 
> made a patch that adds in /proc/<pid>/status a VmClones field that tells
> how many proc that uses the same VM (mm_struct).  if there are clones I
> add another field VmFirstClone with the pid of clone with the lowest
> pid. 
> 
> Needed for things like gtop that adds mem usage of groups of proc, or
> else they add up the usage of SIZE and RSS of threads.
> 
> The patch need to be applied to linux/fs/proc/array.c

The basic idea is a good one (I have written a similar thing in the past ;)
Your implementation is O(n^2) however in ps, which is not acceptable.
Much better is it to add a new field to mm_struct that gets initialised
on first creation with the pid, and adding a place holder in pid hash
if that process goes away and the mm_struct is still there to avoid pid
reuse (or alternatively link task_structs to mms and always use the pid of
the first entry)

-Andi
