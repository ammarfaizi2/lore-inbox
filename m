Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266952AbTCEWw7>; Wed, 5 Mar 2003 17:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266968AbTCEWw7>; Wed, 5 Mar 2003 17:52:59 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:28636
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S266952AbTCEWwy>; Wed, 5 Mar 2003 17:52:54 -0500
Message-ID: <3E668267.5040203@redhat.com>
Date: Wed, 05 Mar 2003 15:04:07 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030303
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Better CLONE_SETTLS support for Hammer
References: <3E664836.7040405@redhat.com> <20030305190622.GA5400@wotan.suse.de> <3E6650D4.8060809@redhat.com> <20030305212107.GB7961@wotan.suse.de>
In-Reply-To: <20030305212107.GB7961@wotan.suse.de>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andi Kleen wrote:

>>1. every process will already use the prctl(ARCH_SET_FS).  We are
>>talking here only about the 2nd thread and later.  We need to use
>>prctl(ARCH_SET_FS) for TLS support.
> 
> 
> Not when you put it into the first four GB. Then you can use the same
> calls as 32bit.

Show me numbers.  Or even better: fix the kernel so that I can run it
myself.  What is the time difference between using the segment register
switching with all the different allocated thread areas version using wrmsr.


*Iff* using the MSR is slower, as far as I'm concerned the
set_thread_area syscall should complete go away from x86-64.  Require
the use of prctl to get and set the base address.  Then internally in
the prctl call map it to either the use of a 32 base address segment or
use the MSR.

This way whoever needs a segment base address can preferably allocate it
in the low 4GB, but if it fails the kernel support still work.  And with
the same interface.  Currently this is not the case and this is not
acceptable.


>>2. May I remind you that you were in the crowd who complained when we
>>requested a dedicated thread register?  Yes, I still would prefer that
>>but I have no energy to battle for that.
> 
> 
> I don't see the connection.

I wouldn't want to either in your position.  You caused this whole mess
and now you're not willing to fix it.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+ZoJn2ijCOnn/RHQRAtZRAKCFYu1q0IX92o7axPFqK8YuYIdISACfaA1M
TnmREkEevHxAfrhNWYk9uZs=
=ivkl
-----END PGP SIGNATURE-----

