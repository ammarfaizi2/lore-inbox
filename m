Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSDZX30>; Fri, 26 Apr 2002 19:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314543AbSDZX3Z>; Fri, 26 Apr 2002 19:29:25 -0400
Received: from dhcp024-209-107-204.woh.rr.com ([24.209.107.204]:11932 "HELO
	hoho.shacknet.nu") by vger.kernel.org with SMTP id <S314529AbSDZX3Q>;
	Fri, 26 Apr 2002 19:29:16 -0400
Subject: [PATCH] Various suser() -> capable() chang
From: Colin Slater <hoho@binbash.net>
To: linux-kernel@vger.kernel.org
Cc: davej@suse.de
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-0xZl6SBn6c/FQw0SRftD"
X-Mailer: Ximian Evolution 1.0.3 
Date: 26 Apr 2002 19:28:28 -0400
Message-Id: <1019863708.8034.3092.camel@neptune>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0xZl6SBn6c/FQw0SRftD
Content-Type: multipart/mixed; boundary="=-jMy8GVOD5DQGsLZq/Jub"


--=-jMy8GVOD5DQGsLZq/Jub
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,=20
  I've made several cleanups changeing suser() to capable(CAP_SYS_ADMIN)
changes. This patch is mostly one line changes to 20 files, some files
with more. If any maintainers want to pick up these changes and
integrate them themselves, it would be appreciated. I can easily split
the patch if needed. This patch is aginst 2.5.10, and is already in
2.5.9-dj1.=20

DaveJ: same patch, just re-diffed.=20

   Colin=20


diffstat:=20
arch/i386/kernel/mtrr.c       |   18 +++++++++---------=20
arch/ppc64/kernel/ioctl32.c   |    2 +-=20
arch/sparc64/kernel/ioctl32.c |    2 +-=20
arch/x86_64/ia32/ia32_ioctl.c |    2 +-=20
arch/x86_64/kernel/mtrr.c     |   18 +++++++++---------=20
drivers/block/cpqarray.c      |    6 +++---=20
drivers/block/swim3.c         |    2 +-=20
drivers/block/swim_iop.c      |    2 +-=20
drivers/char/ip2main.c        |    2 +-=20
drivers/char/moxa.c           |    2 +-=20
drivers/char/mxser.c          |    2 +-=20
drivers/char/rio/rio_linux.c  |    2 +-=20
drivers/char/rocket.c         |    4 ----=20
drivers/char/serial167.c      |    2 +-=20
drivers/char/tty_io.c         |    8 ++++----=20
drivers/char/vt.c             |    6 +++---=20
drivers/media/video/zr36120.c |    2 +-=20
drivers/pcmcia/ds.c           |    2 +-=20
drivers/s390/char/tubtty.c    |    2 +-=20
drivers/scsi/cpqfcTSinit.c    |    2 +-=20
20 files changed, 42 insertions(+), 46 deletions(-)=20



--=20
-----
GPG Key 0x626FD58E; wwwkeys.pgp.net
6788 94B7 A407 A1D4 1B05  2559 FD52 D2D0 626F D58E

--=-jMy8GVOD5DQGsLZq/Jub
Content-Description: 
Content-Disposition: inline; filename=suser2.patch
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: quoted-printable

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.558   -> 1.559 =20
#	arch/x86_64/ia32/ia32_ioctl.c	1.5     -> 1.6   =20
#	drivers/block/swim_iop.c	1.3     -> 1.4   =20
#	arch/i386/kernel/mtrr.c	1.16    -> 1.17  =20
#	drivers/char/rio/rio_linux.c	1.8     -> 1.9   =20
#	drivers/scsi/cpqfcTSinit.c	1.13    -> 1.14  =20
#	drivers/char/rocket.c	1.10    -> 1.11  =20
#	drivers/block/cpqarray.c	1.30    -> 1.31  =20
#	 drivers/pcmcia/ds.c	1.12    -> 1.13  =20
#	arch/x86_64/kernel/mtrr.c	1.2     -> 1.3   =20
#	arch/sparc64/kernel/ioctl32.c	1.26    -> 1.27  =20
#	drivers/block/swim3.c	1.4     -> 1.5   =20
#	drivers/char/serial167.c	1.7     -> 1.8   =20
#	drivers/media/video/zr36120.c	1.14    -> 1.15  =20
#	drivers/char/ip2main.c	1.9     -> 1.10  =20
#	drivers/char/tty_io.c	1.23    -> 1.24  =20
#	drivers/char/mxser.c	1.10    -> 1.11  =20
#	   drivers/char/vt.c	1.9     -> 1.10  =20
#	drivers/s390/char/tubtty.c	1.4     -> 1.5   =20
#	 drivers/char/moxa.c	1.9     -> 1.10  =20
#	arch/ppc64/kernel/ioctl32.c	1.3     -> 1.4   =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/26	cslater@neptune.tacomeat.null	1.559
# Changed suser() to capable(CAP_SYS_ADMIN) in various places.
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/mtrr.c b/arch/i386/kernel/mtrr.c
--- a/arch/i386/kernel/mtrr.c	Fri Apr 26 18:34:23 2002
+++ b/arch/i386/kernel/mtrr.c	Fri Apr 26 18:34:23 2002
@@ -1659,7 +1659,7 @@
     char *ptr;
     char line[LINE_SIZE];
=20
-    if ( !suser () ) return -EPERM;
+    if ( !capable(CAP_SYS_ADMIN)) return -EPERM;
     /*  Can't seek (pwrite) on this device  */
     if (ppos !=3D &file->f_pos) return -ESPIPE;
     memset (line, 0, LINE_SIZE);
@@ -1727,28 +1727,28 @@
       default:
 	return -ENOIOCTLCMD;
       case MTRRIOC_ADD_ENTRY:
-	if ( !suser () ) return -EPERM;
+	if ( ! capable(CAP_SYS_ADMIN) ) return -EPERM;
 	if ( copy_from_user (&sentry, (void *) arg, sizeof sentry) )
 	    return -EFAULT;
 	err =3D mtrr_file_add (sentry.base, sentry.size, sentry.type, 1, file, 0)=
;
 	if (err < 0) return err;
 	break;
       case MTRRIOC_SET_ENTRY:
-	if ( !suser () ) return -EPERM;
+	if ( !capable(CAP_SYS_ADMIN) ) return -EPERM;
 	if ( copy_from_user (&sentry, (void *) arg, sizeof sentry) )
 	    return -EFAULT;
 	err =3D mtrr_add (sentry.base, sentry.size, sentry.type, 0);
 	if (err < 0) return err;
 	break;
       case MTRRIOC_DEL_ENTRY:
-	if ( !suser () ) return -EPERM;
+	if ( !capable(CAP_SYS_ADMIN) ) return -EPERM;
 	if ( copy_from_user (&sentry, (void *) arg, sizeof sentry) )
 	    return -EFAULT;
 	err =3D mtrr_file_del (sentry.base, sentry.size, file, 0);
 	if (err < 0) return err;
 	break;
       case MTRRIOC_KILL_ENTRY:
-	if ( !suser () ) return -EPERM;
+	if ( !capable(CAP_SYS_ADMIN) ) return -EPERM;
 	if ( copy_from_user (&sentry, (void *) arg, sizeof sentry) )
 	    return -EFAULT;
 	err =3D mtrr_del (-1, sentry.base, sentry.size);
@@ -1773,28 +1773,28 @@
 	     return -EFAULT;
 	break;
       case MTRRIOC_ADD_PAGE_ENTRY:
-	if ( !suser () ) return -EPERM;
+	if ( !capable(CAP_SYS_ADMIN) ) return -EPERM;
 	if ( copy_from_user (&sentry, (void *) arg, sizeof sentry) )
 	    return -EFAULT;
 	err =3D mtrr_file_add (sentry.base, sentry.size, sentry.type, 1, file, 1)=
;
 	if (err < 0) return err;
 	break;
       case MTRRIOC_SET_PAGE_ENTRY:
-	if ( !suser () ) return -EPERM;
+	if ( !capable(CAP_SYS_ADMIN) ) return -EPERM;
 	if ( copy_from_user (&sentry, (void *) arg, sizeof sentry) )
 	    return -EFAULT;
 	err =3D mtrr_add_page (sentry.base, sentry.size, sentry.type, 0);
 	if (err < 0) return err;
 	break;
       case MTRRIOC_DEL_PAGE_ENTRY:
-	if ( !suser () ) return -EPERM;
+	if ( !capable(CAP_SYS_ADMIN) ) return -EPERM;
 	if ( copy_from_user (&sentry, (void *) arg, sizeof sentry) )
 	    return -EFAULT;
 	err =3D mtrr_file_del (sentry.base, sentry.size, file, 1);
 	if (err < 0) return err;
 	break;
       case MTRRIOC_KILL_PAGE_ENTRY:
-	if ( !suser () ) return -EPERM;
+	if ( !capable(CAP_SYS_ADMIN) ) return -EPERM;
 	if ( copy_from_user (&sentry, (void *) arg, sizeof sentry) )
 	    return -EFAULT;
 	err =3D mtrr_del_page (-1, sentry.base, sentry.size);
diff -Nru a/arch/ppc64/kernel/ioctl32.c b/arch/ppc64/kernel/ioctl32.c
--- a/arch/ppc64/kernel/ioctl32.c	Fri Apr 26 18:34:23 2002
+++ b/arch/ppc64/kernel/ioctl32.c	Fri Apr 26 18:34:23 2002
@@ -1561,7 +1561,7 @@
 	 * To have permissions to do most of the vt ioctls, we either have
 	 * to be the owner of the tty, or super-user.
 	 */
-	if (current->tty =3D=3D tty || suser())
+	if (current->tty =3D=3D tty || capable(CAP_SYS_ADMIN))
 		return 1;
 	return 0;                                                   =20
 }
diff -Nru a/arch/sparc64/kernel/ioctl32.c b/arch/sparc64/kernel/ioctl32.c
--- a/arch/sparc64/kernel/ioctl32.c	Fri Apr 26 18:34:23 2002
+++ b/arch/sparc64/kernel/ioctl32.c	Fri Apr 26 18:34:23 2002
@@ -2060,7 +2060,7 @@
 	 * To have permissions to do most of the vt ioctls, we either have
 	 * to be the owner of the tty, or super-user.
 	 */
-	if (current->tty =3D=3D tty || suser())
+	if (current->tty =3D=3D tty || capable(CAP_SYS_ADMIN))
 		return 1;
 	return 0;                                                   =20
 }
diff -Nru a/arch/x86_64/ia32/ia32_ioctl.c b/arch/x86_64/ia32/ia32_ioctl.c
--- a/arch/x86_64/ia32/ia32_ioctl.c	Fri Apr 26 18:34:23 2002
+++ b/arch/x86_64/ia32/ia32_ioctl.c	Fri Apr 26 18:34:23 2002
@@ -1650,7 +1650,7 @@
 	 * To have permissions to do most of the vt ioctls, we either have
 	 * to be the owner of the tty, or super-user.
 	 */
-	if (current->tty =3D=3D tty || suser())
+	if (current->tty =3D=3D tty || capable(CAP_SYS_ADMIN))
 		return 1;
 	return 0;                                                   =20
 }
diff -Nru a/arch/x86_64/kernel/mtrr.c b/arch/x86_64/kernel/mtrr.c
--- a/arch/x86_64/kernel/mtrr.c	Fri Apr 26 18:34:23 2002
+++ b/arch/x86_64/kernel/mtrr.c	Fri Apr 26 18:34:23 2002
@@ -983,7 +983,7 @@
     char *ptr;
     char line[LINE_SIZE];
=20
-	if (!suser ())
+	if (!capable (CAP_SYS_ADMIN))
 		return -EPERM;
=20
     /*  Can't seek (pwrite) on this device  */
@@ -1071,7 +1071,7 @@
 	return -ENOIOCTLCMD;
=20
       case MTRRIOC_ADD_ENTRY:
-		if (!suser ())
+		if (!capable (CAP_SYS_ADMIN))
 			return -EPERM;
 		if (copy_from_user (&sentry, (void *) arg, sizeof sentry))
 	    return -EFAULT;
@@ -1083,7 +1083,7 @@
 	break;
=20
       case MTRRIOC_SET_ENTRY:
-		if (!suser ())
+		if (!capable (CAP_SYS_ADMIN))
 			return -EPERM;
 		if (copy_from_user (&sentry, (void *) arg, sizeof sentry))
 	    return -EFAULT;
@@ -1093,7 +1093,7 @@
 	break;
=20
       case MTRRIOC_DEL_ENTRY:
-		if (!suser ())
+		if (!capable (CAP_SYS_ADMIN))
 			return -EPERM;
 		if (copy_from_user (&sentry, (void *) arg, sizeof sentry))
 	    return -EFAULT;
@@ -1103,7 +1103,7 @@
 	break;
=20
       case MTRRIOC_KILL_ENTRY:
-		if (!suser ())
+		if (!capable (CAP_SYS_ADMIN))
 			return -EPERM;
 		if (copy_from_user (&sentry, (void *) arg, sizeof sentry))
 	    return -EFAULT;
@@ -1134,7 +1134,7 @@
 	break;
=20
       case MTRRIOC_ADD_PAGE_ENTRY:
-		if (!suser ())
+		if (!capable (CAP_SYS_ADMIN))
 			return -EPERM;
 		if (copy_from_user (&sentry, (void *) arg, sizeof sentry))
 	    return -EFAULT;
@@ -1146,7 +1146,7 @@
 	break;
=20
       case MTRRIOC_SET_PAGE_ENTRY:
-		if (!suser ())
+		if (!capable (CAP_SYS_ADMIN))
 			return -EPERM;
 		if (copy_from_user (&sentry, (void *) arg, sizeof sentry))
 	    return -EFAULT;
@@ -1156,7 +1156,7 @@
 	break;
=20
       case MTRRIOC_DEL_PAGE_ENTRY:
-		if (!suser ())
+		if (!capable (CAP_SYS_ADMIN))
 			return -EPERM;
 		if (copy_from_user (&sentry, (void *) arg, sizeof sentry))
 	    return -EFAULT;
@@ -1166,7 +1166,7 @@
 	break;
=20
       case MTRRIOC_KILL_PAGE_ENTRY:
-		if (!suser ())
+		if (!capable (CAP_SYS_ADMIN))
 			return -EPERM;
 		if (copy_from_user (&sentry, (void *) arg, sizeof sentry))
 	    return -EFAULT;
diff -Nru a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
--- a/drivers/block/cpqarray.c	Fri Apr 26 18:34:23 2002
+++ b/drivers/block/cpqarray.c	Fri Apr 26 18:34:23 2002
@@ -787,7 +787,7 @@
 	if (ctlr > MAX_CTLR || hba[ctlr] =3D=3D NULL)
 		return -ENXIO;
=20
-	if (!suser() && ida_sizes[(ctlr << CTLR_SHIFT) +
+	if (!capable(CAP_SYS_ADMIN) && ida_sizes[(ctlr << CTLR_SHIFT) +
 						minor(inode->i_rdev)] =3D=3D 0)
 		return -ENXIO;
=20
@@ -797,7 +797,7 @@
 	 * but I'm already using way to many device nodes to claim another one
 	 * for "raw controller".
 	 */
-	if (suser()
+	if (capable(CAP_SYS_ADMIN)
 		&& ida_sizes[(ctlr << CTLR_SHIFT) + minor(inode->i_rdev)] =3D=3D 0=20
 		&& minor(inode->i_rdev) !=3D 0)
 		return -ENXIO;
@@ -1139,7 +1139,7 @@
 	case BLKRRPART:
 		return revalidate_logvol(inode->i_rdev, 1);
 	case IDAPASSTHRU:
-		if (!suser()) return -EPERM;
+		if (!capable(CAP_SYS_ADMIN)) return -EPERM;
 		error =3D copy_from_user(&my_io, io, sizeof(my_io));
 		if (error) return error;
 		error =3D ida_ctlr_ioctl(ctlr, dsk, &my_io);
diff -Nru a/drivers/block/swim3.c b/drivers/block/swim3.c
--- a/drivers/block/swim3.c	Fri Apr 26 18:34:23 2002
+++ b/drivers/block/swim3.c	Fri Apr 26 18:34:23 2002
@@ -821,7 +821,7 @@
 	if (devnum >=3D floppy_count)
 		return -ENODEV;
 	=09
-	if ((cmd & 0x80) && !suser())
+	if ((cmd & 0x80) && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
=20
 	fs =3D &floppy_states[devnum];
diff -Nru a/drivers/block/swim_iop.c b/drivers/block/swim_iop.c
--- a/drivers/block/swim_iop.c	Fri Apr 26 18:34:23 2002
+++ b/drivers/block/swim_iop.c	Fri Apr 26 18:34:23 2002
@@ -349,7 +349,7 @@
 	if (devnum >=3D floppy_count)
 		return -ENODEV;
 	=09
-	if ((cmd & 0x80) && !suser())
+	if ((cmd & 0x80) && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
=20
 	fs =3D &floppy_states[devnum];
diff -Nru a/drivers/char/ip2main.c b/drivers/char/ip2main.c
--- a/drivers/char/ip2main.c	Fri Apr 26 18:34:23 2002
+++ b/drivers/char/ip2main.c	Fri Apr 26 18:34:23 2002
@@ -2660,7 +2660,7 @@
 	old_flags =3D pCh->flags;
 	old_baud_divisor =3D pCh->BaudDivisor;
=20
-	if ( !suser() ) {
+	if ( !capable(CAP_SYS_ADMIN) ) {
 		if ( ( ns.close_delay !=3D pCh->ClosingDelay ) ||
 		    ( (ns.flags & ~ASYNC_USR_MASK) !=3D
 		      (pCh->flags & ~ASYNC_USR_MASK) ) ) {
diff -Nru a/drivers/char/moxa.c b/drivers/char/moxa.c
--- a/drivers/char/moxa.c	Fri Apr 26 18:34:23 2002
+++ b/drivers/char/moxa.c	Fri Apr 26 18:34:23 2002
@@ -2799,7 +2799,7 @@
 	    (new_serial.baud_base !=3D 921600))
 		return (-EPERM);
=20
-	if (!suser()) {
+	if (!capable(CAP_SYS_ADMIN)) {
 		if (((new_serial.flags & ~ASYNC_USR_MASK) !=3D
 		     (info->asyncflags & ~ASYNC_USR_MASK)))
 			return (-EPERM);
diff -Nru a/drivers/char/mxser.c b/drivers/char/mxser.c
--- a/drivers/char/mxser.c	Fri Apr 26 18:34:23 2002
+++ b/drivers/char/mxser.c	Fri Apr 26 18:34:23 2002
@@ -2199,7 +2199,7 @@
=20
 	flags =3D info->flags & ASYNC_SPD_MASK;
=20
-	if (!suser()) {
+	if (!capable(CAP_SYS_ADMIN)) {
 		if ((new_serial.baud_base !=3D info->baud_base) ||
 		    (new_serial.close_delay !=3D info->close_delay) ||
 		    ((new_serial.flags & ~ASYNC_USR_MASK) !=3D
diff -Nru a/drivers/char/rio/rio_linux.c b/drivers/char/rio/rio_linux.c
--- a/drivers/char/rio/rio_linux.c	Fri Apr 26 18:34:23 2002
+++ b/drivers/char/rio/rio_linux.c	Fri Apr 26 18:34:23 2002
@@ -702,7 +702,7 @@
   func_enter();
=20
   /* The "dev" argument isn't used. */
-  rc =3D -riocontrol (p, 0, cmd, (void *)arg, suser ());
+  rc =3D -riocontrol (p, 0, cmd, (void *)arg, capable(CAP_SYS_ADMIN));
=20
   func_exit ();
   return rc;
diff -Nru a/drivers/char/rocket.c b/drivers/char/rocket.c
--- a/drivers/char/rocket.c	Fri Apr 26 18:34:23 2002
+++ b/drivers/char/rocket.c	Fri Apr 26 18:34:23 2002
@@ -1238,11 +1238,7 @@
 	if (copy_from_user(&new_serial, new_info, sizeof(new_serial)))
 		return -EFAULT;
=20
-#ifdef CAP_SYS_ADMIN
 	if (!capable(CAP_SYS_ADMIN))
-#else
-	if (!suser())
-#endif
 	{
 		if ((new_serial.flags & ~ROCKET_USR_MASK) !=3D
 		    (info->flags & ~ROCKET_USR_MASK))
diff -Nru a/drivers/char/serial167.c b/drivers/char/serial167.c
--- a/drivers/char/serial167.c	Fri Apr 26 18:34:23 2002
+++ b/drivers/char/serial167.c	Fri Apr 26 18:34:23 2002
@@ -1472,7 +1472,7 @@
 	    return -EFAULT;
     old_info =3D *info;
=20
-    if (!suser()) {
+    if (!capable(CAP_SYS_ADMIN)) {
 	    if ((new_serial.close_delay !=3D info->close_delay) ||
 		((new_serial.flags & ASYNC_FLAGS & ~ASYNC_USR_MASK) !=3D
 		 (info->flags & ASYNC_FLAGS & ~ASYNC_USR_MASK)))
diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Fri Apr 26 18:34:23 2002
+++ b/drivers/char/tty_io.c	Fri Apr 26 18:34:23 2002
@@ -1370,7 +1370,7 @@
 		retval =3D -ENODEV;
 	filp->f_flags =3D saved_flags;
=20
-	if (!retval && test_bit(TTY_EXCLUSIVE, &tty->flags) && !suser())
+	if (!retval && test_bit(TTY_EXCLUSIVE, &tty->flags) && !capable(CAP_SYS_A=
DMIN))
 		retval =3D -EBUSY;
=20
 	if (retval) {
@@ -1472,7 +1472,7 @@
 {
 	char ch, mbz =3D 0;
=20
-	if ((current->tty !=3D tty) && !suser())
+	if ((current->tty !=3D tty) && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 	if (get_user(ch, arg))
 		return -EFAULT;
@@ -1510,7 +1510,7 @@
 {
 	if (IS_SYSCONS_DEV(inode->i_rdev) ||
 	    IS_CONSOLE_DEV(inode->i_rdev)) {
-		if (!suser())
+		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		redirect =3D NULL;
 		return 0;
@@ -1552,7 +1552,7 @@
 		 * This tty is already the controlling
 		 * tty for another session group!
 		 */
-		if ((arg =3D=3D 1) && suser()) {
+		if ((arg =3D=3D 1) && capable(CAP_SYS_ADMIN)) {
 			/*
 			 * Steal it away
 			 */
diff -Nru a/drivers/char/vt.c b/drivers/char/vt.c
--- a/drivers/char/vt.c	Fri Apr 26 18:34:23 2002
+++ b/drivers/char/vt.c	Fri Apr 26 18:34:23 2002
@@ -443,7 +443,7 @@
 	 * to be the owner of the tty, or super-user.
 	 */
 	perm =3D 0;
-	if (current->tty =3D=3D tty || suser())
+	if (current->tty =3D=3D tty || capable(CAP_SYS_ADMIN))
 		perm =3D 1;
 =20
 	kbd =3D kbd_table + console;
@@ -1038,12 +1038,12 @@
 		return do_unimap_ioctl(cmd, (struct unimapdesc *)arg, perm);
=20
 	case VT_LOCKSWITCH:
-		if (!suser())
+		if (!capable(CAP_SYS_ADMIN))
 		   return -EPERM;
 		vt_dont_switch =3D 1;
 		return 0;
 	case VT_UNLOCKSWITCH:
-		if (!suser())
+		if (!capable(CAP_SYS_ADMIN))
 		   return -EPERM;
 		vt_dont_switch =3D 0;
 		return 0;
diff -Nru a/drivers/media/video/zr36120.c b/drivers/media/video/zr36120.c
--- a/drivers/media/video/zr36120.c	Fri Apr 26 18:34:23 2002
+++ b/drivers/media/video/zr36120.c	Fri Apr 26 18:34:23 2002
@@ -1294,7 +1294,7 @@
 #if LINUX_VERSION_CODE >=3D 0x020100
 			if(!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_ADMIN))
 #else
-			if(!suser())
+			if(!capable(CAP_SYS_ADMIN))
 #endif
 			return -EPERM;
 		if (copy_from_user(&v, arg,sizeof(v)))
diff -Nru a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
--- a/drivers/pcmcia/ds.c	Fri Apr 26 18:34:23 2002
+++ b/drivers/pcmcia/ds.c	Fri Apr 26 18:34:23 2002
@@ -830,7 +830,7 @@
 	err =3D unbind_request(i, &buf.bind_info);
 	break;
     case DS_BIND_MTD:
-	if (!suser()) return -EPERM;
+	if (!capable(CAP_SYS_ADMIN)) return -EPERM;
 	err =3D bind_mtd(i, &buf.mtd_info);
 	break;
     default:
diff -Nru a/drivers/s390/char/tubtty.c b/drivers/s390/char/tubtty.c
--- a/drivers/s390/char/tubtty.c	Fri Apr 26 18:34:23 2002
+++ b/drivers/s390/char/tubtty.c	Fri Apr 26 18:34:23 2002
@@ -561,7 +561,7 @@
 	/*
 	 * Superuser-mode settings affect the driver overall ---
 	 */
-	if (!suser()) {
+	if (!capable(CAP_SYS_ADMIN)) {
 		return -EPERM;
 	} else if (strncmp(mybuf, "index=3D", 6) =3D=3D 0) {
 		tty3270_proc_index =3D simple_strtoul(mybuf + 6, 0,0);
diff -Nru a/drivers/scsi/cpqfcTSinit.c b/drivers/scsi/cpqfcTSinit.c
--- a/drivers/scsi/cpqfcTSinit.c	Fri Apr 26 18:34:23 2002
+++ b/drivers/scsi/cpqfcTSinit.c	Fri Apr 26 18:34:23 2002
@@ -532,7 +532,7 @@
=20
 	// must be super user to send stuff directly to the
 	// controller and/or physical drives...
-	if( !suser() )
+	if( !capable(CAP_SYS_ADMIN) )
 	  return -EPERM;
=20
 	// copy the caller's struct to our space.

--=-jMy8GVOD5DQGsLZq/Jub--

--=-0xZl6SBn6c/FQw0SRftD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8yeKc/VLS0GJv1Y4RAo+UAKCVMFLRf6GnvKu54ZjO0rjbh8eGwwCfRCDb
1Hzsp4QpUemo2M9doMiZ4jw=
=KHGS
-----END PGP SIGNATURE-----

--=-0xZl6SBn6c/FQw0SRftD--
