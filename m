Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280659AbRKBLq4>; Fri, 2 Nov 2001 06:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280660AbRKBLqq>; Fri, 2 Nov 2001 06:46:46 -0500
Received: from [195.63.194.11] ([195.63.194.11]:25612 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S280658AbRKBLq3>; Fri, 2 Nov 2001 06:46:29 -0500
Message-ID: <3BE29401.157394A5@evision-ventures.com>
Date: Fri, 02 Nov 2001 13:39:29 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Rusty Russell <rusty@rustcorp.com.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
In-Reply-To: <Pine.GSO.4.21.0111020359540.12621-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Fri, 2 Nov 2001, Rusty Russell wrote:
> 
> > On Thu, 01 Nov 2001 05:42:36 -0500
> > Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> >
> > > Is this designed to replace sysctl?
> >
> > Well, I'd suggest replacing *all* the non-process stuff in /proc.  Yes.
> 
> Aha.  Like, say it, /proc/kcore.  Or /proc/mounts, yodda, yodda.
> 
>         Noble idea, but there is a little problem: random massive userland
> breakage.  E.g. changing /proc/mounts is going to hit getmntent(3), etc.
> 
>         If you are willing to audit all userland code - you are welcome.
> But keep in mind that standard policy is to keep obsolete API for at least
> one stable branch with warnings and remove it in the next one.  So we are
> talking about 2.8 here.  BTW, I'm less than sure that your variant is free
> of rmmod races, but that's a separate story...

Bull shit. Standard policy is currently to keep crude old
interfaces until no end of time. Here are some examples:

/proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  196005888 60133376 135872512        0  3280896 31088640
Swap: 410255360        0 410255360
MemTotal:       191412 kB
MemFree:        132688 kB
MemShared:           0 kB
Buffers:          3204 kB

The first lines could have gone 2 years ago.

/proc/ksyms - this is duplicating a system call (and making stuff easier
for intrusors)

/proc/modules - same as /proc/ksysms - entierly unneccessary and
obsolete,
since 3 years!

And so on and so on...
