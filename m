Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283496AbRLHSBq>; Sat, 8 Dec 2001 13:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283245AbRLHSBm>; Sat, 8 Dec 2001 13:01:42 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17670 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283496AbRLHSBY>; Sat, 8 Dec 2001 13:01:24 -0500
Date: Sat, 8 Dec 2001 10:00:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix for idiocy in mount_root cleanups.
In-Reply-To: <Pine.GSO.4.21.0112080632020.6180-100000@binet.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0112080957530.16918-100000@athlon.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 Dec 2001, Alexander Viro wrote:
>
> 	Change in question was s/do_mount/mount/.  Which is almost
> the same thing, except for one little detail:  mount(2) in case of
> error returns -1 and stores the error in errno.  do_mount(9), OTOH...

Don't use errno in the kernel. EVER. This is a bug, we should get rid of
it.

Please fix "mount()" instead.

"errno" is one of those few _really_ bad stupidities in UNIX. Linux has
fixed it, and doesn't use it internally, and never shall. Too bad that
user space has to fix up the _correct_ error code returning that the
kernel does, and turn it into the "errno" stupidity for backwards
compatibility.

(If you care why "errno" is stupid, just think about threading and
performance)

		Linus

