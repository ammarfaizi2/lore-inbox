Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131600AbRDCLZf>; Tue, 3 Apr 2001 07:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131158AbRDCLZZ>; Tue, 3 Apr 2001 07:25:25 -0400
Received: from orbita.don.sitek.net ([213.24.25.98]:17162 "EHLO
	orbita.don.sitek.net") by vger.kernel.org with ESMTP
	id <S130317AbRDCLZI>; Tue, 3 Apr 2001 07:25:08 -0400
Date: Tue, 3 Apr 2001 15:23:28 +0400
From: Andrey Panin <pazke@orbita.don.sitek.net>
To: linux-kernel@vger.kernel.org
Cc: kernel-janitor-discuss@lists.sourceforge.net
Subject: [PATCH] MTRR driver: s/suser()/capable(CAP_SYS_ADMIN)/
Message-ID: <20010403152328.A5681@debian>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi all,

this patch (2.4.3) replaces suser() with capable(CAP_SYS_ADMIN) and adds mi=
ssing
KERN_* constants in some printk() calls.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-mtrr-suser
Content-Transfer-Encoding: quoted-printable

diff -ur /linux.vanilla/arch/i386/kernel/mtrr.c /linux/arch/i386/kernel/mtr=
r.c
--- /linux.vanilla/arch/i386/kernel/mtrr.c	Mon Apr  2 15:46:39 2001
+++ /linux/arch/i386/kernel/mtrr.c	Tue Apr  3 21:43:03 2001
@@ -1010,12 +1010,12 @@
 {
     if (!mask) return;
     if (mask & MTRR_CHANGE_MASK_FIXED)
-	printk ("mtrr: your CPUs had inconsistent fixed MTRR settings\n");
+	printk (KERN_WARNING "mtrr: your CPUs had inconsistent fixed MTRR setting=
s\n");
     if (mask & MTRR_CHANGE_MASK_VARIABLE)
-	printk ("mtrr: your CPUs had inconsistent variable MTRR settings\n");
+	printk (KERN_WARNING "mtrr: your CPUs had inconsistent variable MTRR sett=
ings\n");
     if (mask & MTRR_CHANGE_MASK_DEFTYPE)
-	printk ("mtrr: your CPUs had inconsistent MTRRdefType settings\n");
-    printk ("mtrr: probably your BIOS does not setup all CPUs\n");
+	printk (KERN_WARNING "mtrr: your CPUs had inconsistent MTRRdefType settin=
gs\n");
+    printk (KERN_WARNING "mtrr: probably your BIOS does not setup all CPUs=
\n");
 }   /*  End Function mtrr_state_warn  */
=20
 #endif  /*  CONFIG_SMP  */
@@ -1224,7 +1224,7 @@
=20
     if (type >=3D MTRR_NUM_TYPES)
     {
-	printk ("mtrr: type: %u illegal\n", type);
+	printk (KERN_WARNING "mtrr: type: %u illegal\n", type);
 	return -EINVAL;
     }
=20
@@ -1237,7 +1237,7 @@
=20
     if ( base & size_or_mask || size  & size_or_mask )
     {
-	printk ("mtrr: base or size exceeds the MTRR width\n");
+	printk (KERN_WARNING "mtrr: base or size exceeds the MTRR width\n");
 	return -EINVAL;
     }
=20
@@ -1264,7 +1264,7 @@
 	{
 	    if (type =3D=3D MTRR_TYPE_UNCACHABLE) continue;
 	    up(&main_lock);
-	    printk ( "mtrr: type mismatch for %lx000,%lx000 old: %s new: %s\n",
+	    printk (KERN_WARNING "mtrr: type mismatch for %lx000,%lx000 old: %s n=
ew: %s\n",
 		     base, size, attrib_to_str (ltype), attrib_to_str (type) );
 	    return -EINVAL;
 	}
@@ -1278,7 +1278,7 @@
     if (i < 0)
     {
 	up(&main_lock);
-	printk ("mtrr: no more MTRRs available\n");
+	printk (KERN_WARNING "mtrr: no more MTRRs available\n");
 	return i;
     }
     set_mtrr (i, base, size, type);
@@ -1338,8 +1338,8 @@
=20
     if ( (base & (PAGE_SIZE - 1)) || (size & (PAGE_SIZE - 1)) )
     {
-	printk ("mtrr: size and base must be multiples of 4 kiB\n");
-	printk ("mtrr: size: 0x%lx  base: 0x%lx\n", size, base);
+	printk (KERN_ERR "mtrr: size and base must be multiples of 4 kiB\n");
+	printk (KERN_ERR "mtrr: size: 0x%lx  base: 0x%lx\n", size, base);
 	return -EINVAL;
     }
     return mtrr_add_page(base >> PAGE_SHIFT, size >> PAGE_SHIFT, type, inc=
rement);
@@ -1394,14 +1394,14 @@
 	if (reg < 0)
 	{
 	    up(&main_lock);
-	    printk ("mtrr: no MTRR for %lx000,%lx000 found\n", base, size);
+	    printk (KERN_ERR "mtrr: no MTRR for %lx000,%lx000 found\n", base, siz=
e);
 	    return -EINVAL;
 	}
     }
     if (reg >=3D max)
     {
 	up (&main_lock);
-	printk ("mtrr: register: %d too big\n", reg);
+	printk (KERN_ERR "mtrr: register: %d too big\n", reg);
 	return -EINVAL;
     }
     if ( mtrr_if =3D=3D MTRR_IF_CYRIX_ARR )
@@ -1409,7 +1409,7 @@
 	if ( (reg =3D=3D 3) && arr3_protected )
 	{
 	    up (&main_lock);
-	    printk ("mtrr: ARR3 cannot be changed\n");
+	    printk (KERN_ERR "mtrr: ARR3 cannot be changed\n");
 	    return -EINVAL;
 	}
     }
@@ -1417,13 +1417,13 @@
     if (lsize < 1)
     {
 	up (&main_lock);
-	printk ("mtrr: MTRR %d not used\n", reg);
+	printk (KERN_ERR "mtrr: MTRR %d not used\n", reg);
 	return -EINVAL;
     }
     if (usage_table[reg] < 1)
     {
 	up (&main_lock);
-	printk ("mtrr: reg: %d has count=3D0\n", reg);
+	printk (KERN_ERR "mtrr: reg: %d has count=3D0\n", reg);
 	return -EINVAL;
     }
     if (--usage_table[reg] < 1) set_mtrr (reg, 0, 0, 0);
@@ -1459,8 +1459,8 @@
 {
     if ( (base & (PAGE_SIZE - 1)) || (size & (PAGE_SIZE - 1)) )
     {
-	printk ("mtrr: size and base must be multiples of 4 kiB\n");
-	printk ("mtrr: size: 0x%lx  base: 0x%lx\n", size, base);
+	printk (KERN_ERR "mtrr: size and base must be multiples of 4 kiB\n");
+	printk (KERN_ERR "mtrr: size: 0x%lx  base: 0x%lx\n", size, base);
 	return -EINVAL;
     }
     return mtrr_del_page(reg, base >> PAGE_SHIFT, size >> PAGE_SHIFT);
@@ -1479,7 +1479,7 @@
     {
 	if ( ( fcount =3D kmalloc (max * sizeof *fcount, GFP_KERNEL) ) =3D=3D NUL=
L )
 	{
-	    printk ("mtrr: could not allocate\n");
+	    printk (KERN_ERR "mtrr: could not allocate\n");
 	    return -ENOMEM;
 	}
 	memset (fcount, 0, max * sizeof *fcount);
@@ -1488,8 +1488,8 @@
     if (!page) {
 	if ( (base & (PAGE_SIZE - 1)) || (size & (PAGE_SIZE - 1)) )
 	{
-	    printk ("mtrr: size and base must be multiples of 4 kiB\n");
-	    printk ("mtrr: size: 0x%lx  base: 0x%lx\n", size, base);
+	    printk (KERN_ERR "mtrr: size and base must be multiples of 4 kiB\n");
+	    printk (KERN_ERR "mtrr: size: 0x%lx  base: 0x%lx\n", size, base);
 	    return -EINVAL;
 	}
 	base >>=3D PAGE_SHIFT;
@@ -1509,8 +1509,8 @@
     if (!page) {
 	if ( (base & (PAGE_SIZE - 1)) || (size & (PAGE_SIZE - 1)) )
 	{
-	    printk ("mtrr: size and base must be multiples of 4 kiB\n");
-	    printk ("mtrr: size: 0x%lx  base: 0x%lx\n", size, base);
+	    printk (KERN_ERR "mtrr: size and base must be multiples of 4 kiB\n");
+	    printk (KERN_ERR "mtrr: size: 0x%lx  base: 0x%lx\n", size, base);
 	    return -EINVAL;
 	}
 	base >>=3D PAGE_SHIFT;
@@ -1547,7 +1547,7 @@
     char *ptr;
     char line[LINE_SIZE];
=20
-    if ( !suser () ) return -EPERM;
+    if ( !capable(CAP_SYS_ADMIN) ) return -EPERM;
     /*  Can't seek (pwrite) on this device  */
     if (ppos !=3D &file->f_pos) return -ESPIPE;
     memset (line, 0, LINE_SIZE);
@@ -1564,27 +1564,27 @@
     }
     if ( strncmp (line, "base=3D", 5) )
     {
-	printk ("mtrr: no \"base=3D\" in line: \"%s\"\n", line);
+	printk (KERN_ERR "mtrr: no \"base=3D\" in line: \"%s\"\n", line);
 	return -EINVAL;
     }
     base =3D simple_strtoull (line + 5, &ptr, 0);
     for (; isspace (*ptr); ++ptr);
     if ( strncmp (ptr, "size=3D", 5) )
     {
-	printk ("mtrr: no \"size=3D\" in line: \"%s\"\n", line);
+	printk (KERN_ERR "mtrr: no \"size=3D\" in line: \"%s\"\n", line);
 	return -EINVAL;
     }
     size =3D simple_strtoull (ptr + 5, &ptr, 0);
     if ( (base & 0xfff) || (size & 0xfff) )
     {
-	printk ("mtrr: size and base must be multiples of 4 kiB\n");
-	printk ("mtrr: size: 0x%Lx  base: 0x%Lx\n", size, base);
+	printk (KERN_ERR "mtrr: size and base must be multiples of 4 kiB\n");
+	printk (KERN_ERR "mtrr: size: 0x%Lx  base: 0x%Lx\n", size, base);
 	return -EINVAL;
     }
     for (; isspace (*ptr); ++ptr);
     if ( strncmp (ptr, "type=3D", 5) )
     {
-	printk ("mtrr: no \"type=3D\" in line: \"%s\"\n", line);
+	printk (KERN_ERR "mtrr: no \"type=3D\" in line: \"%s\"\n", line);
 	return -EINVAL;
     }
     ptr +=3D 5;
@@ -1598,7 +1598,7 @@
 	if (err < 0) return err;
 	return len;
     }
-    printk ("mtrr: illegal type: \"%s\"\n", ptr);
+    printk (KERN_ERR "mtrr: illegal type: \"%s\"\n", ptr);
     return -EINVAL;
 }   /*  End Function mtrr_write  */
=20
@@ -1615,28 +1615,28 @@
       default:
 	return -ENOIOCTLCMD;
       case MTRRIOC_ADD_ENTRY:
-	if ( !suser () ) return -EPERM;
+	if ( !capable(CAP_SYS_ADMIN) ) return -EPERM;
 	if ( copy_from_user (&sentry, (void *) arg, sizeof sentry) )
 	    return -EFAULT;
 	err =3D mtrr_file_add (sentry.base, sentry.size, sentry.type, 1, file, 0);
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
@@ -1661,28 +1661,28 @@
 	     return -EFAULT;
 	break;
       case MTRRIOC_ADD_PAGE_ENTRY:
-	if ( !suser () ) return -EPERM;
+	if ( !capable(CAP_SYS_ADMIN) ) return -EPERM;
 	if ( copy_from_user (&sentry, (void *) arg, sizeof sentry) )
 	    return -EFAULT;
 	err =3D mtrr_file_add (sentry.base, sentry.size, sentry.type, 1, file, 1);
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
@@ -1714,7 +1714,7 @@
     {
 	while (fcount[i] > 0)
 	{
-	    if (mtrr_del (i, 0, 0) < 0) printk ("mtrr: reg %d not used\n", i);
+	    if (mtrr_del (i, 0, 0) < 0) printk (KERN_WARNING "mtrr: reg %d not us=
ed\n", i);
 	    --fcount[i];
 	}
     }
@@ -1896,14 +1896,14 @@
=20
     set_mtrr_done (&ctxt); /* flush cache and disable MAPEN */
=20
-    if ( ccrc[5] ) printk ("mtrr: ARR usage was not enabled, enabled manua=
lly\n");
-    if ( ccrc[3] ) printk ("mtrr: ARR3 cannot be changed\n");
+    if ( ccrc[5] ) printk (KERN_INFO "mtrr: ARR usage was not enabled, ena=
bled manually\n");
+    if ( ccrc[3] ) printk (KERN_INFO "mtrr: ARR3 cannot be changed\n");
 /*
     if ( ccrc[1] & 0x80) printk ("mtrr: SMM memory access through ARR3 dis=
abled\n");
     if ( ccrc[1] & 0x04) printk ("mtrr: SMM memory access disabled\n");
     if ( ccrc[1] & 0x02) printk ("mtrr: SMM mode disabled\n");
 */
-    if ( ccrc[6] ) printk ("mtrr: ARR3 was write protected, unprotected\n"=
);
+    if ( ccrc[6] ) printk (KERN_INFO "mtrr: ARR3 was write protected, unpr=
otected\n");
 }   /*  End Function cyrix_arr_init  */
=20
 static void __init centaur_mcr_init(void)
@@ -1991,8 +1991,8 @@
 	mtrr_if =3D MTRR_IF_NONE;
     }
=20
-    printk ("mtrr: v%s Richard Gooch (rgooch@atnf.csiro.au)\n"
-	    "mtrr: detected mtrr type: %s\n",
+    printk (KERN_INFO "mtrr: v%s Richard Gooch (rgooch@atnf.csiro.au)\n"
+	    KERN_INFO "mtrr: detected mtrr type: %s\n",
 	    MTRR_VERSION, mtrr_if_name[mtrr_if]);
=20
     return (mtrr_if !=3D MTRR_IF_NONE);
@@ -2051,7 +2051,7 @@
 	break;
     default:
 	/* I see no MTRRs I can support in SMP mode... */
-	printk ("mtrr: SMP support incomplete for this vendor\n");
+	printk (KERN_INFO "mtrr: SMP support incomplete for this vendor\n");
     }
 }   /*  End Function mtrr_init_secondary_cpu  */
 #endif  /*  CONFIG_SMP  */

--x+6KMIRAuhnl3hBn--

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6ybKwBm4rlNOo3YgRAmlhAJwMkClTjyVeNn3MriQE7SpEUDsTygCggIWx
XVxfefARam93NahDHJNCVM8=
=7u9O
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
