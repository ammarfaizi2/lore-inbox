Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281749AbRKQOJo>; Sat, 17 Nov 2001 09:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281751AbRKQOJe>; Sat, 17 Nov 2001 09:09:34 -0500
Received: from [217.9.226.246] ([217.9.226.246]:21377 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S281749AbRKQOJX>; Sat, 17 Nov 2001 09:09:23 -0500
To: linux-kernel@vger.kernel.org
Cc: gcc@gcc.gnu.org
Subject: i386 flags register clober in inline assembly
From: Momchil Velikov <velco@fadata.bg>
Date: 17 Nov 2001 16:06:22 +0200
Message-ID: <87y9l58pb5.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There are several inline assembly routines in the i386 port, which
clobber the flags register, nevertheless fail to declare that.
E.g. atomic_inc

	__asm__ __volatile__(
		LOCK "incl %0"
		:"=m" (v->counter)
		:"m" (v->counter));

should be

	__asm__ __volatile__(
		LOCK "incl %0"
		:"=m" (v->counter)
		:"m" (v->counter)
                : "cc");

since "incl" clobbers flags.

Any ideas if these functions should be corrected ?

Although gcc documentation says "cc" has no effect on some machines,
it seems this is not the case with i386, judging from the "(set (reg:CC 17) ..."
and "(clobber (reg:CC 17))" in i386.md.

Regards,
-velco


