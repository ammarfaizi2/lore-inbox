Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132137AbQLHUlt>; Fri, 8 Dec 2000 15:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132282AbQLHUlj>; Fri, 8 Dec 2000 15:41:39 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:52927 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S132137AbQLHUlf>; Fri, 8 Dec 2000 15:41:35 -0500
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH,preliminary] cleanup shm handling
In-Reply-To: <20295.976288425@warthog.cygnus>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <20295.976288425@warthog.cygnus>
Message-ID: <m3zoi6pvh1.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 08 Dec 2000 21:04:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> Can you help me with an SHM related problem?
> 
> I'm currently writing a Win32 emulation kernel module to help speed Wine up,
> and I'm writing the file mapping support stuff at the moment
> (CreateFileMapping and MapViewOfFile).

These two calls were exactly the reasons to make the shm fs for
linux. It makes posix shm possible which provides shm_open an
shm_unlink. This together with mmap and frtuncate gives you exactly
this functionality.

shm_open and shm_unlink are provided by glibc 2.2. If you don't want
to rely on that, you can use open ("/dev/shm/xxx") and hope that the
admin configured right.

> I have PE Image mapping just about working (fixups, misaligned file
> sections and all), but I'm trying to think of a good way of doing
> anonymous shared mappings without having to hack the main kernel
> around too much (so far I've only had to add to kernel/ksyms.c).
> 
> Is there a reasonable way I could hook into the SHM system to
> "reserve" a chunk of shared memory of a particular size, and then a
> second hook by which I can "map" _part_ of that into a process's
> address space?

Yes:

fd = shm_open ("xxx",...)
ptr = mmap (NULL, size, ..., fd, offset);

No kernel changes necessary on 2.4 any more.

Greetings
                Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
