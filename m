Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316728AbSHBR0v>; Fri, 2 Aug 2002 13:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316750AbSHBR0v>; Fri, 2 Aug 2002 13:26:51 -0400
Received: from zeus.kernel.org ([204.152.189.113]:9698 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S316728AbSHBR0t>;
	Fri, 2 Aug 2002 13:26:49 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: linux-kernel@vger.kernel.org, bug-glibc@gnu.org
Subject: [PATCH] Define ENOATTR in 2.5 kernels
Date: Fri, 2 Aug 2002 19:25:13 +0200
X-Mailer: KMail [version 1.4]
Cc: Andreas Jaeger <aj@suse.de>, Andreas Schwab <schwab@suse.de>,
       Chris Mason <mason@suse.de>, Jeff Mahoney <jeffm@suse.com>,
       Nathan Scott <nathans@sgi.com>, Robert Watson <rwatson@FreeBSD.org>,
       Thorsten Kukuk <kukuk@suse.de>, Tim Shimmin <tes@sgi.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_1E88DFU80F00NB0F0OQD"
Message-Id: <200208021925.13647.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_1E88DFU80F00NB0F0OQD
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

we already have a number of Extended Attribute system calls (*xattr) in t=
he=20
2.5.x kernel. For implement them on file systems we also need the ENOATTR=
=20
error. It makes little sense to reuse an existing error number as glibc's=
=20
strerror() wouldn't be able to create an intelligent text message.

ENOATTR also exists on Irix and AIX. Error messages for ENOATTR should be=
=20
added to glibc once ENOATTR is defined in the kernel. I have attached a p=
atch=20
against glibc that adds the English error text.


In addition to ENOATTR we also need to clarify the ENOTSUP / EOPNOTSUPP /=
=20
ENOTSUPP issue, which I have posted yesterday (with no comments so far).

For details concerning the xattr system calls you may find the manual pag=
es=20
interesting, which are available as part of the attr-devel package, and=20
online at <http://acl.bestbits.at/man/man.shtml>.

Regards,
Andreas.

------------------------------------------------------------------
 Andreas Gruenbacher                                SuSE Linux AG
 mailto:agruen@suse.de                     Deutschherrnstr. 15-19
 http://www.suse.de/                   D-90429 Nuernberg, Germany


--------------Boundary-00=_1E88DFU80F00NB0F0OQD
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-2.5.30-enoattr-0.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linux-2.5.30-enoattr-0.diff"

Add the ENOATTR error number ("No such attribute")

The ENOATTR error number is needed by the file system specific code that
implements Extended Attributes.  This error can occur when trying to retrieve,
replace (XATTR_REPLACE flag) or delete an attribute that does not exist.

--- linux-2.5.30/include/linux/errno.h.orig	Fri Aug  2 15:17:14 2002
+++ linux-2.5.30/include/linux/errno.h	Fri Aug  2 15:17:17 2002
@@ -11,6 +11,9 @@
 #define ERESTARTNOHAND	514	/* restart if no handler.. */
 #define ENOIOCTLCMD	515	/* No ioctl command */
 
+/* Extended Attributes */
+#define ENOATTR		516	/* No such attribute */
+
 /* Defined for the NFSv3 protocol */
 #define EBADHANDLE	521	/* Illegal NFS file handle */
 #define ENOTSYNC	522	/* Update synchronization mismatch */

--------------Boundary-00=_1E88DFU80F00NB0F0OQD
Content-Type: text/x-diff;
  charset="us-ascii";
  name="glibc-enoattr-0.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="glibc-enoattr-0.diff"

--- glibc-2.2/sysdeps/gnu/errlist.c.orig	Tue Jul 30 10:17:08 2002
+++ glibc-2.2/sysdeps/gnu/errlist.c	Tue Jul 30 10:30:04 2002
@@ -607,6 +607,14 @@
 TRANS for information on process groups and these signals. */
     [ERR_REMAP (EBACKGROUND)] = N_("Inappropriate operation for background process"),
 #endif
+#ifdef ENOATTR
+/*
+TRANS No such attribute.  The named Extended Attribute does not exist, or the
+TRANS process does not have permission to access the attribute. This error
+TRANS is used by the getxattr, setxattr and removexattr system calls.
+TRANS */
+    [ERR_REMAP (ENOATTR)] = N_("No such attribute"),
+#endif
 #ifdef EDIED
 /*
 TRANS In the GNU system, opening a file returns this error when the file is

--------------Boundary-00=_1E88DFU80F00NB0F0OQD--

