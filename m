Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266311AbUIWRKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266311AbUIWRKN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 13:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268165AbUIWRJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 13:09:10 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:32398 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268155AbUIWRDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 13:03:46 -0400
Subject: Re: __attribute__((always_inline)) fiasco
From: Albert Cahalan <albert@users.sf.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, rth@twiddle.net
In-Reply-To: <20040923165026.GF9106@holomorphy.com>
References: <1095956778.4966.940.camel@cube>
	 <20040923165026.GF9106@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1095958739.4973.948.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Sep 2004 12:59:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-23 at 12:50, William Lee Irwin III wrote:
> On Thu, Sep 23, 2004 at 12:26:18PM -0400, Albert Cahalan wrote:
> > #define INLINE
> > #define INLINE inline
> > #define INLINE static inline  // an oxymoron
> > #define INLINE extern inline  // an oxymoron
> > #define INLINE __force_inline
> > #define INLINE __attribute__((always_inline))
> > #define INLINE _Pragma("inline")
> > #define INLINE __inline_or_die_you_foul_compiler
> > #define INLINE _Please inline
> 
> The // apart from being a C++ ism (screw C99; it's still non-idiomatic)

Once you get over the initial jolt of seeing new syntax,
you'll find that C99 comments are clearly superior.

Even with block comments above functions, you'll typically
save two lines of screen space. (and 7 bytes)

I think the only trouble is assembly code abusing
the C (note: "C", not "assembly") pre-processor.

> will cause spurious ignorance of the remainder of the line, which is
> often very important. e.g.
> 
> static INLINE int lock_need_resched(spinlock_t *lock)
> {

Huh? Sure? It works for me:

albert 0 /tmp$ cat slash.c
#define MAIN main // test C99 comment
int MAIN (int argc, char *argv[]){
(void)argc;
(void)argv;
return 0;
}
albert 0 /tmp$ gcc -Wall -W -O2 slash.c
albert 0 /tmp$ ./a.out
albert 0 /tmp$ gcc -v
Reading specs from /usr/lib/gcc-lib/powerpc-linux/3.2.3/specs
Configured with: ../src/configure -v --enable-languages=c,c++,java,f77,objc,ada --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-gxx-include-dir=/usr/include/c++/3.2 --enable-shared --with-system-zlib --enable-nls --without-included-gettext --enable-__cxa_atexit --enable-clocale=gnu --enable-java-gc=boehm --enable-objc-gc powerpc-linux
Thread model: posix
gcc version 3.2.3 20030415 (Debian prerelease)


