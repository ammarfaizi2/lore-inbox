Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267938AbTBRRS1>; Tue, 18 Feb 2003 12:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267941AbTBRRS1>; Tue, 18 Feb 2003 12:18:27 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:64146 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S267938AbTBRRPk>; Tue, 18 Feb 2003 12:15:40 -0500
Message-ID: <3E526C94.3020109@namesys.com>
Date: Tue, 18 Feb 2003 20:25:40 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH]  comments on st_blksize and f_bsize for 2.5
Content-Type: multipart/mixed;
 boundary="------------090209000104090500030900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090209000104090500030900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Since a few applications, and the linux manpages, seem to not really 
understand what these are for, they need comments like SUSv2 has for 
them.  A larger discussion will be provided if requested.

-- 
Hans


--------------090209000104090500030900
Content-Type: message/rfc822;
 name="2.5 patch that comments on st_blksize and f_bsize"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.5 patch that comments on st_blksize and f_bsize"

Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 19272 invoked from network); 18 Feb 2003 13:24:30 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 18 Feb 2003 13:24:30 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id 38376468AFB; Tue, 18 Feb 2003 16:24:30 +0300 (MSK)
Date: Tue, 18 Feb 2003 16:24:30 +0300
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: 2.5 patch that comments on st_blksize and f_bsize
Message-ID: <20030218162430.A15124@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i

Hello!

   Here's the patch that adds necessary comments

===== include/asm-alpha/stat.h 1.1 vs edited =====
--- 1.1/include/asm-alpha/stat.h	Tue Feb  5 20:39:46 2002
+++ edited/include/asm-alpha/stat.h	Tue Feb 18 14:53:52 2003
@@ -13,7 +13,7 @@
 	unsigned long	st_atime;
 	unsigned long	st_mtime;
 	unsigned long	st_ctime;
-	unsigned int	st_blksize;
+	unsigned int	st_blksize;	/* Optimal I/O size */
 	int		st_blocks;
 	unsigned int	st_flags;
 	unsigned int	st_gen;
@@ -31,7 +31,7 @@
 	unsigned long	st_atime;
 	unsigned long	st_mtime;
 	unsigned long	st_ctime;
-	unsigned int	st_blksize;
+	unsigned int	st_blksize;	/* Optimal I/O size */
 	int		st_blocks;
 	unsigned int	st_flags;
 	unsigned int	st_gen;
===== include/asm-alpha/statfs.h 1.1 vs edited =====
--- 1.1/include/asm-alpha/statfs.h	Tue Feb  5 20:39:46 2002
+++ edited/include/asm-alpha/statfs.h	Tue Feb 18 14:56:10 2003
@@ -11,7 +11,7 @@
 
 struct statfs {
 	int f_type;
-	int f_bsize;
+	int f_bsize;	/* Filesystem blocksize */
 	int f_blocks;
 	int f_bfree;
 	int f_bavail;
===== include/asm-arm/stat.h 1.4 vs edited =====
--- 1.4/include/asm-arm/stat.h	Sun Nov 17 22:53:57 2002
+++ edited/include/asm-arm/stat.h	Tue Feb 18 14:53:52 2003
@@ -28,7 +28,7 @@
 	unsigned short st_rdev;
 	unsigned short __pad2;
 	unsigned long  st_size;
-	unsigned long  st_blksize;
+	unsigned long  st_blksize;	/* Optimal I/O size */
 	unsigned long  st_blocks;
 	unsigned long  st_atime;
 	unsigned long  st_atime_nsec;
@@ -73,7 +73,7 @@
 	unsigned char   __pad3[4];
 
 	long long	st_size;
-	unsigned long	st_blksize;
+	unsigned long	st_blksize;	/* Optimal I/O size */
 
 #if defined(__ARMEB__)
 	unsigned long   __pad4;		/* Future possible st_blocks hi bits */
===== include/asm-arm/statfs.h 1.1 vs edited =====
--- 1.1/include/asm-arm/statfs.h	Tue Feb  5 20:39:52 2002
+++ edited/include/asm-arm/statfs.h	Tue Feb 18 14:56:38 2003
@@ -11,7 +11,7 @@
 
 struct statfs {
 	long f_type;
-	long f_bsize;
+	long f_bsize;	/* Filesystem blocksize */
 	long f_blocks;
 	long f_bfree;
 	long f_bavail;
===== include/asm-cris/stat.h 1.3 vs edited =====
--- 1.3/include/asm-cris/stat.h	Sun Nov 17 22:53:57 2002
+++ edited/include/asm-cris/stat.h	Tue Feb 18 14:53:52 2003
@@ -31,7 +31,7 @@
 	unsigned short st_rdev;
 	unsigned short __pad2;
 	unsigned long  st_size;
-	unsigned long  st_blksize;
+	unsigned long  st_blksize;	/* Optimal I/O size */
 	unsigned long  st_blocks;
 	unsigned long  st_atime;
 	unsigned long  st_atime_nsec;
@@ -63,7 +63,7 @@
 	unsigned char	__pad3[10];
 
 	long long	st_size;
-	unsigned long	st_blksize;
+	unsigned long	st_blksize;	/* Optimal I/O size */
 
 	unsigned long	st_blocks;	/* Number 512-byte blocks allocated. */
 	unsigned long	__pad4;		/* future possible st_blocks high bits */
===== include/asm-cris/statfs.h 1.1 vs edited =====
--- 1.1/include/asm-cris/statfs.h	Tue Feb  5 20:56:43 2002
+++ edited/include/asm-cris/statfs.h	Tue Feb 18 14:56:10 2003
@@ -11,7 +11,7 @@
 
 struct statfs {
 	long f_type;
-	long f_bsize;
+	long f_bsize;	/* Filesystem blocksize */
 	long f_blocks;
 	long f_bfree;
 	long f_bavail;
===== include/asm-i386/stat.h 1.2 vs edited =====
--- 1.2/include/asm-i386/stat.h	Sun Nov 17 22:53:57 2002
+++ edited/include/asm-i386/stat.h	Tue Feb 18 14:54:21 2003
@@ -26,7 +26,7 @@
 	unsigned short st_rdev;
 	unsigned short __pad2;
 	unsigned long  st_size;
-	unsigned long  st_blksize;
+	unsigned long  st_blksize;	/* Optimal I/O size */
 	unsigned long  st_blocks;
 	unsigned long  st_atime;
 	unsigned long  st_atime_nsec;
@@ -58,7 +58,7 @@
 	unsigned char	__pad3[10];
 
 	long long	st_size;
-	unsigned long	st_blksize;
+	unsigned long	st_blksize;	/* Optimal I/O size */
 
 	unsigned long	st_blocks;	/* Number 512-byte blocks allocated. */
 	unsigned long	__pad4;		/* future possible st_blocks high bits */
===== include/asm-i386/statfs.h 1.1 vs edited =====
--- 1.1/include/asm-i386/statfs.h	Tue Feb  5 20:39:44 2002
+++ edited/include/asm-i386/statfs.h	Tue Feb 18 14:56:10 2003
@@ -11,7 +11,7 @@
 
 struct statfs {
 	long f_type;
-	long f_bsize;
+	long f_bsize;	/* Filesystem blocksize */
 	long f_blocks;
 	long f_bfree;
 	long f_bavail;
===== include/asm-ia64/stat.h 1.2 vs edited =====
--- 1.2/include/asm-ia64/stat.h	Sun Nov 17 22:53:57 2002
+++ edited/include/asm-ia64/stat.h	Tue Feb 18 14:53:52 2003
@@ -22,7 +22,7 @@
 	unsigned long	st_mtime_nsec;
 	unsigned long	st_ctime;
 	unsigned long	st_ctime_nsec;
-	unsigned long	st_blksize;
+	unsigned long	st_blksize;	/* Optimal I/O size */
 	long		st_blocks;
 	unsigned long	__unused[3];
 };
@@ -42,7 +42,7 @@
 	unsigned long	st_atime;
 	unsigned long	st_mtime;
 	unsigned long	st_ctime;
-	unsigned int	st_blksize;
+	unsigned int	st_blksize;	/* Optimal I/O size */
 	int		st_blocks;
 	unsigned int	__unused1;
 	unsigned int	__unused2;
===== include/asm-ia64/statfs.h 1.1 vs edited =====
--- 1.1/include/asm-ia64/statfs.h	Tue Feb  5 20:39:54 2002
+++ edited/include/asm-ia64/statfs.h	Tue Feb 18 14:56:10 2003
@@ -13,7 +13,7 @@
 
 struct statfs {
 	long f_type;
-	long f_bsize;
+	long f_bsize;	/* Filesystem blocksize */
 	long f_blocks;
 	long f_bfree;
 	long f_bavail;
===== include/asm-m68k/stat.h 1.3 vs edited =====
--- 1.3/include/asm-m68k/stat.h	Sun Nov 17 22:53:57 2002
+++ edited/include/asm-m68k/stat.h	Tue Feb 18 14:53:52 2003
@@ -26,7 +26,7 @@
 	unsigned short st_rdev;
 	unsigned short __pad2;
 	unsigned long  st_size;
-	unsigned long  st_blksize;
+	unsigned long  st_blksize;	/* Optimal I/O size */
 	unsigned long  st_blocks;
 	unsigned long  st_atime;
 	unsigned long  __unused1;
@@ -60,7 +60,7 @@
 	unsigned char	__pad3[2];
 
 	long long	st_size;
-	unsigned long	st_blksize;
+	unsigned long	st_blksize;	/* Optimal I/O size */
 
 	unsigned long	__pad4;		/* future possible st_blocks high bits */
 	unsigned long	st_blocks;	/* Number 512-byte blocks allocated. */
===== include/asm-m68k/statfs.h 1.1 vs edited =====
--- 1.1/include/asm-m68k/statfs.h	Tue Feb  5 20:39:46 2002
+++ edited/include/asm-m68k/statfs.h	Tue Feb 18 14:56:10 2003
@@ -11,7 +11,7 @@
 
 struct statfs {
 	long f_type;
-	long f_bsize;
+	long f_bsize;	/* Filesystem blocksize */
 	long f_blocks;
 	long f_bfree;
 	long f_bavail;
===== include/asm-mips/stat.h 1.3 vs edited =====
--- 1.3/include/asm-mips/stat.h	Sun Nov 17 22:53:57 2002
+++ edited/include/asm-mips/stat.h	Tue Feb 18 14:53:52 2003
@@ -15,7 +15,7 @@
 	unsigned int	st_atime, st_res1;
 	unsigned int	st_mtime, st_res2;
 	unsigned int	st_ctime, st_res3;
-	unsigned int	st_blksize;
+	unsigned int	st_blksize;	/* Optimal I/O size */
 	int		st_blocks;
 	unsigned int	st_unused0[2];
 };
@@ -42,7 +42,7 @@
 	long		st_mtime_nsec;
 	time_t		st_ctime;
 	long		st_ctime_nsec;
-	long		st_blksize;
+	long		st_blksize;	/* Optimal I/O size */
 	long		st_blocks;
 	long		st_pad4[14];
 };
@@ -83,7 +83,7 @@
 	time_t		st_ctime;
 	unsigned long	reserved2;	/* Reserved for st_ctime expansion  */
 
-	unsigned long	st_blksize;
+	unsigned long	st_blksize;	/* Optimal I/O size */
 	unsigned long	st_pad2;
 
 	long long	st_blocks;
===== include/asm-mips/statfs.h 1.1 vs edited =====
--- 1.1/include/asm-mips/statfs.h	Tue Feb  5 20:39:45 2002
+++ edited/include/asm-mips/statfs.h	Tue Feb 18 14:56:10 2003
@@ -23,7 +23,7 @@
 struct statfs {
 	long		f_type;
 #define f_fstyp f_type
-	long		f_bsize;
+	long		f_bsize;	/* Filesystem blocksize */
 	long		f_frsize;	/* Fragment size - unsupported */
 	long		f_blocks;
 	long		f_bfree;
===== include/asm-mips64/stat.h 1.3 vs edited =====
--- 1.3/include/asm-mips64/stat.h	Thu Dec 12 03:14:43 2002
+++ edited/include/asm-mips64/stat.h	Tue Feb 18 14:53:52 2003
@@ -24,7 +24,7 @@
 	unsigned int	st_atime, st_res1;
 	unsigned int	st_mtime, st_res2;
 	unsigned int	st_ctime, st_res3;
-	unsigned int	st_blksize;
+	unsigned int	st_blksize;	/* Optimal I/O size */
 	int		st_blocks;
 	unsigned int	st_unused[2];
 };
@@ -47,7 +47,7 @@
 	int		    reserved1;
 	compat_time_t     st_ctime;
 	int		    reserved2;
-	int		    st_blksize;
+	int		    st_blksize;	/* Optimal I/O size */
 	int		    st_blocks;
 	int		    st_pad4[14];
 };
@@ -83,7 +83,7 @@
 	unsigned int	st_ctime;
 	unsigned int	st_ctime_nsec;
 
-	unsigned int	st_blksize;
+	unsigned int	st_blksize;	/* Optimal I/O size */
 	unsigned int	st_pad2;
 
 	unsigned long	st_blocks;
===== include/asm-mips64/statfs.h 1.2 vs edited =====
--- 1.2/include/asm-mips64/statfs.h	Tue Feb  5 10:45:05 2002
+++ edited/include/asm-mips64/statfs.h	Tue Feb 18 14:56:10 2003
@@ -21,7 +21,7 @@
 struct statfs {
 	long		f_type;
 #define f_fstyp f_type
-	long		f_bsize;
+	long		f_bsize;	/* Filesystem blocksize */
 	long		f_frsize;	/* Fragment size - unsupported */
 	long		f_blocks;
 	long		f_bfree;
===== include/asm-parisc/stat.h 1.4 vs edited =====
--- 1.4/include/asm-parisc/stat.h	Fri Nov 29 13:54:59 2002
+++ edited/include/asm-parisc/stat.h	Tue Feb 18 14:53:52 2003
@@ -18,7 +18,7 @@
 	unsigned int	st_mtime_nsec;
 	time_t		st_ctime;
 	unsigned int	st_ctime_nsec;
-	int		st_blksize;
+	int		st_blksize;	/* Optimal I/O size */
 	int		st_blocks;
 	unsigned int	__unused1;	/* ACL stuff */
 	dev_t		__unused2;	/* network */
@@ -53,7 +53,7 @@
 	unsigned int	st_spare2;
 	time_t		st_ctime;
 	unsigned int	st_spare3;
-	int		st_blksize;
+	int		st_blksize;	/* Optimal I/O size */
 	__u64		st_blocks;
 	unsigned int	__unused1;	/* ACL stuff */
 	dev_t		__unused2;	/* network */
@@ -85,7 +85,7 @@
 	unsigned long long	st_rdev;
 	unsigned int		__pad2;
 	signed long long	st_size;
-	signed int		st_blksize;
+	signed int		st_blksize;	/* Optimal I/O size */
 
 	signed long long	st_blocks;
 	signed int		st_atime;
===== include/asm-parisc/statfs.h 1.1 vs edited =====
--- 1.1/include/asm-parisc/statfs.h	Tue Feb  5 20:39:57 2002
+++ edited/include/asm-parisc/statfs.h	Tue Feb 18 14:56:10 2003
@@ -11,7 +11,7 @@
 
 struct statfs {
 	long f_type;
-	long f_bsize;
+	long f_bsize;	/* Filesystem blocksize */
 	long f_blocks;
 	long f_bfree;
 	long f_bavail;
===== include/asm-ppc/stat.h 1.4 vs edited =====
--- 1.4/include/asm-ppc/stat.h	Sun Nov 17 22:53:57 2002
+++ edited/include/asm-ppc/stat.h	Tue Feb 18 14:53:52 2003
@@ -30,7 +30,7 @@
 	gid_t 		st_gid;
 	dev_t		st_rdev;
 	off_t		st_size;
-	unsigned long  	st_blksize;
+	unsigned long  	st_blksize;	/* Optimal I/O size */
 	unsigned long  	st_blocks;
 	unsigned long  	st_atime;
 	unsigned long  	st_atime_nsec;
===== include/asm-ppc/statfs.h 1.3 vs edited =====
--- 1.3/include/asm-ppc/statfs.h	Mon Sep 16 08:52:06 2002
+++ edited/include/asm-ppc/statfs.h	Tue Feb 18 14:56:10 2003
@@ -11,7 +11,7 @@
 
 struct statfs {
 	long f_type;
-	long f_bsize;
+	long f_bsize;	/* Filesystem blocksize */
 	long f_blocks;
 	long f_bfree;
 	long f_bavail;
===== include/asm-ppc64/stat.h 1.4 vs edited =====
--- 1.4/include/asm-ppc64/stat.h	Fri Nov 22 07:06:46 2002
+++ edited/include/asm-ppc64/stat.h	Tue Feb 18 14:53:52 2003
@@ -19,7 +19,7 @@
 	gid_t 		st_gid;
 	dev_t		st_rdev;
 	off_t		st_size;
-	unsigned long  	st_blksize;
+	unsigned long  	st_blksize;	/* Optimal I/O size */
 	unsigned long  	st_blocks;
 	unsigned long  	st_atime;
 	unsigned long	st_atime_nsec;
===== include/asm-ppc64/statfs.h 1.1 vs edited =====
--- 1.1/include/asm-ppc64/statfs.h	Thu Feb 14 15:14:36 2002
+++ edited/include/asm-ppc64/statfs.h	Tue Feb 18 14:56:10 2003
@@ -15,7 +15,7 @@
 
 struct statfs {
 	long f_type;
-	long f_bsize;
+	long f_bsize;	/* Filesystem blocksize */
 	long f_blocks;
 	long f_bfree;
 	long f_bavail;
===== include/asm-s390/stat.h 1.3 vs edited =====
--- 1.3/include/asm-s390/stat.h	Sun Nov 17 22:53:57 2002
+++ edited/include/asm-s390/stat.h	Tue Feb 18 14:53:52 2003
@@ -34,7 +34,7 @@
         unsigned short st_rdev;
         unsigned short __pad2;
         unsigned long  st_size;
-        unsigned long  st_blksize;
+        unsigned long  st_blksize;	/* Optimal I/O size */
         unsigned long  st_blocks;
         unsigned long  st_atime;
         unsigned long  st_atime_nsec;
@@ -65,7 +65,7 @@
         unsigned short  st_rdev;
         unsigned int    __pad3;
         long long       st_size;
-        unsigned long   st_blksize;
+        unsigned long   st_blksize;	/* Optimal I/O size */
         unsigned char   __pad4[4];
         unsigned long   __pad5;     /* future possible st_blocks high bits */
         unsigned long   st_blocks;  /* Number 512-byte blocks allocated. */
===== include/asm-s390/statfs.h 1.1 vs edited =====
--- 1.1/include/asm-s390/statfs.h	Tue Feb  5 20:39:56 2002
+++ edited/include/asm-s390/statfs.h	Tue Feb 18 14:56:10 2003
@@ -19,7 +19,7 @@
 
 struct statfs {
 	long f_type;
-	long f_bsize;
+	long f_bsize;	/* Filesystem blocksize */
 	long f_blocks;
 	long f_bfree;
 	long f_bavail;
===== include/asm-s390x/stat.h 1.2 vs edited =====
--- 1.2/include/asm-s390x/stat.h	Sun Nov 17 22:53:57 2002
+++ edited/include/asm-s390x/stat.h	Tue Feb 18 14:53:52 2003
@@ -25,7 +25,7 @@
 	unsigned long  st_mtime_nsec;
         unsigned long  st_ctime;
 	unsigned long  st_ctime_nsec;
-        unsigned long  st_blksize;
+        unsigned long  st_blksize;	/* Optimal I/O size */
         long           st_blocks;
         unsigned long  __unused[3];
 };
===== include/asm-s390x/statfs.h 1.1 vs edited =====
--- 1.1/include/asm-s390x/statfs.h	Tue Feb  5 20:59:11 2002
+++ edited/include/asm-s390x/statfs.h	Tue Feb 18 14:56:10 2003
@@ -19,7 +19,7 @@
 
 struct statfs {
 	int  f_type;
-	int  f_bsize;
+	int  f_bsize;	/* Filesystem blocksize */
 	long f_blocks;
 	long f_bfree;
 	long f_bavail;
===== include/asm-sh/stat.h 1.3 vs edited =====
--- 1.3/include/asm-sh/stat.h	Sun Nov 17 22:53:57 2002
+++ edited/include/asm-sh/stat.h	Tue Feb 18 14:53:52 2003
@@ -26,7 +26,7 @@
 	unsigned short st_rdev;
 	unsigned short __pad2;
 	unsigned long  st_size;
-	unsigned long  st_blksize;
+	unsigned long  st_blksize;	/* Optimal I/O size */
 	unsigned long  st_blocks;
 	unsigned long  st_atime;
 	unsigned long  st_atime_nsec;
@@ -72,7 +72,7 @@
 	unsigned char	__pad3[4];
 
 	long long	st_size;
-	unsigned long	st_blksize;
+	unsigned long	st_blksize;	/* Optimal I/O size */
 
 #if defined(__BIG_ENDIAN__)
 	unsigned long	__pad4;		/* Future possible st_blocks hi bits */
===== include/asm-sh/statfs.h 1.1 vs edited =====
--- 1.1/include/asm-sh/statfs.h	Tue Feb  5 20:39:53 2002
+++ edited/include/asm-sh/statfs.h	Tue Feb 18 14:56:10 2003
@@ -11,7 +11,7 @@
 
 struct statfs {
 	long f_type;
-	long f_bsize;
+	long f_bsize;	/* Filesystem blocksize */
 	long f_blocks;
 	long f_bfree;
 	long f_bavail;
===== include/asm-sparc/stat.h 1.2 vs edited =====
--- 1.2/include/asm-sparc/stat.h	Sun Nov 17 22:53:57 2002
+++ edited/include/asm-sparc/stat.h	Tue Feb 18 14:53:52 2003
@@ -33,7 +33,7 @@
 	unsigned long	st_mtime_nsec;
 	long		st_ctime;
 	unsigned long	st_ctime_nsec;
-	long		st_blksize;
+	long		st_blksize;	/* Optimal I/O size */
 	long		st_blocks;
 	unsigned long	__unused4[2];
 };
@@ -58,7 +58,7 @@
 	unsigned char	__pad3[8];
 
 	long long	st_size;
-	unsigned int	st_blksize;
+	unsigned int	st_blksize;	/* Optimal I/O size */
 
 	unsigned char	__pad4[8];
 	unsigned int	st_blocks;
===== include/asm-sparc/statfs.h 1.1 vs edited =====
--- 1.1/include/asm-sparc/statfs.h	Tue Feb  5 20:39:47 2002
+++ edited/include/asm-sparc/statfs.h	Tue Feb 18 14:56:10 2003
@@ -12,7 +12,7 @@
 
 struct statfs {
 	long f_type;
-	long f_bsize;
+	long f_bsize;	/* Filesystem blocksize */
 	long f_blocks;
 	long f_bfree;
 	long f_bavail;
===== include/asm-sparc64/stat.h 1.5 vs edited =====
--- 1.5/include/asm-sparc64/stat.h	Sat Dec 21 05:49:02 2002
+++ edited/include/asm-sparc64/stat.h	Tue Feb 18 14:53:52 2003
@@ -16,7 +16,7 @@
 	time_t  st_atime;
 	time_t  st_mtime;
 	time_t  st_ctime;
-	off_t   st_blksize;
+	off_t   st_blksize;	/* Optimal I/O size */
 	off_t   st_blocks;
 	unsigned long  __unused4[2];
 };
@@ -42,7 +42,7 @@
 	unsigned char	__pad3[8];
 
 	long long	st_size;
-	unsigned int	st_blksize;
+	unsigned int	st_blksize;	/* Optimal I/O size */
 
 	unsigned char	__pad4[8];
 	unsigned int	st_blocks;
===== include/asm-sparc64/statfs.h 1.3 vs edited =====
--- 1.3/include/asm-sparc64/statfs.h	Mon Jan 13 11:09:49 2003
+++ edited/include/asm-sparc64/statfs.h	Tue Feb 18 14:56:10 2003
@@ -12,7 +12,7 @@
 
 struct statfs {
 	long f_type;
-	long f_bsize;
+	long f_bsize;	/* Filesystem blocksize */
 	long f_blocks;
 	long f_bfree;
 	long f_bavail;
===== include/asm-v850/stat.h 1.3 vs edited =====
--- 1.3/include/asm-v850/stat.h	Thu Jan  9 08:07:36 2003
+++ edited/include/asm-v850/stat.h	Tue Feb 18 14:53:52 2003
@@ -25,7 +25,7 @@
 	__kernel_gid_t 	st_gid;
 	__kernel_dev_t	st_rdev;
 	__kernel_off_t	st_size;
-	unsigned long	st_blksize;
+	unsigned long	st_blksize;	/* Optimal I/O size */
 	unsigned long	st_blocks;
 	unsigned long	st_atime;
 	unsigned long	__unused1;
@@ -55,7 +55,7 @@
 	unsigned long	__unused3;
 
 	__kernel_loff_t	st_size;
-	unsigned long	st_blksize;
+	unsigned long	st_blksize;	/* Optimal I/O size */
 
 	unsigned long	st_blocks; /* No. of 512-byte blocks allocated */
 	unsigned long	__unused4; /* future possible st_blocks high bits */
===== include/asm-v850/statfs.h 1.1 vs edited =====
--- 1.1/include/asm-v850/statfs.h	Fri Nov  1 19:38:12 2002
+++ edited/include/asm-v850/statfs.h	Tue Feb 18 14:56:10 2003
@@ -11,7 +11,7 @@
 
 struct statfs {
 	long f_type;
-	long f_bsize;
+	long f_bsize;	/* Filesystem blocksize */
 	long f_blocks;
 	long f_bfree;
 	long f_bavail;
===== include/asm-x86_64/stat.h 1.2 vs edited =====
--- 1.2/include/asm-x86_64/stat.h	Sun Nov 17 22:53:57 2002
+++ edited/include/asm-x86_64/stat.h	Tue Feb 18 14:53:52 2003
@@ -14,7 +14,7 @@
 	unsigned int	__pad0;
 	unsigned long	st_rdev;
 	long		st_size;
-	long		st_blksize;
+	long		st_blksize;	/* Optimal I/O size */
 	long		st_blocks;	/* Number 512-byte blocks allocated. */
 
 	unsigned long	st_atime;
===== include/asm-x86_64/statfs.h 1.1 vs edited =====
--- 1.1/include/asm-x86_64/statfs.h	Mon Feb 11 14:28:32 2002
+++ edited/include/asm-x86_64/statfs.h	Tue Feb 18 14:56:10 2003
@@ -11,7 +11,7 @@
 
 struct statfs {
 	long f_type;
-	long f_bsize;
+	long f_bsize;	/* Filesystem blocksize */
 	long f_blocks;
 	long f_bfree;
 	long f_bavail;
===== include/linux/stat.h 1.3 vs edited =====
--- 1.3/include/linux/stat.h	Sun Nov 17 22:53:57 2002
+++ edited/include/linux/stat.h	Tue Feb 18 14:57:46 2003
@@ -68,7 +68,7 @@
 	struct timespec  atime;
 	struct timespec	mtime;
 	struct timespec	ctime;
-	unsigned long	blksize;
+	unsigned long	blksize;	/* Optimal I/O size */
 	unsigned long	blocks;
 };
 



--------------090209000104090500030900--

