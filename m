Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132137AbRCVSWr>; Thu, 22 Mar 2001 13:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132139AbRCVSWh>; Thu, 22 Mar 2001 13:22:37 -0500
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:47082 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S132137AbRCVSWW>; Thu, 22 Mar 2001 13:22:22 -0500
From: cjw44@flatline.org.uk (Colin Watson)
To: Richard Guenther <richard.guenther@student.uni-tuebingen.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: How to mount /proc/sys/fs/binfmt_misc ?
In-Reply-To: <Pine.LNX.4.30.0103201108440.595-100000@fs1.dekanat.physik.uni-tuebingen.de>
In-Reply-To: <Pine.LNX.4.30.0103201108440.595-100000@fs1.dekanat.physik.uni-tuebingen.de>
Organization: riva.ucam.org
Message-Id: <E14g9p0-0005yj-00@riva.ucam.org>
Date: Thu, 22 Mar 2001 18:28:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Guenther <richard.guenther@student.uni-tuebingen.de> wrote:
>On Mon, 19 Mar 2001, Colin Watson wrote:
>> Or you can register binfmt names that are registered already and
>> silently shadow old ones, or register names like 'register', 'status',
>> '.', and '..'. It's hideous to manage reliably from userspace.
>
>I know you have sent me patches to prevent multiple entries of the
>same name some time ago and I can see we argued about it. The main
>point I have with such checks is, that we dont prevent root from
>doing rm -Rf / either. There is no reason to clobber the kernel with
>endless checks of such cornercases (which even dont make the system
>unusable, but only one (unimportant) part of it). There is even one
>truely nasty "exploit" of binfmt_misc, if you register an entry
>that catches standard elf programs and do module insertion of the
>elf and misc handler in the right order... how would you catch this!?

Indeed, you can't, certainly not easily. I realize there are lots of
ways root can shoot himself in the foot no matter what you do. However,
I don't think that this is a good reason not to do some fairly
elementary consistency checks (just because root can break things one
way is no reason not to try to prevent other mistakes, and I'm also
trying to export a consistent and vaguely reliable interface to other
packages).

I would very much like to be able to assume that a filesystem never
contains two identical filenames linking to different inodes, and that
any . and .. links I find always point to things that are vaguely like
directories! I realize that you can't assume much about /proc, and that
the kernel shouldn't spend forever checking it, but I would hope that
it's generally expected to conform to basic rules of sanity. I'd like my
binfmt_misc management tool to be able to say "OK, beware that you can
screw up your system with this - but if you ask me for a status report
I'll be able to deliver the right answer". That's what I mean by "manage
reliably". As it is, I can only guarantee that I'll give the right
answer to status reports or be able to successfully register and
unregister even sane binary formats if my program is the only interface
being used to binfmt_misc, and I'm not doing any expensive checks.

-- 
Colin Watson                                     [cjw44@flatline.org.uk]
