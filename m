Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbTDHXo6 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 19:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTDHXo6 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 19:44:58 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8715 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262594AbTDHXoz (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 19:44:55 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 64-bit kdev_t - just for playing
Date: 8 Apr 2003 16:56:00 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b6vnig$q86$1@cesium.transmeta.com>
References: <20030408195305.F19288@almesberger.net> <Pine.LNX.4.44.0304081607060.5766-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0304081607060.5766-100000@dlang.diginsite.com>
By author:    David Lang <david.lang@digitalinsight.com>
In newsgroup: linux.dev.kernel
>
> the biggest problem I see with dynamic numbers is that it needs a
> userspace devfs type solution for creating and maintaining the device
> nodes that are then used. While this isn't rocket science it's also
> somthing that is hard to get people to agree to (remember the devfs names
> that everyone gripes about are not what richard started with it's what he
> switched to to get things into the kernel, they changed many times during
> that process)
> 
> I don't think many people will argue that dynamic assignments are evil,
> but I think you will find a lot of people very nervous about switching to
> them and the risk involved with doing so.
> 

They aren't evil, they're just very, very hard to get right.

So far, *none* of the schemes used for dynamics have gotten it right.
They just ignore a fair number of the problems.  People keep focusing
on disks, and they are nearly uniformly the almost-trivial case in
comparison with especially character devices, where you don't have the
layer of indirection called /etc/fstab, persistent labels, etc.

It is also independent of the need to switch to a larger dev_t.
Claiming that we can squeeze more out of the existing device scheme if
we have an ideal-world dynamic scheme is unrealistic because:

a) There are, genuinely, systems with more than 65,536 devices or
anonymous mounts.  That rules out the current dev_t just by itself.

b) Despite the fact that people have tried since the mid-90's, we
still don't have a sane way to manage such dynamicity.

c)  We are now in what pretty much amounts to a crisis situation.  We
have needed to enlarge dev_t for well over half a decade.  Therefore,
it is too late to say "well, given X we wouldn't need it."  We need
something done in *this* kernel cycle.

Given that it has taken, literally, 8 years to get to this point, and
based on collective global experience with numberspaces, I'm arguing
for enlarging it far more than anyone can currently imagine being
necessary.

dev_t is already 64 bits in glibc, and the glibc<->kernel interface
needs to be fixed *anyway*.  We have to take the pain of migration, we
might as well go all the way.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
