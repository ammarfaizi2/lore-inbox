Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274160AbRISUPG>; Wed, 19 Sep 2001 16:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274161AbRISUOz>; Wed, 19 Sep 2001 16:14:55 -0400
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:27011 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S274160AbRISUOq>; Wed, 19 Sep 2001 16:14:46 -0400
Date: Wed, 19 Sep 2001 13:14:30 -0700 (PDT)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Fabian Arias <dewback@vtr.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.9-ac12 - problem mounting reiserfs (parse error?)
In-Reply-To: <20010919132935.M14526@turbolinux.com>
Message-ID: <Pine.LNX.4.33.0109191304190.16915-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001, Andreas Dilger wrote:

> Could you run gdb on your mount and show us what *data contains at
> this point (last parameter).  According to man(8) "defaults" expands
> to "rw,suid,dev,exec,auto,nouser,async".

Hmm, I'm not versant with gdb (strace is the extent of my sophistication),
so I'll try your suggestion below.

> You could also try putting all of these in /etc/fstab explicitly and
> remove them one at a time until we find which one it is complaining
> about.  Either mount(8) shouldn't be appending this option to the
> mount data, or reiserfs needs to parse it in the kernel.

It seems that the reiserfs option parsing in 2.4.9-ac12 is foobar, as any
one of "rw,suid,dev,exec,auto,nouser,async" in the options field in
/etc/fstab causes the mount to fail.  Also, mounting an r5-hashed reiserfs
file system with the option string "hash=r5" gives this fine error:

REISERFS: Error, r5 hash detected, unable to force r5 hash

I can confirm that the following option strings give a successful mount:
"conv", "hashed_relocation", "notail".  I didn't feel like going through
all the options possible.

Is everybody seeing this, or is specific to something about my setup, e.g.
gcc version 3.0.2 20010905 (Red Hat Linux 7.1 3.0.1-3)?  I'll try
recompiling with gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-97.1)
to check that.

Cheers, Wayne

