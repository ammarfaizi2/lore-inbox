Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261642AbSKRIOs>; Mon, 18 Nov 2002 03:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbSKRIOs>; Mon, 18 Nov 2002 03:14:48 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:11392
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S261642AbSKRIOq>; Mon, 18 Nov 2002 03:14:46 -0500
Message-ID: <3DD8A306.3040109@redhat.com>
Date: Mon, 18 Nov 2002 00:21:26 -0800
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luca Barbieri <ldb@ldb.ods.org>
CC: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
References: <Pine.LNX.4.44.0211172003050.1206-100000@home.transmeta.com> <1037606831.1774.13.camel@ldb>
In-Reply-To: <1037606831.1774.13.camel@ldb>
X-Enigmail-Version: 0.65.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Barbieri wrote:

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> There are: suppose that you want to implement the int cfork(int* pid)
> function, which returns the pid in *pid in the parent vm, in a
> multithreaded application.

Correct, for a cfork() implementation two separate pointers would be
needed.  Ingo was asking the same question.

Note that I haven't received a request for such a fork interface variant
yet.  There obviously is a problem with fork() in MT apps but people are
either not hitting it or working around it.  In any case, cfork() would
at least for the time being Linux-specific anyway.


If people are in fact interested in such a new interface then you should
start asking Linus to change his mind on the second parameter.  I'm at
this point in time neutral since there is no urgent need from my
perspective to implement cfork(),

> You could avoid the additional pointer by letting
> child_tidptr = (!(flags & CLONE_VM) && current->user_tid) ?
> current->user_tid : parent_tidptr;

This doesn't work since it would overwrite the TID field in the calling
thread's descriptor.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE92KMJ2ijCOnn/RHQRAqciAKCCZanzvzkgEND8YdMt9Q79V5DWlwCgikX/
W1RMEu4Vz8KQn0BlIZ7zlFo=
=Hkaz
-----END PGP SIGNATURE-----

