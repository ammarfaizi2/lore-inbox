Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWIZVsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWIZVsf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 17:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWIZVse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 17:48:34 -0400
Received: from mse2fe2.mse2.exchange.ms ([66.232.26.194]:17307 "EHLO
	mse2fe2.mse2.exchange.ms") by vger.kernel.org with ESMTP
	id S964851AbWIZVsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 17:48:31 -0400
Subject: Re: [Kgdb-bugreport] compiling kernel with -O0 flag - Lets make it
	a config option!
From: Piet Delaney <piet@bluelane.com>
Reply-To: piet@bluelane.com
To: "Amit S. Kale" <amitkale@linsyssoft.com>, Andrew Morton <akpm@osdl.org>
Cc: Piet Delaney <piet@bluelane.com>, kgdb-bugreport@lists.sourceforge.net,
       emin ak <eminak71@gmail.com>
In-Reply-To: <200609261426.16481.amitkale@linsyssoft.com>
References: <2cf1ee820609211354m3ae2ec5btc7274402d84b5400@mail.gmail.com>
	 <1159219251.32095.143.camel@piet2.bluelane.com>
	 <2cf1ee820609260150o77d7759did8d38937669b356f@mail.gmail.com>
	 <200609261426.16481.amitkale@linsyssoft.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-c5MaqW8Jc4ejKUNDrSL2"
Organization: Blue Lane Technologies
Date: Tue, 26 Sep 2006 14:48:24 -0700
Message-Id: <1159307304.22053.31.camel@piet2.bluelane.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3mdk 
X-OriginalArrivalTime: 26 Sep 2006 21:48:29.0518 (UTC) FILETIME=[80EFFEE0:01C6E1B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c5MaqW8Jc4ejKUNDrSL2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-09-26 at 14:26 +0530, Amit S. Kale wrote:
> That's great! Let's include this in kgdb documentation.

Why not make it a config option to compile -O0 and=20
leave in the static_inline --> inline declarations so developers
can easily just change "static inline" to "static_inline"
in the areas of the kernel that they are working on.

There are already so many things that should be included
in the kgdb documentation that aren't. For example using
kgdboe and NAPI. Seems to me NAPI should be disabled by
our config menu until the problems are resolved. Leaving
land mines laying around just frustrates the user community.
Same for debugging -O0; it should be configurable.

Andrew: would including these kinda of changes in the
        the kgdb patch be a problem for eventual integration?
        IMHO it just makes the kgdb patch that more worthy
        of integration. Makes debugging it at least twice
        as enlightening. I'd still like to find a
        fix for the kgdb list problem and get code to
        stop using enpty structures instead of correctly
        including the structure declarations; for example
        the device mapping code. I'd like to see kernel
        code written with debug-ability a major consideration.

-piet

>=20
> Thanks, Piet.
> -Amit
>=20
> On Tuesday 26 September 2006 14:20, emin ak wrote:
> > Hi Piet;
> > Firstly thank you very much for your detailed answer. I'am happy to
> > say that I have achieved to debug tcp-ip stack succesfully with you
> > hints.  It's nice to see next command working properly, and backtraces
> > look good. Because of our architecture (powerpc), I can't apply all
> > the hints especially which one includes asm inst. I'll try scripts
> > also, it seems they'll be very helpfull.
> >
> > Most of the features of linux kernel are lack of documentation,
> > without a reliable  debug facility, even the sources are opened, it's
> > hard to understand what's happing on the code especially for complex
> > ones like tcp-ip stack. I believe that, one day the maintainers of
> > linux kernel will notice old man's printk is not enough all debugging
> > purposes and  one day, we'll debug all around the code without
> > modifications
> >
> >
> > Thanks again.
> > Emin
> >
> > 2006/9/26, Piet Delaney <piet@bluelane.com>:
> > >  On Thu, 2006-09-21 at 23:54 +0300, emin ak wrote:
> > > > Dear All;
> > > > Firstly thank you very much for your great effort for kgdb that mak=
es
> > > > kernel much understandable.
> > > > I'am using kgdb to debug tcp-ip stack but I have experienced seriou=
s
> > > > difficulties while debugging inline functions.
> > >
> > > Hi Emin:
> > >
> > >   [Looks like my posting to Kgdb-bugreport@lists.sourceforge.net got
> > >    dropped but I didn't receive any mail back from sourceforge on why=
;
> > >    trying again. It's less that the 100k limit.]
> > >
> > > Yep, I edit "static inline" to "static_inline" and then define
> > > static_inline as static for KGDB kernels.
> > >
> > > In include/linux/compiler-gcc3.h and include/linux/compiler-gcc4.h
> > > I added:
> > > ------------------------------------------------------------------
> > > #if defined(CONFIG_KGDB) || defined(CONFIG_KEXEC)
> > > # define static_inline    static __attribute__ ((__unused__))
> > > # define static__inline__ static __attribute__ ((__unused__))
> > > # define INLINE                  __attribute__ ((__unused__))
> > > # define __INLINE__              __attribute__ ((__unused__))
> > > #else
> > > # define static_inline      static   inline
> > > # define static__inline__   static __inline__
> > > # define INLINE                      inline
> > > # define __INLINE__                __inline__
> > > #endif
> > > ---------------------------------------------------------------------=
-
> > > I'm using it today to understand the device mapping and encryption co=
de.
> > > It's great! Inline's make skipping over code with the gdb 'next'
> > > instruction impossible and you can't see the local variables.
> > >
> > > I like having a large stack, compiling -O0 and without inlines
> > > can increase the stack size. I think I notices more stability
> > > by adding this to include/asm-i386/thread_info.h:
> > > ---------------------------------------------------------------------=
-
> > > #if defined(CONFIG_DEBUG_PREEMPT_AUDIT) || defined(CONFIG_KGDB) ||
> > > defined(CONFIG_KEXEC)
> > > #define THREAD_SIZE     (8192 * 2)
> > > #else
> > > #ifdef CONFIG_4KSTACKS
> > > #define THREAD_SIZE     (4096)
> > > #else
> > > #define THREAD_SIZE     (8192)
> > > #endif
> > > #endif
> > > ---------------------------------------------------------------------=
--
> > >
> > > Without OPTIMIZATION I found the MMU code needs a tweak
> > > in../linux-4/mm/memory.c:
> > > ---------------------------------------------------------------------=
---
> > > #if !defined(__PAGETABLE_PUD_FOLDED) || defined(CONFIG_KGDB) ||
> > > defined(CONFIG_KEXEC)
> > > /*
> > >  * Allocate page upper directory.
> > >  *
> > >  * We've already handled the fast-path in-line, and we own the
> > >  * page table lock.
> > >  */
> > > pud_t fastcall *__pud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigne=
d
> > > long address)
> > > {
> > > .
> > > .
> > > .
> > > }
> > > #if !defined(__PAGETABLE_PMD_FOLDED) || defined(CONFIG_KGDB) ||
> > > defined(CONFIG_KEXEC)
> > > /*
> > >  * Allocate page middle directory.
> > >  *
> > >  * We've already handled the fast-path in-line, and we own the
> > >  * page table lock.
> > >  */
> > > pmd_t fastcall *__pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigne=
d
> > > long address)
> > > {
> > > .
> > > .
> > > }
> > > ---------------------------------------------------------------------=
----
> > >--
> > >
> > > Maybe I should have used #if !defined(__OPTIMIZE__)
> > > in ../linux-4/mm/memory.c. Another change is I needed
> > > to define a few network byte swapping functions. I currently
> > > define them in ../linux-4/net/core/sock.c but I'm not
> > > resistant to putting it in a better place:
> > > ---------------------------------------------------------------------=
----
> > >--- /*
> > >  * If compiling -O0 we need to define
> > >  * these functions somewhere.
> > >  */
> > > #if !defined(__OPTIMIZE__)
> > > #define ___htonl(x) __cpu_to_be32(x)
> > > #define ___htons(x) __cpu_to_be16(x)
> > > #define ___ntohl(x) __be32_to_cpu(x)
> > > #define ___ntohs(x) __be16_to_cpu(x)
> > >
> > > __u32  htonl(__be32 x) { return(___htonl(x)); }
> > > __u32  ntohl(__be32 x) { return(___ntohl(x)); }
> > > __be16 htons(__u16 x)  { return(___htons(x)); }
> > > __u16  ntohs(__be16 x) { return(___ntohs(x)); }
> > >
> > > EXPORT_SYMBOL(htonl);
> > > EXPORT_SYMBOL(ntohl);
> > > EXPORT_SYMBOL(htons);
> > > EXPORT_SYMBOL(ntohs);
> > > #endif
> > > ---------------------------------------------------------------------=
----
> > >-----
> > >
> > > Sometimes I only want to compile the tcp/ip code -O0, so I modified t=
he
> > > networking Makefiles and added:
> > >
> > > ---------------------------------------------------------------------=
----
> > >------ ifdef CONFIG_KGDB
> > > CFLAGS +=3D -gdwarf-2 -O0
> > > else
> > > ifdef CONFIG_KEXEC
> > > CFLAGS +=3D -gdwarf-2 -O0
> > > endif
> > > endif
> > > ---------------------------------------------------------------------=
----
> > >-----
> > >
> > > In the top level kernel Makefile I have:
> > > ---------------------------------------------------------------------=
----
> > >----- ifdef CONFIG_FRAME_POINTER
> > > CFLAGS      +=3D -fno-omit-frame-pointer
> > > else
> > > CFLAGS      +=3D -fomit-frame-pointer
> > > endif
> > >
> > > #
> > > # Compiling the complete kernel without optimization (-O0) for enhanc=
ed
> > > debugging
> > > # with kgdb/kdump requires ./mm/memory.c to have:
> > > #
> > > #       if !defined(__PAGETABLE_PUD_FOLDED) || defined(CONFIG_KGDB) |=
|
> > > defined(CONFIG_KEXEC)
> > > # and
> > > #       if !defined(__PAGETABLE_PMD_FOLDED) || defined(CONFIG_KGDB) |=
|
> > > defined(CONFIG_KEXEC)
> > > #
> > > # A less invasive procedure is to use -O1 and only use -O0 for
> > > networking code.
> > > # The networking Makefiles have been setup to support this. So just
> > > change
> > > # -O0 to -O1 below and back out the kgdb change in ./mm/memory.c for =
a
> > > # less invasive change. Compiling -O0 also required increasing
> > > ROUNDUP_WAIT in
> > > # linux/kernel/kgdb.c; value in 2.6.12 patch was way to low and value=
 in
> > > 2.6.16
> > > # is marginal and frequently causes lead CPU to times out prematurely
> > > waiting for
> > > # other CPU's to stop.
> > > #
> > > ifdef CONFIG_DEBUG_INFO
> > > ifdef CONFIG_KGDB
> > > CFLAGS      +=3D -gdwarf-2 -O0
> > > else
> > > ifdef CONFIG_KEXEC
> > > CFLAGS      +=3D -gdwarf-2 -O1
> > > else
> > > CFLAGS      +=3D -g
> > > endif
> > > endif
> > > endif
> > > ---------------------------------------------------------------------=
----
> > >-----------
> > >
> > > >                                                 I know this is not =
a
> > > > bug but with -O optimizations and inlines on tcp-ip stack, program
> > > > counter goes everywhere madly even with step or next command and th=
is
> > > > makes debugging incomprehensible.
> > >
> > > Yep, I don't understand why everyone else doesn't. It's also
> > > like using debug printf's, I like being able to trace the code
> > > to get the big picture and then a -O0 to look at details with kgdb.
> > >
> > > Some believe doing this kind of stuff is blasphemy. The
> > > Bible says I should be killed for working on Sunday; I
> > > happen to disagree.
> > >
> > > >                              At this point I have two questions:
> > > > 1- Is there any way to compile kernel with -O0 flag and if it's
> > > > possible, may it cause any problems?
> > >
> > > I offered to post them to Amit back on Sept 06(2:45 PM) but I don't
> > > think I ever heard back. I'd prefer to see the -O0 and KGDB_DEBUG
> > > code for tracing the kgdb stub assimilated. If they would be accepted
> > > I could make a patch to Tom's git repository...
> > >
> > > > 2- Why does kernel fail while compiling with O0 flag and why does
> > > > linux kernel depends on inline functions so much?
> > >
> > > I think it's an obsession with performance. As long as I/we can map
> > > "static inline" to "static" it's not a big deal.
> > >
> > > >                                                     Is there anyone
> > > > whoever uses kgdb for debugging linux tcp-ip stack or any effort to
> > > > compile kernel with no optimization?
> > >
> > > I'm using it every day; works great. I also recommend by SOCK_DEBUG,
> > > SKB_DEBUG, and TCP_DEBUG macros to trace the TCP code. I also indent
> > > the trace to make it easy to read.
> > >
> > >        function1() {
> > >                function2() {
> > >                        function3() {
> > >                                function4();
> > >                        }
> > >                }
> > >        }
> > >
> > > The brackets make it easy to see the scope of the trace with vi.
> > > I like tracing with 'C' syntax since it what the reader is use to.
> > > If folks are interested I could also add that to the git diff, but
> > > I think that likely belongs else where and isn't likely the current
> > > dogma. See snippet from attached network trace. I gave a talk
> > > at a UNENIX conference back in the 1980 recommending a common UNIX
> > > tracing paradigm and a few liked it. The director of Siemens,
> > > Struck  Zimmerman, didn't; you can't please everyone, so I just do wh=
at
> > > I think is best and live with the world not being as I'd expect it to
> > > be.
> > >
> > > For TCP I'm using the attached sock.h fragment which has a
> > > backward compatible SOCK_DEBUG() macro. I used the same paradigm in
> > > skbuff.h; see attachment. Likewise I'm doing the same in kgdb.h; also
> > > attached.
> > >
> > > In printk I added:
> > > --------------------------------------------------------------------
> > >
> > >                for (tp =3D tbuf; tp < tbuf + tlen; tp++)
> > >                    emit_log_char(*tp);
> > >                printed_len +=3D tlen - 3;
> > > #ifdef CONFIG_PRINTK_INDENT
> > >                if (!in_interrupt()) {
> > >                    int depth =3D stack_depth();
> > >                    int i;
> > >
> > >                    if ((depth > 0) && (depth < 120)) {
> > >                        for(i =3D 0; i < depth; i++) {
> > >                        emit_log_char(' ');
> > >                        printed_len++;
> > >                        }
> > >                    }
> > >                }
> > > #endif
> > > -----------------------------------------------------------
> > >
> > > and I added stack_depth() function
> > > to  ../linux-4/arch/i386/kernel/traps.c
> > > -----------------------------------------------------------
> > > int stack_depth(void)
> > > {
> > >    struct thread_info *tinfo;
> > >    unsigned long ebp;
> > >    int depth =3D 0;
> > >
> > > #ifdef  CONFIG_FRAME_POINTER
> > >    asm("andl %%esp,%0; ":"=3Dr" (tinfo) : "0" (~(THREAD_SIZE - 1)));
> > >    asm ("movl %%ebp, %0" : "=3Dr" (ebp) : );
> > >
> > >     while (valid_stack_ptr(tinfo, (void *)ebp)) {
> > >        ebp =3D *(unsigned long *)ebp;
> > >        if (depth++ > 100) {
> > >             break;
> > >        }
> > >    }
> > > #endif
> > >    return(depth);
> > > }
> > > ---------------------------------------------------------------------=
----
> > >--
> > >
> > > Let me know if you you have any questions. Sounds like your on the ri=
ght
> > > track; IMHO.
> > >
> > > -piet
> > >
> > > > Thanks alot.
> > > > Emin
> > >
> > > ---------------------------------------------------------------------=
----
> > >
> > > > Take Surveys. Earn Cash. Influence the Future of IT
> > > > Join SourceForge.net's Techsay panel and you'll get the chance to
> > >
> > > share your
> > >
> > > > opinions on IT & business topics through brief surveys -- and earn
> > >
> > > cash
> > >
> > > http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CI=
D=3DDEVDEV
> > >
> > > > _______________________________________________
> > > > Kgdb-bugreport mailing list
> > > > Kgdb-bugreport@lists.sourceforge.net
> > > > https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport
> > >
> > > --
> > > Piet Delaney                                    Phone: (408) 200-5256
> > > Blue Lane Technologies                          Fax:   (408) 200-5299
> > > 10450 Bubb Rd.
> > > Cupertino, Ca. 95014                            Email: piet@bluelane.=
com
> >
> > -----------------------------------------------------------------------=
--
> > Take Surveys. Earn Cash. Influence the Future of IT
> > Join SourceForge.net's Techsay panel and you'll get the chance to share
> > your opinions on IT & business topics through brief surveys -- and earn
> > cash
> > http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=
=3DDEVDEV
> > _______________________________________________
> > Kgdb-bugreport mailing list
> > Kgdb-bugreport@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport
--=20
Piet Delaney                                    Phone: (408) 200-5256
Blue Lane Technologies                          Fax:   (408) 200-5299
10450 Bubb Rd.
Cupertino, Ca. 95014                            Email: piet@bluelane.com

--=-c5MaqW8Jc4ejKUNDrSL2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBFGaAoJICwm/rv3hoRAqDMAJ9/7Wg/EE5l8jrSry4AZanqI1FW1ACgg1hP
04gPGTX2xDecdv3rPvd5uTU=
=QSzC
-----END PGP SIGNATURE-----

--=-c5MaqW8Jc4ejKUNDrSL2--

