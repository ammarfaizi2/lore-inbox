Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265683AbSKTD5m>; Tue, 19 Nov 2002 22:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265689AbSKTD5m>; Tue, 19 Nov 2002 22:57:42 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:53900
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S265683AbSKTD5h>; Tue, 19 Nov 2002 22:57:37 -0500
Message-ID: <3DDB09C2.3070100@redhat.com>
Date: Tue, 19 Nov 2002 20:04:18 -0800
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021118
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading enhancements, tid-2.5.47-C0
References: <Pine.LNX.4.44.0211181303240.1639-100000@localhost.localdomain> <3DDAE822.1040400@redhat.com> <20021120033747.GB9007@bjl1.asuk.net>
In-Reply-To: <20021120033747.GB9007@bjl1.asuk.net>
X-Enigmail-Version: 0.65.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jamie Lokier wrote:

> This is "int cfork(pid_t * user_tid_ptr)", yes?  I've searched google for
> cfork and not found anything fruitful - just references to solaris
> patches about a function of the same name.

It's just a coincident.  I made the name up and there is no function
like that so far, at least as far I know.


> Then yes, you need two pointers, one for the parent's cfork() argument
> for SETTID in the parent, and one for the child's thread descriptor
> for CLEARTID in the child.  Strictly speaking, SETTID does not need to
> affect the child (because the child can store the tid itself), but it
> would make a lot of sense to do it.

The CHILD_SETTID is needed, too, since otherwise the PID isn't stored in
the child's thread descriptor.


> (That said, I'm not entirely convinced that blocking signals in cfork()
> is so bad, if we assume that cfork() is a relatively expensive
> operation anyway...)

It could mean a signal cannot be delivered and reacted on in time.  The
other threads could have blocked the signal which arrives.  Every time
signals have to be blocked to implement a function something is wrong,

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE92wnC2ijCOnn/RHQRAqDqAJ9gfHvRN/Lz04EXd04h4VdcNlWjWgCghEjG
Cuf+eoUKcJ+9+BcyqpeY/sU=
=iW0/
-----END PGP SIGNATURE-----

