Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316600AbSE3MJC>; Thu, 30 May 2002 08:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSE3MJB>; Thu, 30 May 2002 08:09:01 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:48079 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S316600AbSE3MI7>;
	Thu, 30 May 2002 08:08:59 -0400
Date: Thu, 30 May 2002 22:08:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Linus <torvalds@transmeta.com>,
        Trivial Kernel Patches <trivial@rustcorp.com.au>
Subject: Re: missing bit from signal patches
Message-Id: <20020530220828.3c3192cd.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.21.0205300959050.17583-100000@serv>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On Thu, 30 May 2002 10:04:03 +0200 (CEST) Roman Zippel <zippel@linux-m68k.org> wrote:
>
> On Thu, 30 May 2002, Stephen Rothwell wrote:
> 
> > The following should allow the affected architectures to build in
> > 2.5.19 as currently there will be two definitions of
> > copy_siginfo_to_user.
> 
> There are other build problems. m68k doesn't compile, because siginfo_t is
> defined after the generic include and the inline functions in there access
> that structure. On the other hand I can't put the include after the
> definition, as it depends on other defines in the include.
> I worked around it with some ugly hacks, but a proper fix would be very
> welcome.

Is the following a more ugly hack than yours?

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.19-si/include/asm-generic/siginfo.h 2.5.19-si.3/include/asm-generic/siginfo.h
--- 2.5.19-si/include/asm-generic/siginfo.h	Thu May 30 09:44:38 2002
+++ 2.5.19-si.3/include/asm-generic/siginfo.h	Thu May 30 22:04:54 2002
@@ -64,7 +64,11 @@
 	} _sifields;
 } siginfo_t;
 
-#endif
+#else /* HAVE_ARCH_SIGINFO_T */
+
+struct siginfo;
+
+#endif /* HAVE_ARCH_SIGINFO_T */
 
 /*
  * How these fields are to be accessed.
