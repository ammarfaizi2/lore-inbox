Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262790AbSJRCR7>; Thu, 17 Oct 2002 22:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262792AbSJRCR7>; Thu, 17 Oct 2002 22:17:59 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:30856
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S262790AbSJRCR5>; Thu, 17 Oct 2002 22:17:57 -0400
Message-ID: <3DAF70B5.5010208@redhat.com>
Date: Thu, 17 Oct 2002 19:23:49 -0700
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021014
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Mark Gross <markgross@thegnar.org>, Ingo Molnar <mingo@elte.hu>,
       Alexander Viro <viro@math.psu.edu>,
       S Vamsikrishna <vamsi_krishna@in.ibm.com>, linux-kernel@vger.kernel.org,
       NPT library mailing list <phil-list@redhat.com>
Subject: Re: [patch] thread-aware coredumps, 2.5.43-C3
References: <200210081627.g98GRZP18285@unix-os.sc.intel.com> <Pine.LNX.4.44.0210171009240.12653-100000@localhost.localdomain> <m33cr4pn56.fsf@averell.firstfloor.org> <200210171835.21647.markgross@thegnar.org> <20021018021242.GA15853@averell>
In-Reply-To: <200210081627.g98GRZP18285@unix-os.sc.intel.com>
X-Enigmail-Version: 0.65.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andi Kleen wrote:

> I want the x86 CPU error code, which often has interesting clues on
> the problem.
> trapno would be useful too. I suspect other CPUs have similar extended
> state for exceptions.


I don't know whether you refer to this but the si_erno and si_code field
of the elf_siginfo structure are currently not used.  They are filled
with zero all the time.


> Eventually (in a future kernel) I would love to have the exception
> handler save the last branch debugging registers of the CPU and the
> let the
> core dumper put that into the dump too.  Then you could easily
> figure out what the program did shortly before the crash.


One the 2.7 kernel development opens I hope *a lot* will change in the
core dump handling.  The current format isn't even adequate to represent
the currently represented information correctly (uid and gid are 16
bits) and there is other information which isn't even available.

I'm perfectly willing to consult anybody who wants to do some work in
this area.  Actually, the kernel side should be mostly simple, it "just"
means accessing and copying the right data.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9r3C22ijCOnn/RHQRAjIIAKCF8wlNJTAiHAjZPP8JdVHOI43NhQCfbqXc
9qmjBBZcjGEZX7CUUhGODqs=
=jIxX
-----END PGP SIGNATURE-----

