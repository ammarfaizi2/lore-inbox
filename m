Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130177AbQKNAZH>; Mon, 13 Nov 2000 19:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130245AbQKNAY5>; Mon, 13 Nov 2000 19:24:57 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:11272 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S130177AbQKNAYq>; Mon, 13 Nov 2000 19:24:46 -0500
Date: Tue, 14 Nov 2000 00:45:47 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Szabolcs Szakacsits <szaka@f-secure.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: reliability of linux-vm subsystem
Message-ID: <20001114004547.D12931@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.LNX.4.30.0011132116420.20626-100000@fs129-190.f-secure.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0011132116420.20626-100000@fs129-190.f-secure.com>; from szaka@f-secure.com on Mon, Nov 13, 2000 at 10:50:05PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2000 at 10:50:05PM +0100, Szabolcs Szakacsits wrote:
> On Mon, Nov 13, 2000 Erik Mouw wrote:
> > Good, so the OOM killer works.
> 
> But it doesn't work for this kind of application misbehaviours (or
> user attacks):
> 
> main() { while(1) if (fork()) malloc(1); }

Proper process limits stop the fork bomb.

> or using IPC shared memory (code by Michal Zalewski)
> 
> int i,d=1; char*x; main(){ while(1){ x=shmat(shmget(0,10000000/d,511),0,0);
> if(x==-1){ d*=10; continue; } for(i=0;i<10000000/d;i++) if(*(x+i)); } }

I don't remember if this already fixed.

> Linux 2.[24] "deadlocks" (without quotas). BTW, apparently FreeBSD, OpenBSD,
> SCO also become unusable while e.g. Solaris and Tru64 survives (root can
> clean up) both in non-overcommit and overcommit mode (no user quotas in
> any case).
> 
> With the patch below [tried only with 2.2.18pre21 but it's easy to port to
> 2.4 and should apply to any late 2.2 kernels] Linux should also survive in
> both cases without any performance loss (well, trashing would start about
> the same time by adding 1.66% extra swap as the original one).

Looks like a nice feature to me. Any VM guru that cares to comment?

> > Sounds quite normal to me. If you don't enforce process limits, you
> > allow a normal user to thrash the system.
> 
> Home users don't quote themself so they must hit the reset button. Really
> is this the maximum that the kernel can do? Also many enterprises expect
> the OS won't deadlock in case of application misbehaviours so they don't
> have to care about quota setup and can keep the good performance. This
> shortcoming^Wfeature of the kernel is one of the reasons Linux is still
> considered a toy or hobby OS by many ....

This is a mechanism vs. policy issue. The kernel hands you enough
mechanisms (well, except your patch) to handle misbehaving users. It is
up to the sysadmin to enforce the policy. For the home user it means
that the distribution providers have to set decent limits, for
enterprises it means that they have to hire a sysadmin.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
