Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVDFTGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVDFTGR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 15:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVDFTGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 15:06:17 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:18549 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262285AbVDFTEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 15:04:35 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: Renate Meijer <kleuske@xs4all.nl>,
       =?iso-8859-15?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: [08/08] uml: va_copy fix
Date: Wed, 6 Apr 2005 21:09:50 +0200
User-Agent: KMail/1.7.2
Cc: stable@kernel.org, Greg KH <gregkh@suse.de>, jdike@karaya.com,
       linux-kernel@vger.kernel.org
References: <20050405164539.GA17299@kroah.com> <200504052053.20078.blaisorblade@yahoo.it> <7aa6252d5a294282396836b1a27783e8@xs4all.nl>
In-Reply-To: <7aa6252d5a294282396836b1a27783e8@xs4all.nl>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/PDVCt1uwxi7x8V"
Message-Id: <200504062109.51344.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_/PDVCt1uwxi7x8V
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=46or J=F6rn Engel and the issue he opened: at the end of this mail I descr=
ibe=20
another bug caught by 2.95 and not by 3.x.

On Tuesday 05 April 2005 22:18, Renate Meijer wrote:
> On Apr 5, 2005, at 8:53 PM, Blaisorblade wrote:
> > On Tuesday 05 April 2005 20:47, Renate Meijer wrote:
> >> On Apr 5, 2005, at 6:48 PM, Greg KH wrote:

> >> The use of '__' violates compiler namespace.
> >
> > Why? The symbol is defined by the compiler itself.

> If a function is prefixed with a double underscore, this implies the
> function is internal to
> the compiler, and may change at any time, since it's not governed by
> some sort of standard.
> Hence that code may start suffering from bitrot and complaining to the
> compiler guys won't help.

> They'll just tell you to RTFM.
Ok, agreed in general. However, the -stable tree is for "current" GCC. Your=
=20
objections would better refer to the fact that the same patch has already=20
been merged into the main trunk.

Also, they have no point in doing this, probably. And the __va_copy name wa=
s=20
used in the draft C99 standard so it's widespread (I've read this on "man 3=
=20
va_copy").
> >> If 2.95.4 were not easily
> >> replaced by
> >> a much better version (3.3.x? 3.4.x) I would see a reason to disregard
> >> this, but a fix
> >> merely to satisfy an obsolete compiler?
> >
> > Let's not flame, Linus Torvalds said "we support GCC 2.95.3, because
> > the newer
> > versions are worse compilers in most cases".

> You make it sound as if you were reciting Ye Holy Scribings. When did
> Linus Thorvalds say this? In the Redhat-2.96 debacle? Before or after
> 3.3? I have searched for that quote,
Sorry for the quote marks, it was a resume of what he said (and from=20
re-reading, it's still a correct resume).
> but could not find it, and having=20
> suffered under 3.1.1, I can well understand his wearyness for the
> earlier versions.
I've read the same kerneltrap article you quote.
> See
>
> http://kerneltrap.org/node/4126, halfway down.
Ok, read.
> For the cold, hard facts...
>
> http://www.suse.de/~aj/SPEC/
Linus pointed out that SPEC performances are not a good test case for the=20
kernel compilation in that article. Point out a kernel compilation case.
> <snip>
>
> > Consider me as having no opinion on this except not wanting to break
> > on purpose Debian users.
>
> If Debian users are stuck with a pretty outdated compiler, i'd
> seriously suggest migrating to some
> other distro which allows more freedom.
I guess they can, if they want, upgrade some selected packages from newer=20
trees, maybe by recompiling (at least, on Gentoo it's trivial, maybe on a=20
binary distro like Debian it's harder).
> If linux itself is holding them=20
> back, there's a need for some serious patching.

> If there are serious=20
> issues in the gcc compiler, which hinder migration to a more up-to-date
> version our efforts should be directed at solving them in that project,
> not this.
Linus spoke about the compiler speed, which isn't such a bad reason. He's=20
unfair in saying that GCC 3.x does not optimize better than older releases,=
=20
probably; I guess that the compilation flags (I refer to=20
=2Dfno-strict-aliasing, which disables some optimizations) make some=20
difference, as do the memory barriers (as pointed in the comments).

> > If you want, submit a patch removing Gcc 2.95.3 from supported
> > versions, and get ready to fight
> > for it (and probably loose).

> I don't fight over things like that, i'm not interested in politics. I
> merely point out the problem. And yes.
> I do think support for obsolete compiler should be dumped in favor of a
> more modern version. Especially if that compiler requires invasions of
> compiler-namespace. The patch, as presented, is not guaranteed to be
> portable over versions, and may thus introduce another problem with
> future versions of GCC.
When and if that will happen, I'll come with an hack. UML already has need =
for=20
some GCC - version specific behaviour (see arch/um/kernel/gmon_syms.c on a=
=20
recent BitKeeper snapshot, even -rc1-bk5 has this code).

> > Also, that GCC has discovered some syscall table errors in UML - I
> > sent a
> > separate patch, which was a bit big sadly (in the reduced version,
> > about 70
> > lines + description).

> I am not quite sure what is intended here... Please explain.
I'm reattaching the patch, so that you can look at the changelog (I'm also=
=20
resending it as a separate email so that it is reviewed and possibly merged=
).=20
Basically this is an error in GCC 2 and not in GCC 3:

int [] list =3D {
 [0] =3D 1,
 [0] =3D 1
}
(I've not tested the above itself, but this should be a stripped down versi=
on=20
of one of the bugs fixed in the patch).

That sort of code in the UML syscall table is not the safer one - in fact,=
=20
apart this patch for the stable tree, I'm refactoring the UML syscall table=
=20
completely (for 2.6.12 / 2.6.13).

Btw: I've not investigated which one of the two behaviours is the buggy one=
 -=20
if you know, maybe you or I can report it.
> timeo hominem unius libri

> Thomas van Aquino

=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_/PDVCt1uwxi7x8V
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-quick-fix-syscall-table-for-stable.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-quick-fix-syscall-table-for-stable.patch"


CC: <stable@kernel.org>

*) Uml 2.6.11 does not compile with gcc 2.95.4 because some entries are
duplicated, and that GCC does not accept this (unlike gcc 3). Plus various
other bugs in the syscall table definitions:

  *) 223 is a syscall hole (i.e. ni_syscall) only on i386, on x86_64 it's a
  valid syscall (thus a duplicated one).

  *) __NR_vserver must be only once with sys_ni_syscall, and not multiple
  times with different values!

  *) syscalls duplicated in SUBARCHs and in common files (thus assigning twice
  to the same array entry and causing the GCC 2.95.4 failure mentioned above):
  sys_utimes, which is common, and sys_fadvise64_64, sys_statfs64,
  sys_fstatfs64, which exist only on i386.

  *) syscalls duplicated in each SUBARCH, to put in common files:
  sys_remap_file_pages, sys_utimes, sys_fadvise64

  *) 285 is a syscall hole (i.e. ni_syscall) only on i386, on x86_64 the range
  does not arrive to that point.

  *) on x86_64, the macro name is __NR_kexec_load and not __NR_sys_kexec_load.
  Use the correct name in either case.

Note: as you can see, part of the syscall table definition in UML is
arch-independent (with everywhere defined syscalls), and part is
arch-dependant. This has created confusion (some syscalls are listed in both
places, some in the wrong one, some are wrong on one arch or another).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 clean-linux-2.6.11-paolo/arch/um/include/sysdep-i386/syscalls.h   |   12 +++++-----
 clean-linux-2.6.11-paolo/arch/um/include/sysdep-x86_64/syscalls.h |    5 ----
 clean-linux-2.6.11-paolo/arch/um/kernel/sys_call_table.c          |   11 +++------
 3 files changed, 10 insertions(+), 18 deletions(-)

diff -puN arch/um/include/sysdep-i386/syscalls.h~uml-quick-fix-syscall-table-for-stable arch/um/include/sysdep-i386/syscalls.h
--- clean-linux-2.6.11/arch/um/include/sysdep-i386/syscalls.h~uml-quick-fix-syscall-table-for-stable	2005-04-01 22:40:17.000000000 +0200
+++ clean-linux-2.6.11-paolo/arch/um/include/sysdep-i386/syscalls.h	2005-04-01 22:40:17.000000000 +0200
@@ -23,6 +23,9 @@ extern long sys_mmap2(unsigned long addr
 		      unsigned long prot, unsigned long flags,
 		      unsigned long fd, unsigned long pgoff);
 
+/* On i386 they choose a meaningless naming.*/
+#define __NR_kexec_load __NR_sys_kexec_load
+
 #define ARCH_SYSCALLS \
 	[ __NR_waitpid ] = (syscall_handler_t *) sys_waitpid, \
 	[ __NR_break ] = (syscall_handler_t *) sys_ni_syscall, \
@@ -101,15 +104,12 @@ extern long sys_mmap2(unsigned long addr
 	[ 223 ] = (syscall_handler_t *) sys_ni_syscall, \
 	[ __NR_set_thread_area ] = (syscall_handler_t *) sys_ni_syscall, \
 	[ __NR_get_thread_area ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ __NR_fadvise64 ] = (syscall_handler_t *) sys_fadvise64, \
 	[ 251 ] = (syscall_handler_t *) sys_ni_syscall, \
-        [ __NR_remap_file_pages ] = (syscall_handler_t *) sys_remap_file_pages, \
-	[ __NR_utimes ] = (syscall_handler_t *) sys_utimes, \
-	[ __NR_vserver ] = (syscall_handler_t *) sys_ni_syscall,
-        
+	[ 285 ] = (syscall_handler_t *) sys_ni_syscall,
+
 /* 222 doesn't yet have a name in include/asm-i386/unistd.h */
 
-#define LAST_ARCH_SYSCALL __NR_vserver
+#define LAST_ARCH_SYSCALL 285
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -puN arch/um/include/sysdep-x86_64/syscalls.h~uml-quick-fix-syscall-table-for-stable arch/um/include/sysdep-x86_64/syscalls.h
--- clean-linux-2.6.11/arch/um/include/sysdep-x86_64/syscalls.h~uml-quick-fix-syscall-table-for-stable	2005-04-01 22:40:17.000000000 +0200
+++ clean-linux-2.6.11-paolo/arch/um/include/sysdep-x86_64/syscalls.h	2005-04-01 22:40:17.000000000 +0200
@@ -71,12 +71,7 @@ extern syscall_handler_t sys_arch_prctl;
 	[ __NR_iopl ] = (syscall_handler_t *) sys_ni_syscall, \
 	[ __NR_set_thread_area ] = (syscall_handler_t *) sys_ni_syscall, \
 	[ __NR_get_thread_area ] = (syscall_handler_t *) sys_ni_syscall, \
-        [ __NR_remap_file_pages ] = (syscall_handler_t *) sys_remap_file_pages, \
 	[ __NR_semtimedop ] = (syscall_handler_t *) sys_semtimedop, \
-	[ __NR_fadvise64 ] = (syscall_handler_t *) sys_fadvise64, \
-	[ 223 ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ __NR_utimes ] = (syscall_handler_t *) sys_utimes, \
-	[ __NR_vserver ] = (syscall_handler_t *) sys_ni_syscall, \
 	[ 251 ] = (syscall_handler_t *) sys_ni_syscall,
 
 #define LAST_ARCH_SYSCALL 251
diff -puN arch/um/kernel/sys_call_table.c~uml-quick-fix-syscall-table-for-stable arch/um/kernel/sys_call_table.c
--- clean-linux-2.6.11/arch/um/kernel/sys_call_table.c~uml-quick-fix-syscall-table-for-stable	2005-04-01 22:40:17.000000000 +0200
+++ clean-linux-2.6.11-paolo/arch/um/kernel/sys_call_table.c	2005-04-01 22:40:17.000000000 +0200
@@ -48,7 +48,6 @@ extern syscall_handler_t sys_vfork;
 extern syscall_handler_t old_select;
 extern syscall_handler_t sys_modify_ldt;
 extern syscall_handler_t sys_rt_sigsuspend;
-extern syscall_handler_t sys_vserver;
 extern syscall_handler_t sys_mbind;
 extern syscall_handler_t sys_get_mempolicy;
 extern syscall_handler_t sys_set_mempolicy;
@@ -242,6 +241,7 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_epoll_create ] = (syscall_handler_t *) sys_epoll_create,
 	[ __NR_epoll_ctl ] = (syscall_handler_t *) sys_epoll_ctl,
 	[ __NR_epoll_wait ] = (syscall_handler_t *) sys_epoll_wait,
+	[ __NR_remap_file_pages ] = (syscall_handler_t *) sys_remap_file_pages,
         [ __NR_set_tid_address ] = (syscall_handler_t *) sys_set_tid_address,
 	[ __NR_timer_create ] = (syscall_handler_t *) sys_timer_create,
 	[ __NR_timer_settime ] = (syscall_handler_t *) sys_timer_settime,
@@ -252,12 +252,10 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_clock_gettime ] = (syscall_handler_t *) sys_clock_gettime,
 	[ __NR_clock_getres ] = (syscall_handler_t *) sys_clock_getres,
 	[ __NR_clock_nanosleep ] = (syscall_handler_t *) sys_clock_nanosleep,
-	[ __NR_statfs64 ] = (syscall_handler_t *) sys_statfs64,
-	[ __NR_fstatfs64 ] = (syscall_handler_t *) sys_fstatfs64,
 	[ __NR_tgkill ] = (syscall_handler_t *) sys_tgkill,
 	[ __NR_utimes ] = (syscall_handler_t *) sys_utimes,
-	[ __NR_fadvise64_64 ] = (syscall_handler_t *) sys_fadvise64_64,
-	[ __NR_vserver ] = (syscall_handler_t *) sys_vserver,
+	[ __NR_fadvise64 ] = (syscall_handler_t *) sys_fadvise64,
+	[ __NR_vserver ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_mbind ] = (syscall_handler_t *) sys_mbind,
 	[ __NR_get_mempolicy ] = (syscall_handler_t *) sys_get_mempolicy,
 	[ __NR_set_mempolicy ] = (syscall_handler_t *) sys_set_mempolicy,
@@ -267,9 +265,8 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_mq_timedreceive ] = (syscall_handler_t *) sys_mq_timedreceive,
 	[ __NR_mq_notify ] = (syscall_handler_t *) sys_mq_notify,
 	[ __NR_mq_getsetattr ] = (syscall_handler_t *) sys_mq_getsetattr,
-	[ __NR_sys_kexec_load ] = (syscall_handler_t *) sys_ni_syscall,
+	[ __NR_kexec_load ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_waitid ] = (syscall_handler_t *) sys_waitid,
-	[ 285 ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_add_key ] = (syscall_handler_t *) sys_add_key,
 	[ __NR_request_key ] = (syscall_handler_t *) sys_request_key,
 	[ __NR_keyctl ] = (syscall_handler_t *) sys_keyctl,
_

--Boundary-00=_/PDVCt1uwxi7x8V--

