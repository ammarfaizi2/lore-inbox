Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261618AbTCOWON>; Sat, 15 Mar 2003 17:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261619AbTCOWON>; Sat, 15 Mar 2003 17:14:13 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:56759
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S261618AbTCOWOL>; Sat, 15 Mar 2003 17:14:11 -0500
Message-ID: <3E73A83C.2070000@redhat.com>
Date: Sat, 15 Mar 2003 14:25:00 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Hammer thread fixes
References: <3E739514.8010300@redhat.com> <20030315212438.GA8113@wotan.suse.de>
In-Reply-To: <20030315212438.GA8113@wotan.suse.de>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andi Kleen wrote:

> It's incorrect like I told you last time. arg 4 is in r10. Linus please don't
> apply.

Of course is arg 4 in r10.



> The clone prototype is 
> 
> 	int clone(int flags, unsigned long newsp, void *parent_tid, void *child_tid) ;

That's the prototype in process.c.  From the user level it is

int clone(int flags, unsigned long newsp, void *parent_tid, void
*child_tid, void *tlsaddr)


> 
> 	rax: __NR_clone
> 	rdi: flags
> 	rsi: newsp 
> 	rdx: parent_tid
> 	r10: child_tid

You don't get it.  The parameter which is passed on is the TLS address
which does not appear in the parameter list but is passed in the *fifth*
parameter.  TLS address != child_tid!  The patch is correct and
regardless of what ak said, please apply it.  Unlike ak's claims it is
actually tested.  I'm running such a kernel and threads actually work
(unlike with the original kernel).

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+c6g82ijCOnn/RHQRApE+AJ9Aus8jJBg81L2A12ghG89HmfPz1wCgyldz
NUazXDCnqkvJ3qWAGkNbY9U=
=u/Oe
-----END PGP SIGNATURE-----

