Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277719AbRJIFBQ>; Tue, 9 Oct 2001 01:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277720AbRJIFA6>; Tue, 9 Oct 2001 01:00:58 -0400
Received: from zok.SGI.COM ([204.94.215.101]:38596 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S277719AbRJIFAv>;
	Tue, 9 Oct 2001 01:00:51 -0400
Date: Tue, 9 Oct 2001 15:01:14 +1000
From: Nathan Scott <nathans@sgi.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andreas Gruenbacher <ag@bestbits.at>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Re: ENOATTR and other error enums
Message-ID: <20011009150113.A497835@wobbly.melbourne.sgi.com>
In-Reply-To: <200110060624.f966OeV30354@monkeyiq.dnsalias.org> <20011008122201.W472533@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011008122201.W472533@wobbly.melbourne.sgi.com>; from nathans@sgi.com on Mon, Oct 08, 2001 at 12:22:02PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi fellas,

Here is an errno.h patch which provides these new errno values.
XFS needs both values.  ENOATTR is also required by the ext2
extended attributes project (and any other filesystem intending
to implement extended attributes in the future).  Both values
need to be visible in both kernel and user space, so this patch
would be an initial step toward libc support also, hopefully.

In the absence of any cleaner way to do this (?), could we have
this patch applied please?  Any/all feedback much appreciated
-- thanks.

cheers.


On Mon, Oct 08, 2001 at 12:22:02PM +1100, Nathan Scott wrote:
> hi there,
> 
> On Sat, Oct 06, 2001 at 04:24:40PM +1000, monkeyiq wrote:
> > Hi,
> >   Anyone know where these are defined in Linux? I dont seem
> > to be able to find them, even with find/grep in /usr/include.
> 
> ENOATTR is not a blessed errno in Linux.  In XFS we have simply
> defined it to be the same as ENODATA for the time being.  The
> ext2 extended attributes project define it to be EDOM, also as
> a stop-gap solution I imagine.
> 
> A similar problem exists with ENOTSUP (defined by POSIX 1003.1b?)
> - this is only supported via linux/asm-parisc/errno.h as a real
> errno, among all the architectures.  Both the XFS and ext2 extended
> attributes implementations define this errno to be EOPNOTSUPP as an
> interim solution.  Ah, wait - from a quick test, glibc does seem to
> do exactly this also, so this one is not a problem (except perhaps
> on the parisc port? -- hmm, that could actually be a bug on parisc).
> 
> On a related topic, but not specific to extended attributes - for
> XFS in general, we needed one other errno - EFSCORRUPTED.  This is
> used when XFS goes into forced shutdown mode for a filesystem that
> has been detected as on-disk corrupt, to stop making the situation
> any worse (user must umount/xfs_repair).  We couldn't find any pre-
> existing Linux errno vaguely similar to this one, so it was defined
> to "990" until a real solution could be found.
> 
> Obviously, these are not the correct long-term solutions ... they
> need to become real Linux errno's, I think, and ENOTSUP could be
> defined to EOPNOTSUPP? - EWOULDBLOCK, EDEADLOCK seem to do this.
> I'm not sure how to reach that point though (CC'ing linux-kernel
> for any advice) - for reference, in IRIX these errnos are defined
> as follows:
> 
> ENOATTR = Attribute not found
> EFSCORRUPTED = Filesystem is corrupted
> 
> > Also, is there a function to get a string rep of the error
> > that occured in the attr code?
> 
> Someday it should become a part of asm-XXXXX/errno.h (errno's are
> architecture specific) and the libc strerror(3) routine should be
> able to provide a meaningful string.  But currently that does not
> happen.
> 
> cheers.
> 
> -- 
> Nathan

-- 
Nathan

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="errno.patch"

diff -Naur linux-vanilla/include/asm-alpha/errno.h linux-errno/include/asm-alpha/errno.h
--- linux-vanilla/include/asm-alpha/errno.h	Sat Feb 10 06:40:02 2001
+++ linux-errno/include/asm-alpha/errno.h	Tue Oct  9 11:15:13 2001
@@ -138,5 +138,7 @@
 
 #define ENOMEDIUM	129	/* No medium found */
 #define EMEDIUMTYPE	130	/* Wrong medium type */
+#define EFSCORRUPTED	131	/* Filesystem is corrupted */
+#define ENOATTR		132	/* No such attribute */
 
 #endif
diff -Naur linux-vanilla/include/asm-arm/errno.h linux-errno/include/asm-arm/errno.h
--- linux-vanilla/include/asm-arm/errno.h	Wed Jan 21 11:39:42 1998
+++ linux-errno/include/asm-arm/errno.h	Tue Oct  9 11:22:29 2001
@@ -128,5 +128,7 @@
 
 #define	ENOMEDIUM	123	/* No medium found */
 #define	EMEDIUMTYPE	124	/* Wrong medium type */
+#define	EFSCORRUPTED	125	/* Filesystem is corrupted */
+#define	ENOATTR		126	/* No such attribute */
 
 #endif
diff -Naur linux-vanilla/include/asm-cris/errno.h linux-errno/include/asm-cris/errno.h
--- linux-vanilla/include/asm-cris/errno.h	Fri Feb  9 11:32:44 2001
+++ linux-errno/include/asm-cris/errno.h	Tue Oct  9 11:22:41 2001
@@ -130,5 +130,7 @@
 
 #define	ENOMEDIUM	123	/* No medium found */
 #define	EMEDIUMTYPE	124	/* Wrong medium type */
+#define	EFSCORRUPTED	125	/* Filesystem is corrupted */
+#define	ENOATTR		126	/* No such attribute */
 
 #endif
diff -Naur linux-vanilla/include/asm-i386/errno.h linux-errno/include/asm-i386/errno.h
--- linux-vanilla/include/asm-i386/errno.h	Sat Feb 10 06:40:02 2001
+++ linux-errno/include/asm-i386/errno.h	Tue Oct  9 11:23:02 2001
@@ -128,5 +128,7 @@
 
 #define	ENOMEDIUM	123	/* No medium found */
 #define	EMEDIUMTYPE	124	/* Wrong medium type */
+#define	EFSCORRUPTED	125	/* Filesystem is corrupted */
+#define	ENOATTR		126	/* No such attribute */
 
 #endif
diff -Naur linux-vanilla/include/asm-ia64/errno.h linux-errno/include/asm-ia64/errno.h
--- linux-vanilla/include/asm-ia64/errno.h	Wed Apr 11 05:23:06 2001
+++ linux-errno/include/asm-ia64/errno.h	Tue Oct  9 11:23:12 2001
@@ -135,5 +135,7 @@
 
 #define	ENOMEDIUM	123	/* No medium found */
 #define	EMEDIUMTYPE	124	/* Wrong medium type */
+#define	EFSCORRUPTED	125	/* Filesystem is corrupted */
+#define	ENOATTR		126	/* No such attribute */
 
 #endif /* _ASM_IA64_ERRNO_H */
diff -Naur linux-vanilla/include/asm-m68k/errno.h linux-errno/include/asm-m68k/errno.h
--- linux-vanilla/include/asm-m68k/errno.h	Sat Feb 10 06:40:02 2001
+++ linux-errno/include/asm-m68k/errno.h	Tue Oct  9 11:23:24 2001
@@ -128,5 +128,7 @@
 
 #define	ENOMEDIUM	123	/* No medium found */
 #define	EMEDIUMTYPE	124	/* Wrong medium type */
+#define	EFSCORRUPTED	125	/* Filesystem is corrupted */
+#define	ENOATTR		126	/* No such attribute */
 
 #endif /* _M68K_ERRNO_H */
diff -Naur linux-vanilla/include/asm-mips/errno.h linux-errno/include/asm-mips/errno.h
--- linux-vanilla/include/asm-mips/errno.h	Tue Jul  3 06:56:40 2001
+++ linux-errno/include/asm-mips/errno.h	Tue Oct  9 11:14:37 2001
@@ -141,6 +141,8 @@
  */
 #define ENOMEDIUM	159	/* No medium found */
 #define EMEDIUMTYPE	160	/* Wrong medium type */
+#define EFSCORRUPTED	161	/* Filesystem is corrupted */
+#define ENOATTR		162	/* No such attribute */
 
 #define EDQUOT		1133	/* Quota exceeded */
 
diff -Naur linux-vanilla/include/asm-mips64/errno.h linux-errno/include/asm-mips64/errno.h
--- linux-vanilla/include/asm-mips64/errno.h	Sat Apr 14 13:26:07 2001
+++ linux-errno/include/asm-mips64/errno.h	Tue Oct  9 11:17:07 2001
@@ -142,6 +142,8 @@
  */
 #define ENOMEDIUM	159	/* No medium found */
 #define EMEDIUMTYPE	160	/* Wrong medium type */
+#define EFSCORRUPTED	161	/* Filesystem is corrupted */
+#define ENOATTR		162	/* No such attribute */
 
 #define EDQUOT		1133	/* Quota exceeded */
 
diff -Naur linux-vanilla/include/asm-parisc/errno.h linux-errno/include/asm-parisc/errno.h
--- linux-vanilla/include/asm-parisc/errno.h	Wed Dec  6 07:29:39 2000
+++ linux-errno/include/asm-parisc/errno.h	Tue Oct  9 11:23:43 2001
@@ -99,6 +99,8 @@
 #define	EREMOTEIO	181	/* Remote I/O error */
 #define	ENOMEDIUM	182	/* No medium found */
 #define	EMEDIUMTYPE	183	/* Wrong medium type */
+#define	EFSCORRUPTED	184	/* Filesystem is corrupted */
+#define	ENOATTR		185	/* No such attribute */
 
 /* We now return you to your regularly scheduled HPUX. */
 
diff -Naur linux-vanilla/include/asm-ppc/errno.h linux-errno/include/asm-ppc/errno.h
--- linux-vanilla/include/asm-ppc/errno.h	Tue May 22 08:02:06 2001
+++ linux-errno/include/asm-ppc/errno.h	Tue Oct  9 11:23:55 2001
@@ -129,6 +129,8 @@
 
 #define	ENOMEDIUM	123	/* No medium found */
 #define	EMEDIUMTYPE	124	/* Wrong medium type */
+#define	EFSCORRUPTED	125	/* Filesystem is corrupted */
+#define	ENOATTR		126	/* No such attribute */
 
 /* Should never be seen by user programs */
 #define ERESTARTSYS	512
diff -Naur linux-vanilla/include/asm-s390/errno.h linux-errno/include/asm-s390/errno.h
--- linux-vanilla/include/asm-s390/errno.h	Sat May 13 04:41:44 2000
+++ linux-errno/include/asm-s390/errno.h	Tue Oct  9 11:24:08 2001
@@ -136,5 +136,7 @@
 
 #define	ENOMEDIUM	123	/* No medium found */
 #define	EMEDIUMTYPE	124	/* Wrong medium type */
+#define	EFSCORRUPTED	125	/* Filesystem is corrupted */
+#define	ENOATTR		126	/* No such attribute */
 
 #endif
diff -Naur linux-vanilla/include/asm-s390x/errno.h linux-errno/include/asm-s390x/errno.h
--- linux-vanilla/include/asm-s390x/errno.h	Wed Feb 14 09:13:44 2001
+++ linux-errno/include/asm-s390x/errno.h	Tue Oct  9 11:24:16 2001
@@ -136,5 +136,7 @@
 
 #define	ENOMEDIUM	123	/* No medium found */
 #define	EMEDIUMTYPE	124	/* Wrong medium type */
+#define	EFSCORRUPTED	125	/* Filesystem is corrupted */
+#define	ENOATTR		126	/* No such attribute */
 
 #endif
diff -Naur linux-vanilla/include/asm-sh/errno.h linux-errno/include/asm-sh/errno.h
--- linux-vanilla/include/asm-sh/errno.h	Tue Aug 31 11:12:59 1999
+++ linux-errno/include/asm-sh/errno.h	Tue Oct  9 11:24:25 2001
@@ -128,5 +128,7 @@
 
 #define	ENOMEDIUM	123	/* No medium found */
 #define	EMEDIUMTYPE	124	/* Wrong medium type */
+#define	EFSCORRUPTED	125	/* Filesystem is corrupted */
+#define	ENOATTR		126	/* No such attribute */
 
 #endif /* __ASM_SH_ERRNO_H */
diff -Naur linux-vanilla/include/asm-sparc/errno.h linux-errno/include/asm-sparc/errno.h
--- linux-vanilla/include/asm-sparc/errno.h	Thu Apr 24 12:01:28 1997
+++ linux-errno/include/asm-sparc/errno.h	Tue Oct  9 11:24:35 2001
@@ -132,5 +132,7 @@
 
 #define	ENOMEDIUM	125	/* No medium found */
 #define	EMEDIUMTYPE	126	/* Wrong medium type */
+#define	EFSCORRUPTED	127	/* Filesystem is corrupted */
+#define	ENOATTR		128	/* No such attribute */
 
 #endif
diff -Naur linux-vanilla/include/asm-sparc64/errno.h linux-errno/include/asm-sparc64/errno.h
--- linux-vanilla/include/asm-sparc64/errno.h	Thu Apr 24 12:01:28 1997
+++ linux-errno/include/asm-sparc64/errno.h	Tue Oct  9 11:28:03 2001
@@ -132,5 +132,7 @@
 
 #define ENOMEDIUM       125     /* No medium found */
 #define EMEDIUMTYPE     126     /* Wrong medium type */
+#define EFSCORRUPTED    127     /* Filesystem is corrupted */
+#define ENOATTR         128     /* No such attribute */
 
 #endif /* !(_SPARC64_ERRNO_H) */

--sdtB3X0nJg68CQEu--
