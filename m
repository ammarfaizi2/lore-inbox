Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265411AbSJSACP>; Fri, 18 Oct 2002 20:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265412AbSJSACP>; Fri, 18 Oct 2002 20:02:15 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:13800 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265411AbSJSACK>; Fri, 18 Oct 2002 20:02:10 -0400
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH][RFC] 2.5.42 (1/2): Filesystem capabilities kernel patch
References: <Pine.GSO.4.21.0210181845281.21677-100000@weyl.math.psu.edu>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Sat, 19 Oct 2002 02:07:56 +0200
Message-ID: <87d6q7mgtf.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> writes:

> On Fri, 18 Oct 2002, Olaf Dietsche wrote:
>
>> This patch adds filesystem capabilities to 2.5.42, but it applies to
>> 2.5.43 as well.
>> 
>> It's very simple. In the root directory of every filesystem, there
>> must be a file named ".capabilities". This is the capability database
>> indexed by inode number. These files are populated by a chcap tool,
>> see next mail.
>> 
>> This fs capability system should work on all filesystem, which can
>> provide long dotted names and have some sort of inode. Another benefit
>> is, when holes in files are allowed. Otherwise the .capabilities file
>> could grow pretty large.
>> 
>> I use this on an ext2 filesystem. It boots and seems to work so far.
>> 
>> Comments?
>
> His-fscking-terical.

Yes, I like it very much, too ;-)

> Seriously, what comments do you expect?

Seriously, I'm more or less a newbie in this area, so I want thoughts
and suggestions from more experienced people. That's what this list is
about, isn't it?

> To start
> with, on a bunch of filesystems inode numbers are unstable.

Not really a problem, so restrict it to stable inode systems only.

> Moreover,
> owner of that file suddenly gets _all_ capabilities that exist in the
> system,

Yup, like root for example.

> ditto for any task capable of mount(2),

How's that? I think this task must own the filesystem and root
directory too.

> ditto for owner of
> root directory on some filesystem.

Which is a problem for foreign (network) filesystems only. Should be
solvable with a mount option (i.e. mount -o nocaps ...).

> And there is no way to recognize
> that file as such, so additional checks on write(), mount(), unlink().
> etc. are not possible.

Depends on, wether I want to recognize it and do these checks. Anyway,
could be solved with a mount option too or something like quotactl(2)
maybe.

> And that is not to mention that binding of
> non-root will play silly buggers with the entire scheme.

I don't understand this sentence. What do you mean with "binding of
non-root"?

> IOW, idea is unsalvagable.

I'm working on it. Thanks for sharing your thoughts.

Regards, Olaf.
