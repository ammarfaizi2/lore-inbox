Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271933AbRHVF44>; Wed, 22 Aug 2001 01:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271935AbRHVF4r>; Wed, 22 Aug 2001 01:56:47 -0400
Received: from patan.Sun.COM ([192.18.98.43]:21137 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S271933AbRHVF4i>;
	Wed, 22 Aug 2001 01:56:38 -0400
Message-ID: <3B834ADD.3A466F48@sun.com>
Date: Wed, 22 Aug 2001 08:02:05 +0200
From: Harald von Fellenberg <harald.von-fellenberg@sun.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: de-CH, en
MIME-Version: 1.0
To: aia21@cus.cam.ac.uk
CC: linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: PROBLEM: NTFS  routine fs/ntfs/unistr.c does not compile
Content-Type: multipart/mixed;
 boundary="------------78A74AC94E90C5E9AAF4E4AB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------78A74AC94E90C5E9AAF4E4AB
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

[1.] NTFS  routine fs/ntfs/unistr.c does not compile
[2.] NTFS  routine fs/ntfs/unistr.c does not compile: the macro
min(a,b,c)
     is not defined. Comparison with Linux 2.4.7 revealed that
     1. the pertaining line in unistr.c has changed from 2.4.7 to 2.4.9
     2. the macro definition in file fs/ntfs/macros.h for macro min()
has
        been dropped
     The solution was straight forward: add the (three-parameter) macro
     definition from include/linux/kernel.h to fs/ntfs/macros.h
     The patch is added below
[3.] Keywords filesystem, NTFS
[4.] Kernel version 2.4.9
[5.] (none)
[6.] Compilation output for ``make bzImage=B4=B4

make[3]: Entering directory `/usr/src/linux-2.4.9/fs/ntfs'
(...)
gcc -D__KERNEL__ -I/usr/src/linux-2.4.9/include -Wall
-Wstrict-prototypes -Wno-t
rigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mprefe
rred-stack-boundary=3D2 -march=3Di686  -DNTFS_VERSION=3D\"1.1.16\"   -c -=
o
unistr.o un
istr.c
unistr.c: In function `ntfs_collate_names':
unistr.c:99: warning: implicit declaration of function `min'
unistr.c:99: parse error before `unsigned'
unistr.c:99: parse error before `)'
unistr.c:97: warning: `c1' might be used uninitialized in this function
unistr.c: At top level:
unistr.c:118: parse error before `if'
unistr.c:123: warning: type defaults to `int' in declaration of `c1'
unistr.c:123: `name1' undeclared here (not in a function)
unistr.c:123: warning: data definition has no type or storage class
unistr.c:124: parse error before `if'
make[3]: *** [unistr.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.9/fs/ntfs'

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux harald 2.4.9 #6 Tue Aug 21 17:14:32 CEST 2001 i686 unknown

Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.10.0.33
util-linux             2.10q
mount                  2.11g
modutils               2.4.1
e2fsprogs              1.19
pcmcia-cs              3.1.22
PPP                    2.4.0
isdn4k-utils           3.1pre1a
Linux C Library        x    1 root     root      1382179 Jan 19  2001
/lib/libc.so.6
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.57
Kbd                    1.02
Sh-utils               2.0
Modules Loaded

[X.] The patch is here:

--- linux-2.4.9/fs/ntfs/macros.h.orig   Wed Aug 15 10:22:17 2001
+++ linux-2.4.9/fs/ntfs/macros.h    Tue Aug 21 17:09:11 2001
@@ -11,6 +11,14 @@
 #define NTFS_INO2VOL(ino)  (&((ino)->i_sb->u.ntfs_sb))
 #define NTFS_LINO2NINO(ino)     (&((ino)->u.ntfs_i))

+/* Three parameter min and max macros taken from include/linux/kernel.h
*/
+#ifndef min
+#define min(type,x,y) \
+   ({ type __x =3D (x), __y =3D (y); __x < __y ? __x: __y; })
+#define max(type,x,y) \
+   ({ type __x =3D (x), __y =3D (y); __x > __y ? __x: __y; })
+#endif
+
 #define IS_MAGIC(a,b)      (*(int*)(a) =3D=3D *(int*)(b))
 #define IS_MFT_RECORD(a)   IS_MAGIC((a),"FILE")
 #define IS_INDEX_RECORD(a) IS_MAGIC((a),"INDX")



Please redspond directly, I am not on the aiases
Thanks,

Harald
-- =

**********************************************************
 Dr. Harald von Fellenberg  =

 Senior Consultant          Technology Strategy Office
 Tel:    ++41 1 908 9230    Sun Microsystems (Schweiz) AG
 Fax:    ++41 1 908 9001    Javastr. 2 =

 Mobile: ++41 79 349 0393   CH-8604 Volketswil
 mailto:harald.von-fellenberg@sun.com
**********************************************************
--------------78A74AC94E90C5E9AAF4E4AB
Content-Type: text/x-vcard; charset=us-ascii;
 name="harald.von-fellenberg.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Harald von Fellenberg
Content-Disposition: attachment;
 filename="harald.von-fellenberg.vcf"

begin:vcard 
n:von Fellenberg;Harald
x-mozilla-html:FALSE
adr:;;;;;;
version:2.1
email;internet:hvf@swissonline.ch
title:Senior Consultant
x-mozilla-cpt:;13344
fn:Dr. Harald von Fellenberg
end:vcard

--------------78A74AC94E90C5E9AAF4E4AB--

