Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267596AbSKQU2Q>; Sun, 17 Nov 2002 15:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267595AbSKQU2Q>; Sun, 17 Nov 2002 15:28:16 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:62592
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S267596AbSKQU2N>; Sun, 17 Nov 2002 15:28:13 -0500
Message-ID: <3DD7FD86.7000407@redhat.com>
Date: Sun, 17 Nov 2002 12:35:18 -0800
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Luca Barbieri <ldb@ldb.ods.org>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
References: <Pine.LNX.4.44.0211172212001.18431-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0211172212001.18431-100000@localhost.localdomain>
X-Enigmail-Version: 0.65.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ingo Molnar wrote:
> But i think you are one of
> the few peoples who are running an NPTL system (ie. with the new
> NPTL-glibc actually installed as the default system glibc) - is binary
> compatibility important to you for this specific case?

It's all encapsulated in the libpthread which is used.  No apps need to
be recompiled so it is OK to make this incompatible change.


> we could do that - although we cannot fail the CHILD_SETTID variant, and i
> wanted to keep it symmetric.

I cannot see any reasonable way out if any of the put_user calls fail?
Do you want the clone() call to fail if the parent's receiving address
is wrong?  You'd have to go and kill the child again since it's already
created.

Instead let the user initialize the memory location the clone call is
supposed to write in with zero.  if the value didn't change the
user-level code can detect the error and handle appropriately.  So,
ignore the put_user errors.  Maybe say so explicitly and add (void) in
front.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE91/2G2ijCOnn/RHQRAt34AKCrzkjdPfQ3D1VvEXPW5fwZxmCvWgCgmY0A
IYWZflwRcxusjo4fMPOx6jk=
=xjs0
-----END PGP SIGNATURE-----

