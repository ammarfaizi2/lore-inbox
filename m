Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSIHTYA>; Sun, 8 Sep 2002 15:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSIHTX5>; Sun, 8 Sep 2002 15:23:57 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:33881 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S313898AbSIHTXf>;
	Sun, 8 Sep 2002 15:23:35 -0400
From: Daniel Mehrmann <daniel.mehrmann@gmx.de>
Organization: private
To: alan@lxorguk.ukuu.org.uk
Subject: [PATCH 2.4/2.5] Athlon CFLAGS
Date: Sun, 8 Sep 2002 21:28:11 +0200
User-Agent: KMail/1.4.6
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LT6e9MGV9b8od47"
Message-Id: <200209082128.11316.daniel.mehrmann@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_LT6e9MGV9b8od47
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Alan,

i add for the AMD Athlon family some optimize compilerflags.=20
Gcc 3.1 and 3.2 support more specific Athlon instructions as 3.0 or 2.95x.=
=20
This patch for 2.4.19, 2.4.20-pre5 and 2.5.33 set a new "-march" flag:

Athlon TB/Duron 		+=3D -march=3Dathlon-tbird
Athlon XP/Athlon4/Duron	+=3D -march=3Dathlon-xp
Athlon MP				+=3D -march=3Dathlon-mp

It tests the possible flags and if it`s fail we made a downgrade to "-march=
=3Dathlon" or "-march=3Di686".=20
So we can use gcc 2.95x and 3.0 without any problems :-)

I add this in the configmenu and documentation.

i made serval tests with my compilers and it looks like good. LMBENCH 2.0 s=
aid it`s a little bit faster as before :-))

I think it allso a good step for the furture of the kernel, because we can =
now specific more cpu feature in config.in and support=20
all gcc features.=20

I hope this patch is nice for you.

chears,
Daniel

2.4.19:

diff -Pur linux-2.4.19.orig/Documentation/Configure.help linux-2.4.19/Docum=
entation/Configure.help
=2D-- linux-2.4.19.orig/Documentation/Configure.help      2002-08-03 02:39:=
42.000000000 +0200
+++ linux-2.4.19/Documentation/Configure.help   2002-09-08 19:31:31.0000000=
00 +0200
@@ -3963,7 +3963,11 @@
      and Celerons based on the Coppermine core.
    - "Pentium-4" for the Intel Pentium 4.
    - "K6" for the AMD K6, K6-II and K6-III (aka K6-3D).
=2D   - "Athlon" for the AMD K7 family (Athlon/Duron/Thunderbird).
+   - "Atlon-TB" for the AMD Athlon Thunderbird
+     and Durons based on the Splitfire core.
+   - "Athlon-XP" for the AMD AthlonXP
+     and Mobile and Durons based on Morgan core.
+   - "Athlon-MP" for the AMD AthlonMP
    - "Elan" for the AMD Elan family (Elan SC400/SC410).
    - "Crusoe" for the Transmeta Crusoe series.
    - "Winchip-C6" for original IDT Winchip.
diff -Pur linux-2.4.19.orig/arch/i386/Makefile linux-2.4.19/arch/i386/Makef=
ile
=2D-- linux-2.4.19.orig/arch/i386/Makefile        2001-04-12 21:20:31.00000=
0000 +0200
+++ linux-2.4.19/arch/i386/Makefile     2002-09-08 18:58:38.000000000 +0200
@@ -62,10 +62,17 @@
 CFLAGS +=3D $(shell if $(CC) -march=3Dk6 -S -o /dev/null -xc /dev/null >/d=
ev/null 2>&1; then echo "-march=3Dk6"; else echo "-march=3Di586"; fi)
 endif

=2Difdef CONFIG_MK7
=2DCFLAGS +=3D $(shell if $(CC) -march=3Dathlon -S -o /dev/null -xc /dev/nu=
ll >/dev/null 2>&1; then echo "-march=3Dathlon"; else echo "-march=3Di686 -=
malign-functions=3D4"; fi)
+ifdef CONFIG_MATHLONTB
+CFLAGS +=3D $(shell if $(CC) -march=3Dathlon-tbird -S -o /dev/null -xc /de=
v/null >/dev/null 2>&1; then echo "-march=3Dathlon-tbird"; elif $(CC) -marc=
h=3Dathlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=
=3Dathlon"; else echo "-march=3Di686 -malign-functions=3D4"; fi)
 endif

+ifdef CONFIG_MATHLONXP
+CFLAGS +=3D $(shell if $(CC) -march=3Dathlon-xp -S -o /dev/null -xc /dev/n=
ull >/dev/null 2>&1; then echo "-march=3Dathlon-xp"; elif $(CC) -march=3Dat=
hlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=3Dath=
lon"; else echo "-march=3Di686 -malign-functions=3D4"; fi)
+endif
+
+ifdef CONFIG_MATHLONMP
+CFLAGS +=3D $(shell if $(CC) -march=3Dathlon-mp -S -o /dev/null -xc /dev/n=
ull >/dev/null 2>&1; then echo "-march=3Dathlon-mp"; elif $(CC) -march=3Dat=
hlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=3Dath=
lon"; else echo "-march=3Di686 -malign-functions=3D4"; fi)
+endif
 ifdef CONFIG_MCRUSOE
 CFLAGS +=3D -march=3Di686 -malign-functions=3D0 -malign-jumps=3D0 -malign-=
loops=3D0
 endif
diff -Pur linux-2.4.19.orig/arch/i386/config.in linux-2.4.19/arch/i386/conf=
ig.in
=2D-- linux-2.4.19.orig/arch/i386/config.in       2002-08-03 02:39:42.00000=
0000 +0200
+++ linux-2.4.19/arch/i386/config.in    2002-09-08 19:16:05.000000000 +0200
@@ -36,7 +36,9 @@
         Pentium-III/Celeron(Coppermine)        CONFIG_MPENTIUMIII \
         Pentium-4                              CONFIG_MPENTIUM4 \
         K6/K6-II/K6-III                        CONFIG_MK6 \
=2D        Athlon/Duron/K7                        CONFIG_MK7 \
+        Athlon-TB/Duron(Splitfire)             CONFIG_MATHLONTB \
+        Athlon-XP/Athlon4/Duron(Morgan)        CONFIG_MATHLONXP \
+        Athlon-MP                              CONFIG_MATHLONMP \
         Elan                                   CONFIG_MELAN \
         Crusoe                                 CONFIG_MCRUSOE \
         Winchip-C6                             CONFIG_MWINCHIPC6 \
@@ -119,7 +121,23 @@
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
=2Dif [ "$CONFIG_MK7" =3D "y" ]; then
+if [ "$CONFIG_MATHLONTB" =3D "y" ]; then
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 6
+   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_GOOD_APIC y
+   define_bool CONFIG_X86_USE_3DNOW y
+   define_bool CONFIG_X86_PGE y
+   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+fi
+if [ "$CONFIG_MATHLONXP" =3D "y" ]; then
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 6
+   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_GOOD_APIC y
+   define_bool CONFIG_X86_USE_3DNOW y
+   define_bool CONFIG_X86_PGE y
+   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+fi
+if [ "$CONFIG_MATHLONMP" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 6
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y

2.4.20-pre5:

diff -Pur linux-2.4.20-pre5.orig/Documentation/Configure.help linux-2.4.20-=
pre5/Documentation/Configure.help
=2D-- linux-2.4.20-pre5.orig/Documentation/Configure.help 2002-09-08 19:42:=
28.000000000 +0200
+++ linux-2.4.20-pre5/Documentation/Configure.help      2002-09-08 19:55:07=
=2E000000000 +0200
@@ -4106,7 +4106,11 @@
      and Celerons based on the Coppermine core.
    - "Pentium-4" for the Intel Pentium 4.
    - "K6" for the AMD K6, K6-II and K6-III (aka K6-3D).
=2D   - "Athlon" for the AMD K7 family (Athlon/Duron/Thunderbird).
+   - "Atlon-TB" for the AMD Athlon Thunderbird
+     and Durons based on the Splitfire core.
+   - "Athlon-XP" for the AMD AthlonXP
+     and Mobile and Durons based on Morgan core.
+   - "Athlon-MP" for the AMD AthlonMP
    - "Elan" for the AMD Elan family (Elan SC400/SC410).
    - "Crusoe" for the Transmeta Crusoe series.
    - "Winchip-C6" for original IDT Winchip.
diff -Pur linux-2.4.20-pre5.orig/arch/i386/Makefile linux-2.4.20-pre5/arch/=
i386/Makefile
=2D-- linux-2.4.20-pre5.orig/arch/i386/Makefile   2001-04-12 21:20:31.00000=
0000 +0200
+++ linux-2.4.20-pre5/arch/i386/Makefile        2002-09-08 20:10:33.0000000=
00 +0200
@@ -62,8 +62,16 @@
 CFLAGS +=3D $(shell if $(CC) -march=3Dk6 -S -o /dev/null -xc /dev/null >/d=
ev/null 2>&1; then echo "-march=3Dk6"; else echo "-march=3Di586"; fi)
 endif

=2Difdef CONFIG_MK7
=2DCFLAGS +=3D $(shell if $(CC) -march=3Dathlon -S -o /dev/null -xc /dev/nu=
ll >/dev/null 2>&1; then echo "-march=3Dathlon"; else echo "-march=3Di686 -=
malign-functions=3D4"; fi)
+ifdef CONFIG_MATHLONTB
+CFLAGS +=3D $(shell if $(CC) -march=3Dathlon-tbird -S -o /dev/null -xc /de=
v/null >/dev/null 2>&1; then echo "-march=3Dathlon-tbird"; elif $(CC) -marc=
h=3Dathlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=
=3Dathlon"; else echo "-march=3Di686 -malign-functions=3D4"; fi)
+endif
+
+ifdef CONFIG_MATHLONXP
+CFLAGS +=3D $(shell if $(CC) -march=3Dathlon-xp -S -o /dev/null -xc /dev/n=
ull >/dev/null 2>&1; then echo "-march=3Dathlon-xp"; elif $(CC) -march=3Dat=
hlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=3Dath=
lon"; else echo "-march=3Di686 -malign-functions=3D4"; fi)
+endif
+
+ifdef CONFIG_MATHLONMP
+CFLAGS +=3D $(shell if $(CC) -march=3Dathlon-mp -S -o /dev/null -xc /dev/n=
ull >/dev/null 2>&1; then echo "-march=3Dathlon-mp"; elif $(CC) -march=3Dat=
hlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=3Dath=
lon"; else echo "-march=3Di686 -malign-functions=3D4"; fi)
 endif

 ifdef CONFIG_MCRUSOE
diff -Pur linux-2.4.20-pre5.orig/arch/i386/config.in linux-2.4.20-pre5/arch=
/i386/config.in
=2D-- linux-2.4.20-pre5.orig/arch/i386/config.in  2002-09-08 19:42:29.00000=
0000 +0200
+++ linux-2.4.20-pre5/arch/i386/config.in       2002-09-08 20:14:56.0000000=
00 +0200
@@ -35,7 +35,9 @@
         Pentium-III/Celeron(Coppermine)        CONFIG_MPENTIUMIII \
         Pentium-4                              CONFIG_MPENTIUM4 \
         K6/K6-II/K6-III                        CONFIG_MK6 \
=2D        Athlon/Duron/K7                        CONFIG_MK7 \
+        Athlon-TB/Duron(Splitfire)             CONFIG_MATHLONTB \
+        Athlon-XP/Athlon4/Duron(Morgan)        CONFIG_MATHLONXP \
+        Athlon-MP                              CONFIG_MATHLONMP \
         Elan                                   CONFIG_MELAN \
         Crusoe                                 CONFIG_MCRUSOE \
         Winchip-C6                             CONFIG_MWINCHIPC6 \
@@ -126,7 +128,7 @@
    define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
=2Dif [ "$CONFIG_MK7" =3D "y" ]; then
+if [ "$CONFIG_MATHLONTB" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 6
    define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
@@ -135,6 +137,23 @@
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_F00F_WORKS_OK y
 fi
+if [ "$CONFIG_MATHLONXP" =3D "y" ]; then
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 6
+   define_bool CONFIG_X86_HAS_TSC y
+   define_bool CONFIG_X86_GOOD_APIC y
+   define_bool CONFIG_X86_USE_3DNOW y
+   define_bool CONFIG_X86_PGE y
+   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_F00F_WORKS_OK y
+fi
+if [ "$CONFIG_MATHLONMP" =3D "y" ]; then
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 6
+   define_bool CONFIG_X86_HAS_TSC y
+   define_bool CONFIG_X86_USE_3DNOW y
+   define_bool CONFIG_X86_PGE y
+   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_F00F_WORKS_OK y
+fi
 if [ "$CONFIG_MELAN" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
    define_bool CONFIG_X86_USE_STRING_486 y

2.5.33:
diff -Pur linux-2.5.33.orig/arch/i386/Config.help linux-2.5.33/arch/i386/Co=
nfig.help
=2D-- linux-2.5.33.orig/arch/i386/Config.help     2002-09-01 00:04:49.00000=
0000 +0200
+++ linux-2.5.33/arch/i386/Config.help  2002-09-08 20:43:40.000000000 +0200
@@ -411,7 +411,11 @@
      and Celerons based on the Coppermine core.
    - "Pentium-4" for the Intel Pentium 4.
    - "K6" for the AMD K6, K6-II and K6-III (aka K6-3D).
=2D   - "Athlon" for the AMD K7 family (Athlon/Duron/Thunderbird).
+   - "Atlon-TB" for the AMD Athlon Thunderbird
+     and Durons based on the Splitfire core.
+   - "Athlon-XP" for the AMD AthlonXP
+     and Mobile and Durons based on Morgan core.
+   - "Athlon-MP" for the AMD AthlonMP
    - "Crusoe" for the Transmeta Crusoe series.
    - "Winchip-C6" for original IDT Winchip.
    - "Winchip-2" for IDT Winchip 2.
diff -Pur linux-2.5.33.orig/arch/i386/Makefile linux-2.5.33/arch/i386/Makef=
ile
=2D-- linux-2.5.33.orig/arch/i386/Makefile        2002-09-01 00:04:55.00000=
0000 +0200
+++ linux-2.5.33/arch/i386/Makefile     2002-09-08 20:27:06.000000000 +0200
@@ -61,10 +61,18 @@
 CFLAGS +=3D $(shell if $(CC) -march=3Dk6 -S -o /dev/null -xc /dev/null >/d=
ev/null 2>&1; then echo "-march=3Dk6"; else echo "-march=3Di586"; fi)
 endif

=2Difdef CONFIG_MK7
=2DCFLAGS +=3D $(shell if $(CC) -march=3Dathlon -S -o /dev/null -xc /dev/nu=
ll >/dev/null 2>&1; then echo "-march=3Dathlon"; else echo "-march=3Di686 -=
malign-functions=3D4"; fi)
+ifdef CONFIG_MATHLONTB
+CFLAGS +=3D $(shell if $(CC) -march=3Dathlon-tbird -S -o /dev/null -xc /de=
v/null >/dev/null 2>&1; then echo "-march=3Dathlon-tbird"; elif $(CC) -marc=
h=3Dathlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=
=3Dathlon"; else echo "-march=3Di686 -malign-functions=3D4"; fi)
 endif

+ifdef CONFIG_MATHLONXP
+CFLAGS +=3D $(shell if $(CC) -march=3Dathlon-xp -S -o /dev/null -xc /dev/n=
ull >/dev/null 2>&1; then echo "-march=3Dathlon-xp"; elif $(CC) -march=3Dat=
hlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=3Dath=
lon"; else echo "-march=3Di686 -malign-functions=3D4"; fi)
+endif
+
+ifdef CONFIG_MATHLONMP
+CFLAGS +=3D $(shell if $(CC) -march=3Dathlon-mp -S -o /dev/null -xc /dev/n=
ull >/dev/null 2>&1; then echo "-march=3Dathlon-mp"; elif $(CC) -march=3Dat=
hlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=3Dath=
lon"; else echo "-march=3Di686 -malign-functions=3D4"; fi)
+endif
+
 ifdef CONFIG_MCRUSOE
 CFLAGS +=3D -march=3Di686 -malign-functions=3D0 -malign-jumps=3D0 -malign-=
loops=3D0
 endif
diff -Pur linux-2.5.33.orig/arch/i386/config.in linux-2.5.33/arch/i386/conf=
ig.in
=2D-- linux-2.5.33.orig/arch/i386/config.in       2002-09-01 00:04:55.00000=
0000 +0200
+++ linux-2.5.33/arch/i386/config.in    2002-09-08 20:31:22.000000000 +0200
@@ -25,7 +25,9 @@
         Pentium-III/Celeron(Coppermine)        CONFIG_MPENTIUMIII \
         Pentium-4                              CONFIG_MPENTIUM4 \
         K6/K6-II/K6-III                        CONFIG_MK6 \
=2D        Athlon/Duron/K7                        CONFIG_MK7 \
+        Athlon-TB/Duron(Splitfire)             CONFIG_MATHLONTB \
+        Athlon-XP/Athlon4/Duron(Morgan)        CONFIG_MATHLONXP \
+        Athlon-MP                              CONFIG_MATHLONMP \
         Elan                                   CONFIG_MELAN \
         Crusoe                                 CONFIG_MCRUSOE \
         Winchip-C6                             CONFIG_MWINCHIPC6 \
@@ -110,7 +112,21 @@
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
=2Dif [ "$CONFIG_MK7" =3D "y" ]; then
+if [ "$CONFIG_MATHLONTB" =3D "y" ]; then
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 6
+   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_GOOD_APIC y
+   define_bool CONFIG_X86_USE_3DNOW y
+   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+fi
+if [ "$CONFIG_MATHLONXP" =3D "y" ]; then
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 6
+   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_GOOD_APIC y
+   define_bool CONFIG_X86_USE_3DNOW y
+   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+fi
+if [ "$CONFIG_MATHLONMP" =3D "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 6
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y


--Boundary-00=_LT6e9MGV9b8od47
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-2.4.19-Athlon-CFLAG"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-2.4.19-Athlon-CFLAG"

diff -Pur linux-2.4.19.orig/Documentation/Configure.help linux-2.4.19/Documentation/Configure.help
--- linux-2.4.19.orig/Documentation/Configure.help	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4.19/Documentation/Configure.help	2002-09-08 19:31:31.000000000 +0200
@@ -3963,7 +3963,11 @@
      and Celerons based on the Coppermine core.
    - "Pentium-4" for the Intel Pentium 4.
    - "K6" for the AMD K6, K6-II and K6-III (aka K6-3D).
-   - "Athlon" for the AMD K7 family (Athlon/Duron/Thunderbird).
+   - "Atlon-TB" for the AMD Athlon Thunderbird
+     and Durons based on the Splitfire core.
+   - "Athlon-XP" for the AMD AthlonXP
+     and Mobile and Durons based on Morgan core.
+   - "Athlon-MP" for the AMD AthlonMP 
    - "Elan" for the AMD Elan family (Elan SC400/SC410).
    - "Crusoe" for the Transmeta Crusoe series.
    - "Winchip-C6" for original IDT Winchip.
diff -Pur linux-2.4.19.orig/arch/i386/Makefile linux-2.4.19/arch/i386/Makefile
--- linux-2.4.19.orig/arch/i386/Makefile	2001-04-12 21:20:31.000000000 +0200
+++ linux-2.4.19/arch/i386/Makefile	2002-09-08 18:58:38.000000000 +0200
@@ -62,10 +62,17 @@
 CFLAGS += $(shell if $(CC) -march=k6 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=k6"; else echo "-march=i586"; fi)
 endif
 
-ifdef CONFIG_MK7
-CFLAGS += $(shell if $(CC) -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon"; else echo "-march=i686 -malign-functions=4"; fi) 
+ifdef CONFIG_MATHLONTB
+CFLAGS += $(shell if $(CC) -march=athlon-tbird -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon-tbird"; elif $(CC) -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon"; else echo "-march=i686 -malign-functions=4"; fi)
 endif
 
+ifdef CONFIG_MATHLONXP
+CFLAGS += $(shell if $(CC) -march=athlon-xp -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon-xp"; elif $(CC) -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon"; else echo "-march=i686 -malign-functions=4"; fi)  
+endif
+
+ifdef CONFIG_MATHLONMP
+CFLAGS += $(shell if $(CC) -march=athlon-mp -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon-mp"; elif $(CC) -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon"; else echo "-march=i686 -malign-functions=4"; fi)
+endif
 ifdef CONFIG_MCRUSOE
 CFLAGS += -march=i686 -malign-functions=0 -malign-jumps=0 -malign-loops=0
 endif
diff -Pur linux-2.4.19.orig/arch/i386/config.in linux-2.4.19/arch/i386/config.in
--- linux-2.4.19.orig/arch/i386/config.in	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4.19/arch/i386/config.in	2002-09-08 19:16:05.000000000 +0200
@@ -36,7 +36,9 @@
 	 Pentium-III/Celeron(Coppermine)	CONFIG_MPENTIUMIII \
 	 Pentium-4				CONFIG_MPENTIUM4 \
 	 K6/K6-II/K6-III			CONFIG_MK6 \
-	 Athlon/Duron/K7			CONFIG_MK7 \
+	 Athlon-TB/Duron(Splitfire)             CONFIG_MATHLONTB \
+	 Athlon-XP/Athlon4/Duron(Morgan)        CONFIG_MATHLONXP \
+	 Athlon-MP                              CONFIG_MATHLONMP \
 	 Elan					CONFIG_MELAN \
 	 Crusoe					CONFIG_MCRUSOE \
 	 Winchip-C6				CONFIG_MWINCHIPC6 \
@@ -119,7 +121,23 @@
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
-if [ "$CONFIG_MK7" = "y" ]; then
+if [ "$CONFIG_MATHLONTB" = "y" ]; then
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 6
+   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_GOOD_APIC y
+   define_bool CONFIG_X86_USE_3DNOW y
+   define_bool CONFIG_X86_PGE y
+   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+fi
+if [ "$CONFIG_MATHLONXP" = "y" ]; then
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 6
+   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_GOOD_APIC y
+   define_bool CONFIG_X86_USE_3DNOW y
+   define_bool CONFIG_X86_PGE y
+   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+fi
+if [ "$CONFIG_MATHLONMP" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 6
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y

--Boundary-00=_LT6e9MGV9b8od47
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-2.4.20-pre5-Athlon-CFLAG"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-2.4.20-pre5-Athlon-CFLAG"

diff -Pur linux-2.4.20-pre5.orig/Documentation/Configure.help linux-2.4.20-pre5/Documentation/Configure.help
--- linux-2.4.20-pre5.orig/Documentation/Configure.help	2002-09-08 19:42:28.000000000 +0200
+++ linux-2.4.20-pre5/Documentation/Configure.help	2002-09-08 19:55:07.000000000 +0200
@@ -4106,7 +4106,11 @@
      and Celerons based on the Coppermine core.
    - "Pentium-4" for the Intel Pentium 4.
    - "K6" for the AMD K6, K6-II and K6-III (aka K6-3D).
-   - "Athlon" for the AMD K7 family (Athlon/Duron/Thunderbird).
+   - "Atlon-TB" for the AMD Athlon Thunderbird
+     and Durons based on the Splitfire core.
+   - "Athlon-XP" for the AMD AthlonXP
+     and Mobile and Durons based on Morgan core.
+   - "Athlon-MP" for the AMD AthlonMP 
    - "Elan" for the AMD Elan family (Elan SC400/SC410).
    - "Crusoe" for the Transmeta Crusoe series.
    - "Winchip-C6" for original IDT Winchip.
diff -Pur linux-2.4.20-pre5.orig/arch/i386/Makefile linux-2.4.20-pre5/arch/i386/Makefile
--- linux-2.4.20-pre5.orig/arch/i386/Makefile	2001-04-12 21:20:31.000000000 +0200
+++ linux-2.4.20-pre5/arch/i386/Makefile	2002-09-08 20:10:33.000000000 +0200
@@ -62,8 +62,16 @@
 CFLAGS += $(shell if $(CC) -march=k6 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=k6"; else echo "-march=i586"; fi)
 endif
 
-ifdef CONFIG_MK7
-CFLAGS += $(shell if $(CC) -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon"; else echo "-march=i686 -malign-functions=4"; fi) 
+ifdef CONFIG_MATHLONTB
+CFLAGS += $(shell if $(CC) -march=athlon-tbird -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon-tbird"; elif $(CC) -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon"; else echo "-march=i686 -malign-functions=4"; fi)
+endif
+
+ifdef CONFIG_MATHLONXP
+CFLAGS += $(shell if $(CC) -march=athlon-xp -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon-xp"; elif $(CC) -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon"; else echo "-march=i686 -malign-functions=4"; fi)
+endif
+
+ifdef CONFIG_MATHLONMP
+CFLAGS += $(shell if $(CC) -march=athlon-mp -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon-mp"; elif $(CC) -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon"; else echo "-march=i686 -malign-functions=4"; fi)
 endif
 
 ifdef CONFIG_MCRUSOE
diff -Pur linux-2.4.20-pre5.orig/arch/i386/config.in linux-2.4.20-pre5/arch/i386/config.in
--- linux-2.4.20-pre5.orig/arch/i386/config.in	2002-09-08 19:42:29.000000000 +0200
+++ linux-2.4.20-pre5/arch/i386/config.in	2002-09-08 20:14:56.000000000 +0200
@@ -35,7 +35,9 @@
 	 Pentium-III/Celeron(Coppermine)	CONFIG_MPENTIUMIII \
 	 Pentium-4				CONFIG_MPENTIUM4 \
 	 K6/K6-II/K6-III			CONFIG_MK6 \
-	 Athlon/Duron/K7			CONFIG_MK7 \
+	 Athlon-TB/Duron(Splitfire)             CONFIG_MATHLONTB \
+	 Athlon-XP/Athlon4/Duron(Morgan)        CONFIG_MATHLONXP \
+	 Athlon-MP                              CONFIG_MATHLONMP \
 	 Elan					CONFIG_MELAN \
 	 Crusoe					CONFIG_MCRUSOE \
 	 Winchip-C6				CONFIG_MWINCHIPC6 \
@@ -126,7 +128,7 @@
    define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
-if [ "$CONFIG_MK7" = "y" ]; then
+if [ "$CONFIG_MATHLONTB" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 6
    define_bool CONFIG_X86_HAS_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
@@ -135,6 +137,23 @@
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_F00F_WORKS_OK y
 fi
+if [ "$CONFIG_MATHLONXP" = "y" ]; then
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 6
+   define_bool CONFIG_X86_HAS_TSC y
+   define_bool CONFIG_X86_GOOD_APIC y
+   define_bool CONFIG_X86_USE_3DNOW y
+   define_bool CONFIG_X86_PGE y
+   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_F00F_WORKS_OK y
+fi
+if [ "$CONFIG_MATHLONMP" = "y" ]; then
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 6
+   define_bool CONFIG_X86_HAS_TSC y
+   define_bool CONFIG_X86_USE_3DNOW y
+   define_bool CONFIG_X86_PGE y
+   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_F00F_WORKS_OK y
+fi 
 if [ "$CONFIG_MELAN" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
    define_bool CONFIG_X86_USE_STRING_486 y

--Boundary-00=_LT6e9MGV9b8od47
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-2.5.33-Athlon-CFLAG"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-2.5.33-Athlon-CFLAG"

diff -Pur linux-2.5.33.orig/arch/i386/Config.help linux-2.5.33/arch/i386/Config.help
--- linux-2.5.33.orig/arch/i386/Config.help	2002-09-01 00:04:49.000000000 +0200
+++ linux-2.5.33/arch/i386/Config.help	2002-09-08 20:43:40.000000000 +0200
@@ -411,7 +411,11 @@
      and Celerons based on the Coppermine core.
    - "Pentium-4" for the Intel Pentium 4.
    - "K6" for the AMD K6, K6-II and K6-III (aka K6-3D).
-   - "Athlon" for the AMD K7 family (Athlon/Duron/Thunderbird).
+   - "Atlon-TB" for the AMD Athlon Thunderbird
+     and Durons based on the Splitfire core.
+   - "Athlon-XP" for the AMD AthlonXP
+     and Mobile and Durons based on Morgan core.
+   - "Athlon-MP" for the AMD AthlonMP 
    - "Crusoe" for the Transmeta Crusoe series.
    - "Winchip-C6" for original IDT Winchip.
    - "Winchip-2" for IDT Winchip 2.
diff -Pur linux-2.5.33.orig/arch/i386/Makefile linux-2.5.33/arch/i386/Makefile
--- linux-2.5.33.orig/arch/i386/Makefile	2002-09-01 00:04:55.000000000 +0200
+++ linux-2.5.33/arch/i386/Makefile	2002-09-08 20:27:06.000000000 +0200
@@ -61,10 +61,18 @@
 CFLAGS += $(shell if $(CC) -march=k6 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=k6"; else echo "-march=i586"; fi)
 endif
 
-ifdef CONFIG_MK7
-CFLAGS += $(shell if $(CC) -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon"; else echo "-march=i686 -malign-functions=4"; fi) 
+ifdef CONFIG_MATHLONTB
+CFLAGS += $(shell if $(CC) -march=athlon-tbird -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon-tbird"; elif $(CC) -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon"; else echo "-march=i686 -malign-functions=4"; fi)
 endif
 
+ifdef CONFIG_MATHLONXP
+CFLAGS += $(shell if $(CC) -march=athlon-xp -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon-xp"; elif $(CC) -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon"; else echo "-march=i686 -malign-functions=4"; fi)
+endif
+
+ifdef CONFIG_MATHLONMP
+CFLAGS += $(shell if $(CC) -march=athlon-mp -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon-mp"; elif $(CC) -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon"; else echo "-march=i686 -malign-functions=4"; fi)
+endif
+ 
 ifdef CONFIG_MCRUSOE
 CFLAGS += -march=i686 -malign-functions=0 -malign-jumps=0 -malign-loops=0
 endif
diff -Pur linux-2.5.33.orig/arch/i386/config.in linux-2.5.33/arch/i386/config.in
--- linux-2.5.33.orig/arch/i386/config.in	2002-09-01 00:04:55.000000000 +0200
+++ linux-2.5.33/arch/i386/config.in	2002-09-08 20:31:22.000000000 +0200
@@ -25,7 +25,9 @@
 	 Pentium-III/Celeron(Coppermine)	CONFIG_MPENTIUMIII \
 	 Pentium-4				CONFIG_MPENTIUM4 \
 	 K6/K6-II/K6-III			CONFIG_MK6 \
-	 Athlon/Duron/K7			CONFIG_MK7 \
+	 Athlon-TB/Duron(Splitfire)             CONFIG_MATHLONTB \
+	 Athlon-XP/Athlon4/Duron(Morgan)        CONFIG_MATHLONXP \
+	 Athlon-MP                              CONFIG_MATHLONMP \
 	 Elan					CONFIG_MELAN \
 	 Crusoe					CONFIG_MCRUSOE \
 	 Winchip-C6				CONFIG_MWINCHIPC6 \
@@ -110,7 +112,21 @@
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
-if [ "$CONFIG_MK7" = "y" ]; then
+if [ "$CONFIG_MATHLONTB" = "y" ]; then
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 6
+   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_GOOD_APIC y
+   define_bool CONFIG_X86_USE_3DNOW y
+   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+fi
+if [ "$CONFIG_MATHLONXP" = "y" ]; then
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 6
+   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_GOOD_APIC y
+   define_bool CONFIG_X86_USE_3DNOW y
+   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+fi
+if [ "$CONFIG_MATHLONMP" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 6
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y

--Boundary-00=_LT6e9MGV9b8od47--

