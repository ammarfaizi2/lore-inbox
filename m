Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265508AbSKTBeX>; Tue, 19 Nov 2002 20:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267276AbSKTBeX>; Tue, 19 Nov 2002 20:34:23 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:15244
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S265508AbSKTBeW>; Tue, 19 Nov 2002 20:34:22 -0500
Message-ID: <3DDAE822.1040400@redhat.com>
Date: Tue, 19 Nov 2002 17:40:50 -0800
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021118
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Luca Barbieri <ldb@ldb.ods.org>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading enhancements, tid-2.5.47-C0
References: <Pine.LNX.4.44.0211181303240.1639-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0211181303240.1639-100000@localhost.localdomain>
X-Enigmail-Version: 0.65.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus,

could you please make a decision regarding this?  I'd like to make a new
nptl release which fixes the bug this patch helps to fix so that we get
testing (also of the kernel issues).

Ingo's last patch has two pointer, one for the parent and one for the
child.  The is necessary (despite what Jamie tried to argue) if we want
to have a cfork() implementation which works in MT applications.
cfork() is IMO really necessary if you want to mix threads and fork().

Assume you have an application which forks children and assosicates
certain actions with the termination of a child.  When SIGCHLD is
received one of the threads of the app searches, using the PID of the
terminated child, which action has to be performed.  It wouldn't find
anything if the thread, which created the child, hasn't yet written the
PID of the child in the appropriate memory location.  This can very well
happen and can only be fixed by the kernel writing the PID values.

If you don't agree with this and want to have exactly one pointer, do
you insist on making CHLID_CLEARTID include CHILD_SETTID?  I don't see
how this can be useful since unless you also require the CHILD_SETTID
includes CHILD_CLEARTID you still need at least a flag saying the
CLEARTID is not enabled.  The alternative is to merge the SET and CLEAR
flag for the child which would mean no functionality like cfork() could
ever be implemented.


Anyway, please let us know your current position.  Thanks,

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE92ugi2ijCOnn/RHQRAqDQAJ48o5cbgZMvSJYG7G5z9qTfPJ2WwwCfXlJc
jVgLoqqyeCfUrkzTKwWZrAc=
=dKh2
-----END PGP SIGNATURE-----

