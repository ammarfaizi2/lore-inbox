Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318786AbSICPjk>; Tue, 3 Sep 2002 11:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318790AbSICPjk>; Tue, 3 Sep 2002 11:39:40 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:44036 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S318786AbSICPjj>;
	Tue, 3 Sep 2002 11:39:39 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209031544.g83FiAG03134@oboe.it.uc3m.es>
Subject: Re: [RFC] mount flag "direct"
In-Reply-To: <Pine.SOL.3.96.1020903163309.14707D-100000@libra.cus.cam.ac.uk>
 from Anton Altaparmakov at "Sep 3, 2002 04:37:40 pm"
To: Anton Altaparmakov <aia21@cantab.net>
Date: Tue, 3 Sep 2002 17:44:10 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>,
       linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Anton Altaparmakov wrote:"
> On Tue, 3 Sep 2002, Peter T. Breuer wrote:
> 
> > I'll rephrase this as an RFC, since I want help and comments.
> > 
> > Scenario:
> > I have a driver which accesses a "disk" at the block level, to which
> > another driver on another machine is also writing. I want to have
> > an arbitrary FS on this device which can be read from and written to
> > from both kernels, and I want support at the block level for this idea.
> 
> You cannot have an arbitrary fs. The two fs drivers must coordinate with
> each other in order for your scheme to work. Just think about if the two 
> fs drivers work on the same file simultaneously and both start growing the
> file at the same time. All hell would break lose.

Thanks!

Rik also mentioned that objection! That's good. You both "only" see
the same problem, so there can't be many more like it..

I replied thusly:

  OK - reply:
  It appears that in order to allocate away free space, one must first
  "grab" that free space using a shared lock. That's perfectly
  feasible.


> For your scheme to work, the fs drivers need to communicate with each
> other in order to attain atomicity of cluster and inode (de-)allocations,
> etc.

Yes. They must create atomic FS operations at the VFS level (grabbing
unallocated space is one of them) and I must share the locks for those
ops.

> Basically you need a clustered fs for this to work. GFS springs to

No! I do not want /A/ fs, but /any/ fs, and I want to add the vfs
support necessary :-).

That's really what my question is driving at. I see that I need to
make VFS ops communicate "tag requests" to the block layer, in
order to implement locking. Now you and Rik have pointed out one
operation that needs locking. My next question is obviously: can you
point me more or less precisely at this operation in the VFS layer?
I've only started studying it and I am relatively unfamiliar with it.

Thanks.

Peter
