Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263722AbTETLro (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 07:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbTETLro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 07:47:44 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:55567 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263722AbTETLrl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 07:47:41 -0400
Message-ID: <3ECA189A.30300@aitel.hist.no>
Date: Tue, 20 May 2003 13:59:22 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Robert White <rwhite@casabyte.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: recursive spinlocks. Shoot.
References: <PEEPIDHAKMCGHDBJLHKGGEENCMAA.rwhite@casabyte.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert White wrote:
> Er..
> 
> The gnome wields a morality stick, the morality stick wields itself to the
> gnome's hand...
> ---more---
> The gnome hits you... you feel better...
> 
> 
> Your "moral position"...
> 
> (quote) I want them to either learn to comprehend locking _properly_, or
> take up gardening instead. (unquote)
> 
> ...is critically flawed.
> 
> In point of fact, "proper" locking, when combined with "proper" definitions
> of an interface dictate that recursive locking is "better".  Demanding that
> a call_EE_ know what locks a call_ER_ (and all antecedents of caller) will
> have taken is not exactly good design.

That depends on how big the total system is.  You can break things
down into independent modules and submodules that don't know each other, but
at some point people need to know a whole module to do it properly.

> Oh, don't get me wrong, I appreciate that in intimately interlocking code
> you have to do some of this, but remember that "a lock" is "morally" a
> declaration of need at the module interface level of abstraction.
> 
> (for instance) The current kernel design requires that (the editorial) we
> need to know what locks are held when our file system hooks are called.
> Statements about how some particular lock (let's call him "bob") will be
> already held by the kernel when routine X is called are "bad" because they
> lead to all sorts of problems when that statement becomes false later.
> 
> In the most "morally erect" interface design, the implementer of a module
> would never have to worry about locking anything, or at least about the
> current lock-state of anything.

How can you say that?  Sure, an ideal module might not need to
worry about locks used by "others", but it might need a lock
of its own - one that didn't exist prior to the module.
Surely the implementor must know about this lock and
when to use it.  The module's interface
may, after all, be called simultaneoulsy on quite a few
cpus.

> In the morally perfect universe, the
> declarative statement "lock that thing there" would be a smart operator that
> would know what all locks, in what dependency orders, needed to be acquired
> to "lock that thing there" and the system could execute that pathway of
> locking automagically.
> 
Such a smart operator is an interesting excercise, but can it be made 
about as
lightweight as the current locks?  It is otherwise bad, because
understanding the kernel locking isn't black magic - only work.

> Of course, in such a world, the domestic swine would be useful as a bulk
> passenger carrier because of the easy way it traverses the sky...
:-)

> In the current design "we" demand that each designer learn and know what is
> locked and what is not.  "We" have documents about how in version X the duty
> to lock thing Y has been shifted from outside routine Z to inside.
> 
> Recursive locks (and a well defined resource allocation order, but who am I
> kidding) would actually be a benefit to all on both sides of most _info and
> _op structures, they would insulate design changes and improve portability.
> 
> A design where I lock things for only as long as I need them is optimal for
> that contention.
> 
> If my caller does the same, regardless of my actions then his code is
> optimal for those contentions too.
> 
> If neither is concerned with the other's needs then the lock intervals are
> demand based and will tend to allow the bodies of code to be improved on a
> "purely local" basis.
> 
> To achieve that, you need recursive locking.
Or a wrapper function that takes the lock and
calls the function that assumes the lock is taken.
You need to know which to use - but that isn't so
incredibly hard, and you avoid the overhead of
taking a lock twice.  (bus lockeed memory access is slow,
conditional jumps...)

> I don't think for an instant that we are going to get recursive locking, but
> it does make the specification of interfaces better.
> 
> It's only real down side is that it lets the lazy and the sloppy get away
> with too much before getting burned.  Recursive locking plus a "lock
> everything I *might* touch because my callees wont care" mentality leads to
> overlocking and hard-to-find deadlocks.  Everything looks and works find for
> a while until everybody, willing to pre-reserve facilities for all their
> callees, starts building pool-straddling devices (USB Hard Drives, Network
> Extensible File Systems, etc) and only finding their deadlocks late in the
> game when things get tangled.
> 
> so we wont get recursive locking because of the 02% people who can't be
> trusted with it.
> 
> But that doesn't make the recursive locking facility anything less than
> superior for defining and implementing superior interfaces.

Too much abstraction isn't superior.

Helge Hafting

