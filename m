Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268983AbTBWVlX>; Sun, 23 Feb 2003 16:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268984AbTBWVlX>; Sun, 23 Feb 2003 16:41:23 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:2828 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S268983AbTBWVlV>;
	Sun, 23 Feb 2003 16:41:21 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200302232151.h1NLp1x260213@saturn.cs.uml.edu>
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
To: procps-list@redhat.com
Date: Sun, 23 Feb 2003 16:51:01 -0500 (EST)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, alexl@redhat.com,
       viro@math.psu.edu, mingo@redhat.com
In-Reply-To: <Pine.LNX.4.44.0302231935350.6674-100000@localhost.localdomain> from "Ingo Molnar" at Feb 23, 2003 07:49:41 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:
> On 22 Feb 2003, Albert Cahalan wrote:

>>> architecture-wise there is a difference, and i'd be
>>> the last one arguing against a tree-based approach to
>>> thread groups. It's much easier to find threads belonging
>>> to a single 'process' via /proc this way - although no
>>> functionality in procps has or requires such a feature currently.
>>
>> Nope, the /proc/123/threads/246/stat approach is required.
>> Without this, procps is forced to read _all_ tasks to group
>> threads together. This is slow, prone to race conditions,
>> more vulnerable to kernel bugs, and a memory hog.
>
> actually, what you mention does not happen in practice.
> We coded it up and it works,

Surely you realize that I have seen this code?

Proper "ps m" behavior groups threads in the output.
The hacked-up procps being used by Red Hat fails to
do this. You chould change that... at the cost of reading
all processes and sorting them. There goes all of your
performance improvement.

I hope you will eliminate the Red Hat bias in future patches.
Using the subdirectory approach certainly won't hurt you.
In time, you will realize that it is needed, or you will
switch over to using procps 3. Several distributions have
recently switched; I doubt you can hold out forever.

(I'd still like to know why Red Hat broke "sort -n" once.
What is it with you guys mucking up the most basic tools?)

BTW, proper thread support in ps includes the "-T" and
"-L" options. There's more too. I know this; nobody
doing procps-2 work has a clue. You're living in the
same Linux-only world that made procps-1 so hated for
incompatibility with the rest of the world. Sys admins
like to write scripts that run on everything they use.

>> (next time, discuss such changes with an experienced
>> procps developer first)
>
> (given that this whole area was left alone in a state
> like this for years i'm not quite sure how you can still
> sit so high on your horse.)

What area, in what state? If you mean procps in general:

I've been maintaining upstream procps for Debian for years.
The project was kept quiet out of politeness to the former
maintainer, who didn't want to let go of the project. Now
that the former maintainer is clearly not coming back, I've
put my tree at http://procps.sf.net/ for all to use. I am
after all the original author of ps itself, so I'm one to
know what is required for correct and efficient operation.

If you mean the threading support specifically:

The kernel does not provide proper support for grouping
threads by process. Hacks exist to group them anyway,
but such hacks will falsely group similar tasks and will
fail to group tasks due to race conditions. The hacks are
also slow. As none of this is acceptable in a critical
system tool, task grouping is not currently available. 

There's a need for responsibility here. One shouldn't just
throw unreliable hacks into a critical system tool.

The FAQ covers some of this and more.
http://procps.sourceforge.net/faq.html

Linux-kernel readers should note that only procps-3 can
handle the very latest kernels. No procps-2 release is
able to do so, in more than one way.


