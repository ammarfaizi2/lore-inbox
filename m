Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTETA2O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263235AbTETA2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:28:14 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:20622
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263152AbTETA2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:28:12 -0400
Message-ID: <3EC97996.1080800@redhat.com>
Date: Mon, 19 May 2003 17:40:54 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030516
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3
References: <20030520001623.715822C08B@lists.samba.org>
In-Reply-To: <20030520001623.715822C08B@lists.samba.org>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Rusty Russell wrote:

> 1) Overload the last futex arg (change from timeval * to void *),
>    don't add YA arg at the end.

It wasn't Ingo's idea.  I suggested it.  Overloading parameter types is
evil.  This isn't an issue anymore if the extension is implemented as a
new syscall which certainly is better.


> 2) Use __alignof__(u32) not sizeof(u32).  Sure, they're the same, but
>    you really mean __alignof__ here.

I would always use sizeof() in this situation.  alignof is a property
the compiler can potentially relax.  On x86 it could easily be defined
to 1 in case someone wants to save memory.  OK, not really useful for
x86, but some embedded archs might be in such a situation.  Using
sizeof() makes sure that the variable is always 4-byte aligned.  For
atomic operations this certainly is a good minimal requirement.

If you want to really correct you might have to introduce something like
atomic_alignof().

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+yXmW2ijCOnn/RHQRAnXcAKCeYFvfkKIO/bbwqX1vUvbLkBvHKwCeN6zB
99qZZOVLMckvh6lxieUfVpY=
=LvwT
-----END PGP SIGNATURE-----

