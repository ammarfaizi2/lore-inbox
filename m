Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287909AbSAMBjB>; Sat, 12 Jan 2002 20:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287907AbSAMBiu>; Sat, 12 Jan 2002 20:38:50 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:13468 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S287436AbSAMBik>;
	Sat, 12 Jan 2002 20:38:40 -0500
Date: Sat, 12 Jan 2002 20:38:27 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Juan Quintela <quintela@mandrakesoft.com>
cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
        felix-dietlibc@fefe.de, andersen@codepoet.org
Subject: Re: [RFC] klibc requirements, round 2
In-Reply-To: <m2r8ovjpey.fsf@trasno.mitica>
Message-ID: <Pine.GSO.4.21.0201122032250.24774-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 12 Jan 2002, Juan Quintela wrote:

> >>>>> "greg" == Greg KH <greg@kroah.com> writes:
> 
> Hi
> 
> greg> To summarize, here's a partial list of the programs people want to run:
> greg> - mount

	I _really_ doubt it.  /init calling mount(2) - sure, but mount(8)?
Not really.

> greg> - hotplug
> greg> - busybox
> greg> - dhcpcd
> greg> - image viewer
> greg> - mkreiserfs
> greg> - partition discovery (currently in the kernel)

Assuming that it moves to userland, which is non-obvious.  Going other
way (i.e. clean kernel API for parsing _and_ changing partitioning)
might be better.  Current mechanisms for notifying kernel about partition
table changes are really gross.

> greg> - lots of other, existing in kernel code.

nfsroot mounting (socket/sendto/recvfrom/open/close/read/write/malloc/free/
snprintf/memcpy/strlen/mount).

> I still think that fsck at this point will be great.  You will
> minimize the need to have the kernel special case for fsck the root fs
> with respect to the rest of fs.

_Kernel_ has no special-casing of that kind.

