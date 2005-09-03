Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161198AbVICIne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161198AbVICIne (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 04:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161199AbVICIne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 04:43:34 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:50304 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1161198AbVICInd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 04:43:33 -0400
Date: Sat, 3 Sep 2005 11:27:08 +0200
From: Harald Welte <laforge@gnumonks.org>
To: linux-usb-devel@lists.sourceforge.net,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH] usbdevice_fs header breakage
Message-ID: <20050903092708.GH4415@rama.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jITzwD3HDGXid3BE"
Content-Disposition: inline
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jITzwD3HDGXid3BE
Content-Type: multipart/mixed; boundary="zOcTNEe3AzgCmdo9"
Content-Disposition: inline


--zOcTNEe3AzgCmdo9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On my x86_64 box, If I don't apply the following patch, I fail to
compile any userspace application that includes usbdevice_fs.h (see
attached compiler errors from trying to compile openct).

linux/compat.h includes asm/compat.h
asm-x86_64/compat.h includes linux/sched.h
linux/sched.h includes linux/timex.h
and linux/timex.h re-defines glibc types such as "struct timeval"

I'm not sure whether this fix is the correct way/place to fix the issue.
Actually, it seems wrong to me, since  usbdevice_fs.h doesn't include
config.h but uses CONFIG_COMPAT.  So somebody who understands the code,
please clean this up.


[USBDEVFS] fix inclusion of <linux/compat.h> to avoud header mess

Without moving the include of compat.h down, userspace programs that use
usbdevice_fs.h end up including half the kernel includes (and eventually
fail to compile).

Signed-off-by: Harald Welte <laforge@netfilter.org>

---
commit 6066d9bc752ad495d7a8966a9629a26d949588ed
tree 054e3fbee4c56a1e8d6a365f0722d7db7e01e2e2
parent a2c9c9a399f2069f31d608d142da8d5d82609b0d
author Harald Welte <laforge@netfilter.org> Sa, 03 Sep 2005 11:08:53 +0200
committer Harald Welte <laforge@netfilter.org> Sa, 03 Sep 2005 11:08:53 +02=
00

 include/linux/usbdevice_fs.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/usbdevice_fs.h b/include/linux/usbdevice_fs.h
--- a/include/linux/usbdevice_fs.h
+++ b/include/linux/usbdevice_fs.h
@@ -32,7 +32,6 @@
 #define _LINUX_USBDEVICE_FS_H
=20
 #include <linux/types.h>
-#include <linux/compat.h>
=20
 /* --------------------------------------------------------------------- */
=20
@@ -125,6 +124,7 @@ struct usbdevfs_hub_portinfo {
 };
=20
 #ifdef CONFIG_COMPAT
+#include <linux/compat.h>
 struct usbdevfs_urb32 {
 	unsigned char type;
 	unsigned char endpoint;
--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--zOcTNEe3AzgCmdo9
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=f
Content-Transfer-Encoding: quoted-printable

In file included from /usr/include/linux/timex.h:58,
                 from /usr/include/linux/sched.h:11,
                 from /usr/include/asm/compat.h:8,
                 from /usr/include/linux/compat.h:15,
                 from /usr/include/linux/usbdevice_fs.h:35,
                 from sys-linux.c:15:
/usr/include/linux/time.h:12: error: redefinition of =E2=80=98struct timesp=
ec=E2=80=99
/usr/include/linux/time.h:18: error: redefinition of =E2=80=98struct timeva=
l=E2=80=99
/usr/include/linux/time.h:23: error: redefinition of =E2=80=98struct timezo=
ne=E2=80=99
/usr/include/linux/time.h:147: error: redefinition of =E2=80=98struct itime=
rval=E2=80=99
In file included from /usr/include/linux/spinlock.h:16,
                 from /usr/include/linux/seqlock.h:30,
                 from /usr/include/asm/vsyscall.h:4,
                 from /usr/include/asm/timex.h:12,
                 from /usr/include/linux/timex.h:61,
                 from /usr/include/linux/sched.h:11,
                 from /usr/include/asm/compat.h:8,
                 from /usr/include/linux/compat.h:15,
                 from /usr/include/linux/usbdevice_fs.h:35,
                 from sys-linux.c:15:
/usr/include/asm/processor.h:185: error: syntax error before =E2=80=98u16=
=E2=80=99
/usr/include/asm/processor.h:187: error: syntax error before =E2=80=98twd=
=E2=80=99
/usr/include/asm/processor.h:188: error: syntax error before =E2=80=98fop=
=E2=80=99
/usr/include/asm/processor.h:189: error: syntax error before =E2=80=98rip=
=E2=80=99
/usr/include/asm/processor.h:190: error: syntax error before =E2=80=98rdp=
=E2=80=99
/usr/include/asm/processor.h:191: error: syntax error before =E2=80=98mxcsr=
=E2=80=99
/usr/include/asm/processor.h:192: error: syntax error before =E2=80=98mxcsr=
_mask=E2=80=99
/usr/include/asm/processor.h:193: error: syntax error before =E2=80=98st_sp=
ace=E2=80=99
/usr/include/asm/processor.h:194: error: syntax error before =E2=80=98xmm_s=
pace=E2=80=99
/usr/include/asm/processor.h:195: error: syntax error before =E2=80=98paddi=
ng=E2=80=99
/usr/include/asm/processor.h:196: error: syntax error before =E2=80=98}=E2=
=80=99 token
/usr/include/asm/processor.h:199: error: field =E2=80=98fxsave=E2=80=99 has=
 incomplete type
/usr/include/asm/processor.h:203: error: syntax error before =E2=80=98u32=
=E2=80=99
/usr/include/asm/processor.h:205: error: syntax error before =E2=80=98rsp1=
=E2=80=99
/usr/include/asm/processor.h:206: error: syntax error before =E2=80=98rsp2=
=E2=80=99
/usr/include/asm/processor.h:207: error: syntax error before =E2=80=98reser=
ved2=E2=80=99
/usr/include/asm/processor.h:208: error: syntax error before =E2=80=98ist=
=E2=80=99
/usr/include/asm/processor.h:209: error: syntax error before =E2=80=98reser=
ved3=E2=80=99
/usr/include/asm/processor.h:210: error: syntax error before =E2=80=98reser=
ved4=E2=80=99
/usr/include/asm/processor.h:211: error: syntax error before =E2=80=98reser=
ved5=E2=80=99
/usr/include/asm/processor.h:212: error: syntax error before =E2=80=98io_bi=
tmap_base=E2=80=99
/usr/include/asm/processor.h:223: error: syntax error before =E2=80=98}=E2=
=80=99 token
/usr/include/asm/processor.h:254: error: syntax error before =E2=80=98u64=
=E2=80=99
/usr/include/asm/processor.h: In function =E2=80=98prefetchw=E2=80=99:
/usr/include/asm/processor.h:404: error: called object =E2=80=98"r"=E2=80=
=99 is not a function
In file included from /usr/include/asm/div64.h:1,
                 from /usr/include/linux/jiffies.h:9,
                 from /usr/include/linux/sched.h:12,
                 from /usr/include/asm/compat.h:8,
                 from /usr/include/linux/compat.h:15,
                 from /usr/include/linux/usbdevice_fs.h:35,
                 from sys-linux.c:15:
/usr/include/asm-generic/div64.h:54:3: error: #error do_div() does not yet =
support the C64
In file included from /usr/include/linux/sched.h:12,
                 from /usr/include/asm/compat.h:8,
                 from /usr/include/linux/compat.h:15,
                 from /usr/include/linux/usbdevice_fs.h:35,
                 from sys-linux.c:15:
/usr/include/linux/jiffies.h: At top level:
/usr/include/linux/jiffies.h:84: error: syntax error before =E2=80=98jiffie=
s_64=E2=80=99
/usr/include/linux/jiffies.h:88: error: syntax error before =E2=80=98get_ji=
ffies_64=E2=80=99
/usr/include/linux/jiffies.h: In function =E2=80=98timespec_to_jiffies=E2=
=80=99:
/usr/include/linux/jiffies.h:320: error: called object =E2=80=98u64=E2=80=
=99 is not a function
/usr/include/linux/jiffies.h:320: error: called object =E2=80=98u64=E2=80=
=99 is not a function
/usr/include/linux/jiffies.h:320: error: =E2=80=98NSEC_PER_SEC=E2=80=99 und=
eclared (first use in this function)
/usr/include/linux/jiffies.h:320: error: (Each undeclared identifier is rep=
orted only once
/usr/include/linux/jiffies.h:320: error: for each function it appears in.)
/usr/include/linux/jiffies.h:321: error: called object =E2=80=98u64=E2=80=
=99 is not a function
/usr/include/linux/jiffies.h:321: error: called object =E2=80=98u64=E2=80=
=99 is not a function
/usr/include/linux/jiffies.h:324: error: syntax error before =E2=80=98sec=
=E2=80=99
/usr/include/linux/jiffies.h:324: error: syntax error before =E2=80=98NSEC_=
PER_SEC=E2=80=99
/usr/include/linux/jiffies.h:324: error: called object =E2=80=98u64=E2=80=
=99 is not a function
/usr/include/linux/jiffies.h:324: error: syntax error before =E2=80=98)=E2=
=80=99 token
/usr/include/linux/jiffies.h: In function =E2=80=98jiffies_to_timespec=E2=
=80=99:
/usr/include/linux/jiffies.h:337: error: syntax error before =E2=80=98nsec=
=E2=80=99
/usr/include/linux/jiffies.h:338: error: syntax error before =E2=80=98resul=
t=E2=80=99
/usr/include/linux/jiffies.h:338: error: =E2=80=98result=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/jiffies.h:338: error: =E2=80=98NSEC_PER_SEC=E2=80=99 und=
eclared (first use in this function)
/usr/include/linux/jiffies.h: In function =E2=80=98timeval_to_jiffies=E2=80=
=99:
/usr/include/linux/jiffies.h:359: error: called object =E2=80=98u64=E2=80=
=99 is not a function
/usr/include/linux/jiffies.h:359: error: called object =E2=80=98u64=E2=80=
=99 is not a function
/usr/include/linux/jiffies.h:359: error: =E2=80=98NSEC_PER_SEC=E2=80=99 und=
eclared (first use in this function)
/usr/include/linux/jiffies.h:360: error: called object =E2=80=98u64=E2=80=
=99 is not a function
/usr/include/linux/jiffies.h:360: error: called object =E2=80=98u64=E2=80=
=99 is not a function
/usr/include/linux/jiffies.h:363: error: syntax error before =E2=80=98sec=
=E2=80=99
/usr/include/linux/jiffies.h:363: error: syntax error before =E2=80=98NSEC_=
PER_SEC=E2=80=99
/usr/include/linux/jiffies.h:363: error: called object =E2=80=98u64=E2=80=
=99 is not a function
/usr/include/linux/jiffies.h:363: error: syntax error before =E2=80=98)=E2=
=80=99 token
/usr/include/linux/jiffies.h: In function =E2=80=98jiffies_to_timeval=E2=80=
=99:
/usr/include/linux/jiffies.h:375: error: syntax error before =E2=80=98nsec=
=E2=80=99
/usr/include/linux/jiffies.h:376: error: syntax error before =E2=80=98resul=
t=E2=80=99
/usr/include/linux/jiffies.h:376: error: =E2=80=98result=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/jiffies.h:376: error: =E2=80=98NSEC_PER_SEC=E2=80=99 und=
eclared (first use in this function)
/usr/include/linux/jiffies.h:377: error: =E2=80=98NSEC_PER_USEC=E2=80=99 un=
declared (first use in this function)
/usr/include/linux/jiffies.h: At top level:
/usr/include/linux/jiffies.h:383: error: syntax error before =E2=80=98jiffi=
es_to_clock_t=E2=80=99
In file included from /usr/include/linux/sched.h:12,
                 from /usr/include/asm/compat.h:8,
                 from /usr/include/linux/compat.h:15,
                 from /usr/include/linux/usbdevice_fs.h:35,
                 from sys-linux.c:15:
/usr/include/linux/jiffies.h:385:41: error: division by zero in #if
/usr/include/linux/jiffies.h:385:42: error: division by zero in #if
/usr/include/linux/jiffies.h: In function =E2=80=98jiffies_to_clock_t=E2=80=
=99:
/usr/include/linux/jiffies.h:388: error: syntax error before =E2=80=98tmp=
=E2=80=99
/usr/include/linux/jiffies.h:389: error: =E2=80=98tmp=E2=80=99 undeclared (=
first use in this function)
/usr/include/linux/jiffies.h:389: error: =E2=80=98NSEC_PER_SEC=E2=80=99 und=
eclared (first use in this function)
/usr/include/linux/jiffies.h:389: error: =E2=80=98USER_HZ=E2=80=99 undeclar=
ed (first use in this function)
/usr/include/linux/jiffies.h:396:18: error: division by zero in #if
/usr/include/linux/jiffies.h: In function =E2=80=98clock_t_to_jiffies=E2=80=
=99:
/usr/include/linux/jiffies.h:401: error: syntax error before =E2=80=98jif=
=E2=80=99
/usr/include/linux/jiffies.h:404: error: =E2=80=98USER_HZ=E2=80=99 undeclar=
ed (first use in this function)
/usr/include/linux/jiffies.h:408: error: =E2=80=98jif=E2=80=99 undeclared (=
first use in this function)
/usr/include/linux/jiffies.h:408: error: syntax error before numeric consta=
nt
/usr/include/linux/jiffies.h: At top level:
/usr/include/linux/jiffies.h:414: error: syntax error before =E2=80=98jiffi=
es_64_to_clock_t=E2=80=99
/usr/include/linux/jiffies.h:414: error: syntax error before =E2=80=98x=E2=
=80=99
/usr/include/linux/jiffies.h:416:41: error: division by zero in #if
/usr/include/linux/jiffies.h:416:42: error: division by zero in #if
/usr/include/linux/jiffies.h: In function =E2=80=98jiffies_64_to_clock_t=E2=
=80=99:
/usr/include/linux/jiffies.h:424: error: =E2=80=98x=E2=80=99 undeclared (fi=
rst use in this function)
/usr/include/linux/jiffies.h:425: error: =E2=80=98NSEC_PER_SEC=E2=80=99 und=
eclared (first use in this function)
/usr/include/linux/jiffies.h:425: error: =E2=80=98USER_HZ=E2=80=99 undeclar=
ed (first use in this function)
/usr/include/linux/jiffies.h: At top level:
/usr/include/linux/jiffies.h:430: error: syntax error before =E2=80=98nsec_=
to_clock_t=E2=80=99
/usr/include/linux/jiffies.h:430: error: syntax error before =E2=80=98x=E2=
=80=99
/usr/include/linux/jiffies.h:432:28: error: division by zero in #if
/usr/include/linux/jiffies.h: In function =E2=80=98nsec_to_clock_t=E2=80=99:
/usr/include/linux/jiffies.h:433: error: =E2=80=98x=E2=80=99 undeclared (fi=
rst use in this function)
/usr/include/linux/jiffies.h:433: error: =E2=80=98NSEC_PER_SEC=E2=80=99 und=
eclared (first use in this function)
/usr/include/linux/jiffies.h:433: error: =E2=80=98USER_HZ=E2=80=99 undeclar=
ed (first use in this function)
In file included from /usr/include/linux/cpumask.h:82,
                 from /usr/include/linux/sched.h:15,
                 from /usr/include/asm/compat.h:8,
                 from /usr/include/linux/compat.h:15,
                 from /usr/include/linux/usbdevice_fs.h:35,
                 from sys-linux.c:15:
/usr/include/linux/bitmap.h: In function =E2=80=98bitmap_zero=E2=80=99:
/usr/include/linux/bitmap.h:119: error: =E2=80=98BITS_PER_LONG=E2=80=99 und=
eclared (first use in this function)
/usr/include/linux/bitmap.h: In function =E2=80=98bitmap_fill=E2=80=99:
/usr/include/linux/bitmap.h:134: error: =E2=80=98BITS_PER_LONG=E2=80=99 und=
eclared (first use in this function)
/usr/include/linux/bitmap.h: In function =E2=80=98bitmap_copy=E2=80=99:
/usr/include/linux/bitmap.h:140: error: =E2=80=98BITS_PER_LONG=E2=80=99 und=
eclared (first use in this function)
/usr/include/linux/bitmap.h: In function =E2=80=98bitmap_and=E2=80=99:
/usr/include/linux/bitmap.h:151: error: =E2=80=98BITS_PER_LONG=E2=80=99 und=
eclared (first use in this function)
/usr/include/linux/bitmap.h: In function =E2=80=98bitmap_or=E2=80=99:
/usr/include/linux/bitmap.h:160: error: =E2=80=98BITS_PER_LONG=E2=80=99 und=
eclared (first use in this function)
/usr/include/linux/bitmap.h: In function =E2=80=98bitmap_xor=E2=80=99:
/usr/include/linux/bitmap.h:169: error: =E2=80=98BITS_PER_LONG=E2=80=99 und=
eclared (first use in this function)
/usr/include/linux/bitmap.h: In function =E2=80=98bitmap_andnot=E2=80=99:
/usr/include/linux/bitmap.h:178: error: =E2=80=98BITS_PER_LONG=E2=80=99 und=
eclared (first use in this function)
/usr/include/linux/bitmap.h: In function =E2=80=98bitmap_complement=E2=80=
=99:
/usr/include/linux/bitmap.h:187: error: =E2=80=98BITS_PER_LONG=E2=80=99 und=
eclared (first use in this function)
/usr/include/linux/bitmap.h: In function =E2=80=98bitmap_equal=E2=80=99:
/usr/include/linux/bitmap.h:196: error: =E2=80=98BITS_PER_LONG=E2=80=99 und=
eclared (first use in this function)
/usr/include/linux/bitmap.h: In function =E2=80=98bitmap_intersects=E2=80=
=99:
/usr/include/linux/bitmap.h:205: error: =E2=80=98BITS_PER_LONG=E2=80=99 und=
eclared (first use in this function)
/usr/include/linux/bitmap.h: In function =E2=80=98bitmap_subset=E2=80=99:
/usr/include/linux/bitmap.h:214: error: =E2=80=98BITS_PER_LONG=E2=80=99 und=
eclared (first use in this function)
/usr/include/linux/bitmap.h: In function =E2=80=98bitmap_empty=E2=80=99:
/usr/include/linux/bitmap.h:222: error: =E2=80=98BITS_PER_LONG=E2=80=99 und=
eclared (first use in this function)
/usr/include/linux/bitmap.h: In function =E2=80=98bitmap_full=E2=80=99:
/usr/include/linux/bitmap.h:230: error: =E2=80=98BITS_PER_LONG=E2=80=99 und=
eclared (first use in this function)
/usr/include/linux/bitmap.h: In function =E2=80=98bitmap_shift_right=E2=80=
=99:
/usr/include/linux/bitmap.h:244: error: =E2=80=98BITS_PER_LONG=E2=80=99 und=
eclared (first use in this function)
/usr/include/linux/bitmap.h: In function =E2=80=98bitmap_shift_left=E2=80=
=99:
/usr/include/linux/bitmap.h:253: error: =E2=80=98BITS_PER_LONG=E2=80=99 und=
eclared (first use in this function)
In file included from /usr/include/linux/sched.h:15,
                 from /usr/include/asm/compat.h:8,
                 from /usr/include/linux/compat.h:15,
                 from /usr/include/linux/usbdevice_fs.h:35,
                 from sys-linux.c:15:
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:85: error: syntax error before =E2=80=98DECLAR=
E_BITMAP=E2=80=99
/usr/include/linux/cpumask.h:86: error: syntax error before =E2=80=98_unuse=
d_cpumask_arg_=E2=80=99
/usr/include/linux/cpumask.h:89: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/cpumask.h: In function =E2=80=98__cpu_set=E2=80=99:
/usr/include/linux/cpumask.h:91: error: =E2=80=98cpu=E2=80=99 undeclared (f=
irst use in this function)
/usr/include/linux/cpumask.h:91: error: =E2=80=98dstp=E2=80=99 undeclared (=
first use in this function)
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:95: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/cpumask.h: In function =E2=80=98__cpu_clear=E2=80=99:
/usr/include/linux/cpumask.h:97: error: =E2=80=98cpu=E2=80=99 undeclared (f=
irst use in this function)
/usr/include/linux/cpumask.h:97: error: =E2=80=98dstp=E2=80=99 undeclared (=
first use in this function)
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:101: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/cpumask.h: In function =E2=80=98__cpus_setall=E2=80=99:
/usr/include/linux/cpumask.h:103: error: =E2=80=98dstp=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/cpumask.h:103: error: =E2=80=98nbits=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:107: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/cpumask.h: In function =E2=80=98__cpus_clear=E2=80=99:
/usr/include/linux/cpumask.h:109: error: =E2=80=98dstp=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/cpumask.h:109: error: =E2=80=98nbits=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:116: error: syntax error before =E2=80=98cpuma=
sk_t=E2=80=99
/usr/include/linux/cpumask.h: In function =E2=80=98__cpu_test_and_set=E2=80=
=99:
/usr/include/linux/cpumask.h:118: error: =E2=80=98cpu=E2=80=99 undeclared (=
first use in this function)
/usr/include/linux/cpumask.h:118: error: =E2=80=98addr=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:122: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/cpumask.h: In function =E2=80=98__cpus_and=E2=80=99:
/usr/include/linux/cpumask.h:125: error: =E2=80=98dstp=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/cpumask.h:125: error: =E2=80=98src1p=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h:125: error: =E2=80=98src2p=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h:125: error: =E2=80=98nbits=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:129: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/cpumask.h: In function =E2=80=98__cpus_or=E2=80=99:
/usr/include/linux/cpumask.h:132: error: =E2=80=98dstp=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/cpumask.h:132: error: =E2=80=98src1p=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h:132: error: =E2=80=98src2p=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h:132: error: =E2=80=98nbits=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:136: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/cpumask.h: In function =E2=80=98__cpus_xor=E2=80=99:
/usr/include/linux/cpumask.h:139: error: =E2=80=98dstp=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/cpumask.h:139: error: =E2=80=98src1p=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h:139: error: =E2=80=98src2p=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h:139: error: =E2=80=98nbits=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:144: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/cpumask.h: In function =E2=80=98__cpus_andnot=E2=80=99:
/usr/include/linux/cpumask.h:147: error: =E2=80=98dstp=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/cpumask.h:147: error: =E2=80=98src1p=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h:147: error: =E2=80=98src2p=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h:147: error: =E2=80=98nbits=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:151: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/cpumask.h: In function =E2=80=98__cpus_complement=E2=80=
=99:
/usr/include/linux/cpumask.h:154: error: =E2=80=98dstp=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/cpumask.h:154: error: =E2=80=98srcp=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/cpumask.h:154: error: =E2=80=98nbits=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:158: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/cpumask.h: In function =E2=80=98__cpus_equal=E2=80=99:
/usr/include/linux/cpumask.h:161: error: =E2=80=98src1p=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h:161: error: =E2=80=98src2p=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h:161: error: =E2=80=98nbits=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:165: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/cpumask.h: In function =E2=80=98__cpus_intersects=E2=80=
=99:
/usr/include/linux/cpumask.h:168: error: =E2=80=98src1p=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h:168: error: =E2=80=98src2p=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h:168: error: =E2=80=98nbits=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:172: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/cpumask.h: In function =E2=80=98__cpus_subset=E2=80=99:
/usr/include/linux/cpumask.h:175: error: =E2=80=98src1p=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h:175: error: =E2=80=98src2p=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h:175: error: =E2=80=98nbits=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:179: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/cpumask.h: In function =E2=80=98__cpus_empty=E2=80=99:
/usr/include/linux/cpumask.h:181: error: =E2=80=98srcp=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/cpumask.h:181: error: =E2=80=98nbits=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:185: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/cpumask.h: In function =E2=80=98__cpus_full=E2=80=99:
/usr/include/linux/cpumask.h:187: error: =E2=80=98srcp=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/cpumask.h:187: error: =E2=80=98nbits=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:191: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/cpumask.h: In function =E2=80=98__cpus_weight=E2=80=99:
/usr/include/linux/cpumask.h:193: error: =E2=80=98srcp=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/cpumask.h:193: error: =E2=80=98nbits=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:198: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/cpumask.h: In function =E2=80=98__cpus_shift_right=E2=80=
=99:
/usr/include/linux/cpumask.h:201: error: =E2=80=98dstp=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/cpumask.h:201: error: =E2=80=98srcp=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/cpumask.h:201: error: =E2=80=98n=E2=80=99 undeclared (fi=
rst use in this function)
/usr/include/linux/cpumask.h:201: error: =E2=80=98nbits=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:206: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/cpumask.h: In function =E2=80=98__cpus_shift_left=E2=80=
=99:
/usr/include/linux/cpumask.h:209: error: =E2=80=98dstp=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/cpumask.h:209: error: =E2=80=98srcp=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/cpumask.h:209: error: =E2=80=98n=E2=80=99 undeclared (fi=
rst use in this function)
/usr/include/linux/cpumask.h:209: error: =E2=80=98nbits=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:213: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/cpumask.h: In function =E2=80=98__first_cpu=E2=80=99:
/usr/include/linux/cpumask.h:215: error: syntax error before =E2=80=98int=
=E2=80=99
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:219: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/cpumask.h: In function =E2=80=98__next_cpu=E2=80=99:
/usr/include/linux/cpumask.h:221: error: syntax error before =E2=80=98int=
=E2=80=99
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:270: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/cpumask.h: In function =E2=80=98__cpumask_scnprintf=E2=
=80=99:
/usr/include/linux/cpumask.h:272: error: =E2=80=98buf=E2=80=99 undeclared (=
first use in this function)
/usr/include/linux/cpumask.h:272: error: =E2=80=98len=E2=80=99 undeclared (=
first use in this function)
/usr/include/linux/cpumask.h:272: error: =E2=80=98srcp=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/cpumask.h:272: error: =E2=80=98nbits=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:278: error: syntax error before =E2=80=98cpuma=
sk_t=E2=80=99
/usr/include/linux/cpumask.h: In function =E2=80=98__cpumask_parse=E2=80=99:
/usr/include/linux/cpumask.h:280: error: =E2=80=98buf=E2=80=99 undeclared (=
first use in this function)
/usr/include/linux/cpumask.h:280: error: =E2=80=98len=E2=80=99 undeclared (=
first use in this function)
/usr/include/linux/cpumask.h:280: error: =E2=80=98dstp=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/cpumask.h:280: error: =E2=80=98nbits=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:286: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/cpumask.h: In function =E2=80=98__cpulist_scnprintf=E2=
=80=99:
/usr/include/linux/cpumask.h:288: error: =E2=80=98buf=E2=80=99 undeclared (=
first use in this function)
/usr/include/linux/cpumask.h:288: error: =E2=80=98len=E2=80=99 undeclared (=
first use in this function)
/usr/include/linux/cpumask.h:288: error: =E2=80=98srcp=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/cpumask.h:288: error: =E2=80=98nbits=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:292: error: syntax error before =E2=80=98cpuma=
sk_t=E2=80=99
/usr/include/linux/cpumask.h: In function =E2=80=98__cpulist_parse=E2=80=99:
/usr/include/linux/cpumask.h:294: error: =E2=80=98buf=E2=80=99 undeclared (=
first use in this function)
/usr/include/linux/cpumask.h:294: error: =E2=80=98dstp=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/cpumask.h:294: error: =E2=80=98nbits=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/cpumask.h: At top level:
/usr/include/linux/cpumask.h:362: error: syntax error before =E2=80=98cpu_p=
ossible_map=E2=80=99
/usr/include/linux/cpumask.h:363: error: syntax error before =E2=80=98cpu_o=
nline_map=E2=80=99
/usr/include/linux/cpumask.h:364: error: syntax error before =E2=80=98cpu_p=
resent_map=E2=80=99
In file included from /usr/include/linux/sched.h:17,
                 from /usr/include/asm/compat.h:8,
                 from /usr/include/linux/compat.h:15,
                 from /usr/include/linux/usbdevice_fs.h:35,
                 from sys-linux.c:15:
/usr/include/linux/nodemask.h:85: error: syntax error before =E2=80=98DECLA=
RE_BITMAP=E2=80=99
/usr/include/linux/nodemask.h:86: error: syntax error before =E2=80=98_unus=
ed_nodemask_arg_=E2=80=99
/usr/include/linux/nodemask.h:89: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/nodemask.h: In function =E2=80=98__node_set=E2=80=99:
/usr/include/linux/nodemask.h:91: error: =E2=80=98node=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/nodemask.h:91: error: =E2=80=98dstp=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:95: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/nodemask.h: In function =E2=80=98__node_clear=E2=80=99:
/usr/include/linux/nodemask.h:97: error: =E2=80=98node=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/nodemask.h:97: error: =E2=80=98dstp=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:101: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/nodemask.h: In function =E2=80=98__nodes_setall=E2=80=99:
/usr/include/linux/nodemask.h:103: error: =E2=80=98dstp=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/nodemask.h:103: error: =E2=80=98nbits=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:107: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/nodemask.h: In function =E2=80=98__nodes_clear=E2=80=99:
/usr/include/linux/nodemask.h:109: error: =E2=80=98dstp=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/nodemask.h:109: error: =E2=80=98nbits=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:117: error: syntax error before =E2=80=98node=
mask_t=E2=80=99
/usr/include/linux/nodemask.h: In function =E2=80=98__node_test_and_set=E2=
=80=99:
/usr/include/linux/nodemask.h:119: error: =E2=80=98node=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/nodemask.h:119: error: =E2=80=98addr=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:124: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/nodemask.h: In function =E2=80=98__nodes_and=E2=80=99:
/usr/include/linux/nodemask.h:127: error: =E2=80=98dstp=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/nodemask.h:127: error: =E2=80=98src1p=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h:127: error: =E2=80=98src2p=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h:127: error: =E2=80=98nbits=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:132: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/nodemask.h: In function =E2=80=98__nodes_or=E2=80=99:
/usr/include/linux/nodemask.h:135: error: =E2=80=98dstp=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/nodemask.h:135: error: =E2=80=98src1p=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h:135: error: =E2=80=98src2p=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h:135: error: =E2=80=98nbits=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:140: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/nodemask.h: In function =E2=80=98__nodes_xor=E2=80=99:
/usr/include/linux/nodemask.h:143: error: =E2=80=98dstp=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/nodemask.h:143: error: =E2=80=98src1p=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h:143: error: =E2=80=98src2p=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h:143: error: =E2=80=98nbits=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:148: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/nodemask.h: In function =E2=80=98__nodes_andnot=E2=80=99:
/usr/include/linux/nodemask.h:151: error: =E2=80=98dstp=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/nodemask.h:151: error: =E2=80=98src1p=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h:151: error: =E2=80=98src2p=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h:151: error: =E2=80=98nbits=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:156: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/nodemask.h: In function =E2=80=98__nodes_complement=E2=
=80=99:
/usr/include/linux/nodemask.h:159: error: =E2=80=98dstp=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/nodemask.h:159: error: =E2=80=98srcp=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/nodemask.h:159: error: =E2=80=98nbits=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:164: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/nodemask.h: In function =E2=80=98__nodes_equal=E2=80=99:
/usr/include/linux/nodemask.h:167: error: =E2=80=98src1p=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h:167: error: =E2=80=98src2p=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h:167: error: =E2=80=98nbits=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:172: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/nodemask.h: In function =E2=80=98__nodes_intersects=E2=
=80=99:
/usr/include/linux/nodemask.h:175: error: =E2=80=98src1p=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h:175: error: =E2=80=98src2p=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h:175: error: =E2=80=98nbits=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:180: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/nodemask.h: In function =E2=80=98__nodes_subset=E2=80=99:
/usr/include/linux/nodemask.h:183: error: =E2=80=98src1p=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h:183: error: =E2=80=98src2p=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h:183: error: =E2=80=98nbits=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:187: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/nodemask.h: In function =E2=80=98__nodes_empty=E2=80=99:
/usr/include/linux/nodemask.h:189: error: =E2=80=98srcp=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/nodemask.h:189: error: =E2=80=98nbits=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:193: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/nodemask.h: In function =E2=80=98__nodes_full=E2=80=99:
/usr/include/linux/nodemask.h:195: error: =E2=80=98srcp=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/nodemask.h:195: error: =E2=80=98nbits=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:199: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/nodemask.h: In function =E2=80=98__nodes_weight=E2=80=99:
/usr/include/linux/nodemask.h:201: error: =E2=80=98srcp=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/nodemask.h:201: error: =E2=80=98nbits=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:206: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/nodemask.h: In function =E2=80=98__nodes_shift_right=E2=
=80=99:
/usr/include/linux/nodemask.h:209: error: =E2=80=98dstp=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/nodemask.h:209: error: =E2=80=98srcp=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/nodemask.h:209: error: =E2=80=98n=E2=80=99 undeclared (f=
irst use in this function)
/usr/include/linux/nodemask.h:209: error: =E2=80=98nbits=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:214: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/nodemask.h: In function =E2=80=98__nodes_shift_left=E2=
=80=99:
/usr/include/linux/nodemask.h:217: error: =E2=80=98dstp=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/nodemask.h:217: error: =E2=80=98srcp=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/nodemask.h:217: error: =E2=80=98n=E2=80=99 undeclared (f=
irst use in this function)
/usr/include/linux/nodemask.h:217: error: =E2=80=98nbits=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:224: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/nodemask.h: In function =E2=80=98__first_node=E2=80=99:
/usr/include/linux/nodemask.h:226: error: syntax error before =E2=80=98int=
=E2=80=99
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:230: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/nodemask.h: In function =E2=80=98__next_node=E2=80=99:
/usr/include/linux/nodemask.h:232: error: syntax error before =E2=80=98int=
=E2=80=99
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:248: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/nodemask.h: In function =E2=80=98__first_unset_node=E2=
=80=99:
/usr/include/linux/nodemask.h:250: error: syntax error before =E2=80=98int=
=E2=80=99
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:283: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/nodemask.h: In function =E2=80=98__nodemask_scnprintf=E2=
=80=99:
/usr/include/linux/nodemask.h:285: error: =E2=80=98buf=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/nodemask.h:285: error: =E2=80=98len=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/nodemask.h:285: error: =E2=80=98srcp=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/nodemask.h:285: error: =E2=80=98nbits=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:291: error: syntax error before =E2=80=98node=
mask_t=E2=80=99
/usr/include/linux/nodemask.h: In function =E2=80=98__nodemask_parse=E2=80=
=99:
/usr/include/linux/nodemask.h:293: error: =E2=80=98buf=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/nodemask.h:293: error: =E2=80=98len=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/nodemask.h:293: error: =E2=80=98dstp=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/nodemask.h:293: error: =E2=80=98nbits=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:299: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/nodemask.h: In function =E2=80=98__nodelist_scnprintf=E2=
=80=99:
/usr/include/linux/nodemask.h:301: error: =E2=80=98buf=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/nodemask.h:301: error: =E2=80=98len=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/nodemask.h:301: error: =E2=80=98srcp=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/nodemask.h:301: error: =E2=80=98nbits=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:305: error: syntax error before =E2=80=98node=
mask_t=E2=80=99
/usr/include/linux/nodemask.h: In function =E2=80=98__nodelist_parse=E2=80=
=99:
/usr/include/linux/nodemask.h:307: error: =E2=80=98buf=E2=80=99 undeclared =
(first use in this function)
/usr/include/linux/nodemask.h:307: error: =E2=80=98dstp=E2=80=99 undeclared=
 (first use in this function)
/usr/include/linux/nodemask.h:307: error: =E2=80=98nbits=E2=80=99 undeclare=
d (first use in this function)
/usr/include/linux/nodemask.h: At top level:
/usr/include/linux/nodemask.h:326: error: syntax error before =E2=80=98node=
_online_map=E2=80=99
/usr/include/linux/nodemask.h:327: error: syntax error before =E2=80=98node=
_possible_map=E2=80=99
In file included from /usr/include/linux/sched.h:23,
                 from /usr/include/asm/compat.h:8,
                 from /usr/include/linux/compat.h:15,
                 from /usr/include/linux/usbdevice_fs.h:35,
                 from sys-linux.c:15:
/usr/include/asm/mmu.h:17: error: field =E2=80=98sem=E2=80=99 has incomplet=
e type
In file included from /usr/include/asm/cputime.h:4,
                 from /usr/include/linux/sched.h:24,
                 from /usr/include/asm/compat.h:8,
                 from /usr/include/linux/compat.h:15,
                 from /usr/include/linux/usbdevice_fs.h:35,
                 from sys-linux.c:15:
/usr/include/asm-generic/cputime.h:23: error: syntax error before =E2=80=98=
cputime64_t=E2=80=99
In file included from /usr/include/linux/signal.h:4,
                 from /usr/include/linux/sched.h:28,
                 from /usr/include/asm/compat.h:8,
                 from /usr/include/linux/compat.h:15,
                 from /usr/include/linux/usbdevice_fs.h:35,
                 from sys-linux.c:15:
/usr/include/linux/list.h:770:2: warning: #warning "don't include kernel he=
aders in userspace"
In file included from /usr/include/linux/signal.h:6,
                 from /usr/include/linux/sched.h:28,
                 from /usr/include/asm/compat.h:8,
                 from /usr/include/linux/compat.h:15,
                 from /usr/include/linux/usbdevice_fs.h:35,
                 from sys-linux.c:15:
/usr/include/asm/signal.h:35: error: conflicting types for =E2=80=98sigset_=
t=E2=80=99
/usr/include/sys/select.h:38: error: previous declaration of =E2=80=98sigse=
t_t=E2=80=99 was here
In file included from /usr/include/asm/siginfo.h:6,
                 from /usr/include/linux/signal.h:7,
                 from /usr/include/linux/sched.h:28,
                 from /usr/include/asm/compat.h:8,
                 from /usr/include/linux/compat.h:15,
                 from /usr/include/linux/usbdevice_fs.h:35,
                 from sys-linux.c:15:
/usr/include/asm-generic/siginfo.h:75: error: syntax error before =E2=80=98=
clock_t=E2=80=99
/usr/include/asm-generic/siginfo.h:92: error: syntax error before =E2=80=98=
}=E2=80=99 token
/usr/include/asm-generic/siginfo.h:93: error: syntax error before =E2=80=98=
}=E2=80=99 token
In file included from /usr/include/linux/sched.h:32,
                 from /usr/include/asm/compat.h:8,
                 from /usr/include/linux/compat.h:15,
                 from /usr/include/linux/usbdevice_fs.h:35,
                 from sys-linux.c:15:
/usr/include/linux/completion.h:15: error: syntax error before =E2=80=98wai=
t_queue_head_t=E2=80=99
/usr/include/linux/completion.h: In function =E2=80=98init_completion=E2=80=
=99:
/usr/include/linux/completion.h:26: error: dereferencing pointer to incompl=
ete type
/usr/include/linux/completion.h:27: error: dereferencing pointer to incompl=
ete type
In file included from /usr/include/linux/sched.h:33,
                 from /usr/include/asm/compat.h:8,
                 from /usr/include/linux/compat.h:15,
                 from /usr/include/linux/usbdevice_fs.h:35,
                 from sys-linux.c:15:
/usr/include/linux/pid.h: At top level:
/usr/include/linux/pid.h:17: error: field =E2=80=98pid_chain=E2=80=99 has i=
ncomplete type
/usr/include/linux/pid.h:19: error: field =E2=80=98pid_list=E2=80=99 has in=
complete type
In file included from /usr/include/linux/sched.h:34,
                 from /usr/include/asm/compat.h:8,
                 from /usr/include/linux/compat.h:15,
                 from /usr/include/linux/usbdevice_fs.h:35,
                 from sys-linux.c:15:
/usr/include/linux/percpu.h: In function =E2=80=98__alloc_percpu=E2=80=99:
/usr/include/linux/percpu.h:45: error: =E2=80=98GFP_KERNEL=E2=80=99 undecla=
red (first use in this function)
In file included from /usr/include/linux/sched.h:36,
                 from /usr/include/asm/compat.h:8,
                 from /usr/include/linux/compat.h:15,
                 from /usr/include/linux/usbdevice_fs.h:35,
                 from sys-linux.c:15:
/usr/include/linux/seccomp.h: In function =E2=80=98secure_computing=E2=80=
=99:
/usr/include/linux/seccomp.h:18: error: =E2=80=98TIF_SECCOMP=E2=80=99 undec=
lared (first use in this function)
/usr/include/linux/seccomp.h: In function =E2=80=98has_secure_computing=E2=
=80=99:
/usr/include/linux/seccomp.h:24: error: =E2=80=98TIF_SECCOMP=E2=80=99 undec=
lared (first use in this function)
In file included from /usr/include/linux/sched.h:104,
                 from /usr/include/asm/compat.h:8,
                 from /usr/include/linux/compat.h:15,
                 from /usr/include/linux/usbdevice_fs.h:35,
                 from sys-linux.c:15:
/usr/include/linux/timer.h: At top level:
/usr/include/linux/timer.h:12: error: field =E2=80=98entry=E2=80=99 has inc=
omplete type
In file included from /usr/include/linux/compat.h:15,
                 from /usr/include/linux/usbdevice_fs.h:35,
                 from sys-linux.c:15:
/usr/include/asm/compat.h:12: error: syntax error before =E2=80=98compat_si=
ze_t=E2=80=99
/usr/include/asm/compat.h:13: error: syntax error before =E2=80=98compat_ss=
ize_t=E2=80=99
/usr/include/asm/compat.h:14: error: syntax error before =E2=80=98compat_ti=
me_t=E2=80=99
/usr/include/asm/compat.h:15: error: syntax error before =E2=80=98compat_cl=
ock_t=E2=80=99
/usr/include/asm/compat.h:16: error: syntax error before =E2=80=98compat_pi=
d_t=E2=80=99
/usr/include/asm/compat.h:17: error: syntax error before =E2=80=98compat_ui=
d_t=E2=80=99
/usr/include/asm/compat.h:18: error: syntax error before =E2=80=98compat_gi=
d_t=E2=80=99
/usr/include/asm/compat.h:19: error: syntax error before =E2=80=98compat_ui=
d32_t=E2=80=99
/usr/include/asm/compat.h:20: error: syntax error before =E2=80=98compat_gi=
d32_t=E2=80=99
/usr/include/asm/compat.h:21: error: syntax error before =E2=80=98compat_mo=
de_t=E2=80=99
/usr/include/asm/compat.h:22: error: syntax error before =E2=80=98compat_in=
o_t=E2=80=99
/usr/include/asm/compat.h:23: error: syntax error before =E2=80=98compat_de=
v_t=E2=80=99
/usr/include/asm/compat.h:24: error: syntax error before =E2=80=98compat_of=
f_t=E2=80=99
/usr/include/asm/compat.h:25: error: syntax error before =E2=80=98compat_lo=
ff_t=E2=80=99
/usr/include/asm/compat.h:26: error: syntax error before =E2=80=98compat_nl=
ink_t=E2=80=99
/usr/include/asm/compat.h:27: error: syntax error before =E2=80=98compat_ip=
c_pid_t=E2=80=99
/usr/include/asm/compat.h:28: error: syntax error before =E2=80=98compat_da=
ddr_t=E2=80=99
/usr/include/asm/compat.h:29: error: syntax error before =E2=80=98compat_ca=
ddr_t=E2=80=99
/usr/include/asm/compat.h:31: error: syntax error before =E2=80=98compat_ti=
mer_t=E2=80=99
/usr/include/asm/compat.h:32: error: syntax error before =E2=80=98compat_ke=
y_t=E2=80=99
/usr/include/asm/compat.h:34: error: syntax error before =E2=80=98compat_in=
t_t=E2=80=99
/usr/include/asm/compat.h:35: error: syntax error before =E2=80=98compat_lo=
ng_t=E2=80=99
/usr/include/asm/compat.h:36: error: syntax error before =E2=80=98compat_ui=
nt_t=E2=80=99
/usr/include/asm/compat.h:37: error: syntax error before =E2=80=98compat_ul=
ong_t=E2=80=99
/usr/include/asm/compat.h:40: error: syntax error before =E2=80=98compat_ti=
me_t=E2=80=99
/usr/include/asm/compat.h:45: error: syntax error before =E2=80=98compat_ti=
me_t=E2=80=99
/usr/include/asm/compat.h:50: error: syntax error before =E2=80=98compat_de=
v_t=E2=80=99
/usr/include/asm/compat.h:52: error: syntax error before =E2=80=98st_ino=E2=
=80=99
/usr/include/asm/compat.h:53: error: syntax error before =E2=80=98st_mode=
=E2=80=99
/usr/include/asm/compat.h:54: error: syntax error before =E2=80=98st_nlink=
=E2=80=99
/usr/include/asm/compat.h:55: error: syntax error before =E2=80=98st_uid=E2=
=80=99
/usr/include/asm/compat.h:56: error: syntax error before =E2=80=98st_gid=E2=
=80=99
/usr/include/asm/compat.h:57: error: syntax error before =E2=80=98st_rdev=
=E2=80=99
/usr/include/asm/compat.h:58: error: syntax error before =E2=80=98__pad2=E2=
=80=99
/usr/include/asm/compat.h:59: error: syntax error before =E2=80=98st_size=
=E2=80=99
/usr/include/asm/compat.h:60: error: syntax error before =E2=80=98st_blksiz=
e=E2=80=99
/usr/include/asm/compat.h:61: error: syntax error before =E2=80=98st_blocks=
=E2=80=99
/usr/include/asm/compat.h:62: error: syntax error before =E2=80=98st_atime=
=E2=80=99
/usr/include/asm/compat.h:63: error: syntax error before =E2=80=98st_atime_=
nsec=E2=80=99
/usr/include/asm/compat.h:64: error: syntax error before =E2=80=98st_mtime=
=E2=80=99
/usr/include/asm/compat.h:65: error: syntax error before =E2=80=98st_mtime_=
nsec=E2=80=99
/usr/include/asm/compat.h:66: error: syntax error before =E2=80=98st_ctime=
=E2=80=99
/usr/include/asm/compat.h:67: error: syntax error before =E2=80=98st_ctime_=
nsec=E2=80=99
/usr/include/asm/compat.h:68: error: syntax error before =E2=80=98__unused4=
=E2=80=99
/usr/include/asm/compat.h:69: error: syntax error before =E2=80=98__unused5=
=E2=80=99
/usr/include/asm/compat.h:75: error: syntax error before =E2=80=98compat_of=
f_t=E2=80=99
/usr/include/asm/compat.h:77: error: syntax error before =E2=80=98l_pid=E2=
=80=99
/usr/include/asm/compat.h:91: error: syntax error before =E2=80=98compat_lo=
ff_t=E2=80=99
/usr/include/asm/compat.h:93: error: syntax error before =E2=80=98l_pid=E2=
=80=99
/usr/include/asm/compat.h:113: error: syntax error before =E2=80=98compat_o=
ld_sigset_t=E2=80=99
/usr/include/asm/compat.h:118: error: syntax error before =E2=80=98compat_s=
igset_word=E2=80=99
/usr/include/asm/compat.h:124: error: syntax error before =E2=80=98compat_k=
ey_t=E2=80=99
/usr/include/asm/compat.h:126: error: syntax error before =E2=80=98gid=E2=
=80=99
/usr/include/asm/compat.h:127: error: syntax error before =E2=80=98cuid=E2=
=80=99
/usr/include/asm/compat.h:128: error: syntax error before =E2=80=98cgid=E2=
=80=99
/usr/include/asm/compat.h:130: error: conflicting types for =E2=80=98__pad1=
=E2=80=99
/usr/include/asm/compat.h:51: error: previous declaration of =E2=80=98__pad=
1=E2=80=99 was here
/usr/include/asm/compat.h:132: error: conflicting types for =E2=80=98__pad2=
=E2=80=99
/usr/include/asm/compat.h:58: error: previous declaration of =E2=80=98__pad=
2=E2=80=99 was here
/usr/include/asm/compat.h:133: error: syntax error before =E2=80=98unused1=
=E2=80=99
/usr/include/asm/compat.h:134: error: syntax error before =E2=80=98unused2=
=E2=80=99
/usr/include/asm/compat.h:138: error: field =E2=80=98sem_perm=E2=80=99 has =
incomplete type
/usr/include/asm/compat.h:139: error: syntax error before =E2=80=98compat_t=
ime_t=E2=80=99
/usr/include/asm/compat.h:141: error: syntax error before =E2=80=98sem_ctim=
e=E2=80=99
/usr/include/asm/compat.h:142: error: syntax error before =E2=80=98__unused=
2=E2=80=99
/usr/include/asm/compat.h:143: error: syntax error before =E2=80=98sem_nsem=
s=E2=80=99
/usr/include/asm/compat.h:144: error: syntax error before =E2=80=98__unused=
3=E2=80=99
/usr/include/asm/compat.h:145: error: syntax error before =E2=80=98__unused=
4=E2=80=99
/usr/include/asm/compat.h:149: error: field =E2=80=98msg_perm=E2=80=99 has =
incomplete type
/usr/include/asm/compat.h:150: error: syntax error before =E2=80=98compat_t=
ime_t=E2=80=99
/usr/include/asm/compat.h:152: error: syntax error before =E2=80=98msg_rtim=
e=E2=80=99
/usr/include/asm/compat.h:153: error: syntax error before =E2=80=98__unused=
2=E2=80=99
/usr/include/asm/compat.h:154: error: syntax error before =E2=80=98msg_ctim=
e=E2=80=99
/usr/include/asm/compat.h:155: error: syntax error before =E2=80=98__unused=
3=E2=80=99
/usr/include/asm/compat.h:156: error: syntax error before =E2=80=98msg_cbyt=
es=E2=80=99
/usr/include/asm/compat.h:157: error: syntax error before =E2=80=98msg_qnum=
=E2=80=99
/usr/include/asm/compat.h:158: error: syntax error before =E2=80=98msg_qbyt=
es=E2=80=99
/usr/include/asm/compat.h:159: error: syntax error before =E2=80=98msg_lspi=
d=E2=80=99
/usr/include/asm/compat.h:160: error: syntax error before =E2=80=98msg_lrpi=
d=E2=80=99
/usr/include/asm/compat.h:161: error: syntax error before =E2=80=98__unused=
4=E2=80=99
/usr/include/asm/compat.h:162: error: syntax error before =E2=80=98__unused=
5=E2=80=99
/usr/include/asm/compat.h:166: error: field =E2=80=98shm_perm=E2=80=99 has =
incomplete type
/usr/include/asm/compat.h:167: error: syntax error before =E2=80=98compat_s=
ize_t=E2=80=99
/usr/include/asm/compat.h:169: error: syntax error before =E2=80=98__unused=
1=E2=80=99
/usr/include/asm/compat.h:170: error: syntax error before =E2=80=98shm_dtim=
e=E2=80=99
/usr/include/asm/compat.h:171: error: syntax error before =E2=80=98__unused=
2=E2=80=99
/usr/include/asm/compat.h:172: error: syntax error before =E2=80=98shm_ctim=
e=E2=80=99
/usr/include/asm/compat.h:173: error: syntax error before =E2=80=98__unused=
3=E2=80=99
/usr/include/asm/compat.h:174: error: syntax error before =E2=80=98shm_cpid=
=E2=80=99
/usr/include/asm/compat.h:175: error: syntax error before =E2=80=98shm_lpid=
=E2=80=99
/usr/include/asm/compat.h:176: error: syntax error before =E2=80=98shm_natt=
ch=E2=80=99
/usr/include/asm/compat.h:177: error: syntax error before =E2=80=98__unused=
4=E2=80=99
/usr/include/asm/compat.h:178: error: syntax error before =E2=80=98__unused=
5=E2=80=99
/usr/include/asm/compat.h:187: error: syntax error before =E2=80=98compat_u=
ptr_t=E2=80=99
/usr/include/asm/compat.h:189: error: syntax error before =E2=80=98uptr=E2=
=80=99
/usr/include/asm/compat.h: In function =E2=80=98compat_ptr=E2=80=99:
/usr/include/asm/compat.h:191: error: =E2=80=98uptr=E2=80=99 undeclared (fi=
rst use in this function)
/usr/include/asm/compat.h: At top level:
/usr/include/asm/compat.h:194: error: syntax error before =E2=80=98ptr_to_c=
ompat=E2=80=99
/usr/include/asm/compat.h: In function =E2=80=98ptr_to_compat=E2=80=99:
/usr/include/asm/compat.h:196: error: =E2=80=98u32=E2=80=99 undeclared (fir=
st use in this function)
/usr/include/asm/compat.h:196: error: syntax error before =E2=80=98unsigned=
=E2=80=99
/usr/include/asm/compat.h: In function =E2=80=98compat_alloc_user_space=E2=
=80=99:
/usr/include/asm/compat.h:201: error: dereferencing pointer to incomplete t=
ype
In file included from /usr/include/linux/usbdevice_fs.h:35,
                 from sys-linux.c:15:
/usr/include/linux/compat.h: At top level:
/usr/include/linux/compat.h:24: error: field =E2=80=98it_interval=E2=80=99 =
has incomplete type
/usr/include/linux/compat.h:25: error: field =E2=80=98it_value=E2=80=99 has=
 incomplete type
/usr/include/linux/compat.h:29: error: syntax error before =E2=80=98compat_=
time_t=E2=80=99
/usr/include/linux/compat.h:34: error: field =E2=80=98it_interval=E2=80=99 =
has incomplete type
/usr/include/linux/compat.h:35: error: field =E2=80=98it_value=E2=80=99 has=
 incomplete type
/usr/include/linux/compat.h:39: error: syntax error before =E2=80=98compat_=
clock_t=E2=80=99
/usr/include/linux/compat.h:41: error: syntax error before =E2=80=98tms_cut=
ime=E2=80=99
/usr/include/linux/compat.h:42: error: syntax error before =E2=80=98tms_cst=
ime=E2=80=99
/usr/include/linux/compat.h:48: error: syntax error before =E2=80=98compat_=
sigset_word=E2=80=99
/usr/include/linux/compat.h:56: error: syntax error before =E2=80=98compat_=
uptr_t=E2=80=99
/usr/include/linux/compat.h:61: error: syntax error before =E2=80=98compat_=
ulong_t=E2=80=99
/usr/include/linux/compat.h:66: error: field =E2=80=98ru_utime=E2=80=99 has=
 incomplete type
/usr/include/linux/compat.h:67: error: field =E2=80=98ru_stime=E2=80=99 has=
 incomplete type
/usr/include/linux/compat.h:68: error: syntax error before =E2=80=98compat_=
long_t=E2=80=99
/usr/include/linux/compat.h:70: error: syntax error before =E2=80=98ru_idrs=
s=E2=80=99
/usr/include/linux/compat.h:71: error: syntax error before =E2=80=98ru_isrs=
s=E2=80=99
/usr/include/linux/compat.h:72: error: syntax error before =E2=80=98ru_minf=
lt=E2=80=99
/usr/include/linux/compat.h:73: error: syntax error before =E2=80=98ru_majf=
lt=E2=80=99
/usr/include/linux/compat.h:74: error: syntax error before =E2=80=98ru_nswa=
p=E2=80=99
/usr/include/linux/compat.h:75: error: syntax error before =E2=80=98ru_inbl=
ock=E2=80=99
/usr/include/linux/compat.h:76: error: syntax error before =E2=80=98ru_oubl=
ock=E2=80=99
/usr/include/linux/compat.h:77: error: syntax error before =E2=80=98ru_msgs=
nd=E2=80=99
/usr/include/linux/compat.h:78: error: syntax error before =E2=80=98ru_msgr=
cv=E2=80=99
/usr/include/linux/compat.h:79: error: syntax error before =E2=80=98ru_nsig=
nals=E2=80=99
/usr/include/linux/compat.h:80: error: syntax error before =E2=80=98ru_nvcs=
w=E2=80=99
/usr/include/linux/compat.h:81: error: syntax error before =E2=80=98ru_nivc=
sw=E2=80=99
/usr/include/linux/compat.h:88: error: syntax error before =E2=80=98compat_=
pid_t=E2=80=99
/usr/include/linux/compat.h:93: error: syntax error before =E2=80=98u32=E2=
=80=99
/usr/include/linux/compat.h:95: error: syntax error before =E2=80=98d_recle=
n=E2=80=99
/usr/include/linux/compat.h:97: error: syntax error before =E2=80=98}=E2=80=
=99 token
/usr/include/linux/compat.h:100: error: syntax error before =E2=80=98compat=
_int_t=E2=80=99
/usr/include/linux/compat.h:107: error: syntax error before =E2=80=98compat=
_sigval_t=E2=80=99
/usr/include/linux/compat.h:109: error: syntax error before =E2=80=98sigev_=
notify=E2=80=99
/usr/include/linux/compat.h:111: error: syntax error before =E2=80=98compat=
_int_t=E2=80=99
/usr/include/linux/compat.h:115: error: syntax error before =E2=80=98compat=
_uptr_t=E2=80=99
/usr/include/linux/compat.h:118: error: syntax error before =E2=80=98}=E2=
=80=99 token
/usr/include/linux/compat.h:119: error: syntax error before =E2=80=98}=E2=
=80=99 token
/usr/include/linux/compat.h:127: error: syntax error before =E2=80=98compat=
_uptr_t=E2=80=99
/usr/include/linux/compat.h:132: error: syntax error before =E2=80=98option=
=E2=80=99
/usr/include/linux/compat.h:140: error: syntax error before =E2=80=98compat=
_uptr_t=E2=80=99
/usr/include/linux/compat.h:143: error: syntax error before =E2=80=98compat=
_ulong_t=E2=80=99
/usr/include/linux/compat.h:152: error: syntax error before =E2=80=98compat=
_ulong_t=E2=80=99
/usr/include/linux/compat.h:154: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/compat.h:156: error: syntax error before =E2=80=98*=E2=
=80=99 token
/usr/include/linux/compat.h:157: error: syntax error before =E2=80=98siginf=
o_t=E2=80=99
In file included from sys-linux.c:15:
/usr/include/linux/usbdevice_fs.h:131: error: syntax error before =E2=80=98=
compat_int_t=E2=80=99
/usr/include/linux/usbdevice_fs.h:133: error: syntax error before =E2=80=98=
buffer=E2=80=99
/usr/include/linux/usbdevice_fs.h:134: error: syntax error before =E2=80=98=
buffer_length=E2=80=99
/usr/include/linux/usbdevice_fs.h:135: error: syntax error before =E2=80=98=
actual_length=E2=80=99
/usr/include/linux/usbdevice_fs.h:136: error: syntax error before =E2=80=98=
start_frame=E2=80=99
/usr/include/linux/usbdevice_fs.h:137: error: syntax error before =E2=80=98=
number_of_packets=E2=80=99
/usr/include/linux/usbdevice_fs.h:138: error: syntax error before =E2=80=98=
error_count=E2=80=99
/usr/include/linux/usbdevice_fs.h:139: error: syntax error before =E2=80=98=
signr=E2=80=99
/usr/include/linux/usbdevice_fs.h:140: error: syntax error before =E2=80=98=
usercontext=E2=80=99
/usr/include/linux/usbdevice_fs.h:142: error: syntax error before =E2=80=98=
}=E2=80=99 token
In file included from /usr/include/signal.h:212,
                 from sys-linux.c:22:
/usr/include/bits/siginfo.h:34: error: redefinition of =E2=80=98union sigva=
l=E2=80=99
/usr/include/bits/siginfo.h:52: error: nested redefinition of =E2=80=98stru=
ct siginfo=E2=80=99
/usr/include/bits/siginfo.h:65: error: syntax error before =E2=80=98.=E2=80=
=99 token
/usr/include/bits/siginfo.h:66: error: syntax error before =E2=80=98.=E2=80=
=99 token
/usr/include/bits/siginfo.h:72: error: syntax error before =E2=80=98.=E2=80=
=99 token
/usr/include/bits/siginfo.h:73: error: syntax error before =E2=80=98.=E2=80=
=99 token
/usr/include/bits/siginfo.h:75: error: syntax error before =E2=80=98}=E2=80=
=99 token
/usr/include/bits/siginfo.h:80: error: syntax error before =E2=80=98.=E2=80=
=99 token
/usr/include/bits/siginfo.h:81: error: syntax error before =E2=80=98.=E2=80=
=99 token
/usr/include/bits/siginfo.h:83: error: syntax error before =E2=80=98}=E2=80=
=99 token
/usr/include/bits/siginfo.h:88: error: syntax error before =E2=80=98.=E2=80=
=99 token
/usr/include/bits/siginfo.h:89: error: syntax error before =E2=80=98.=E2=80=
=99 token
/usr/include/bits/siginfo.h:90: error: syntax error before =E2=80=98.=E2=80=
=99 token
/usr/include/bits/siginfo.h:91: error: syntax error before =E2=80=98.=E2=80=
=99 token
/usr/include/bits/siginfo.h:92: error: syntax error before =E2=80=98.=E2=80=
=99 token
/usr/include/bits/siginfo.h:98: error: syntax error before =E2=80=98.=E2=80=
=99 token
/usr/include/bits/siginfo.h:99: error: conflicting types for =E2=80=98_sigf=
ault=E2=80=99
/usr/include/asm-generic/siginfo.h:85: error: previous declaration of =E2=
=80=98_sigfault=E2=80=99 was here
/usr/include/bits/siginfo.h:104: error: syntax error before =E2=80=98.=E2=
=80=99 token
/usr/include/bits/siginfo.h:105: error: syntax error before =E2=80=98.=E2=
=80=99 token
/usr/include/bits/siginfo.h:106: error: conflicting types for =E2=80=98_sig=
poll=E2=80=99
/usr/include/asm-generic/siginfo.h:91: error: previous declaration of =E2=
=80=98_sigpoll=E2=80=99 was here
/usr/include/bits/siginfo.h:107: error: syntax error before =E2=80=98}=E2=
=80=99 token
/usr/include/bits/siginfo.h:108: error: syntax error before =E2=80=98}=E2=
=80=99 token
/usr/include/bits/siginfo.h:133: error: syntax error before =E2=80=98-=E2=
=80=99 token
/usr/include/bits/siginfo.h:155: error: syntax error before =E2=80=98(=E2=
=80=99 token
/usr/include/bits/siginfo.h:176: error: syntax error before =E2=80=98(=E2=
=80=99 token
/usr/include/bits/siginfo.h:197: error: syntax error before =E2=80=98(=E2=
=80=99 token
/usr/include/bits/siginfo.h:206: error: syntax error before =E2=80=98(=E2=
=80=99 token
/usr/include/bits/siginfo.h:217: error: syntax error before =E2=80=98(=E2=
=80=99 token
/usr/include/bits/siginfo.h:226: error: syntax error before =E2=80=98(=E2=
=80=99 token
/usr/include/bits/siginfo.h:243: error: syntax error before =E2=80=98(=E2=
=80=99 token
/usr/include/bits/siginfo.h:274: error: redefinition of =E2=80=98struct sig=
event=E2=80=99
/usr/include/bits/siginfo.h:302: error: syntax error before numeric constant
In file included from /usr/include/signal.h:246,
                 from sys-linux.c:22:
/usr/include/bits/sigaction.h:26: error: redefinition of =E2=80=98struct si=
gaction=E2=80=99
/usr/include/bits/sigaction.h:34: error: syntax error before =E2=80=98sigin=
fo_t=E2=80=99
In file included from sys-linux.c:22:
/usr/include/signal.h:280: error: syntax error before =E2=80=98siginfo_t=E2=
=80=99
/usr/include/signal.h:288: error: syntax error before =E2=80=98siginfo_t=E2=
=80=99
In file included from /usr/include/signal.h:333,
                 from sys-linux.c:22:
/usr/include/bits/sigcontext.h:102: error: redefinition of =E2=80=98struct =
_fpstate=E2=80=99
/usr/include/bits/sigcontext.h:118: error: redefinition of =E2=80=98struct =
sigcontext=E2=80=99
In file included from /usr/include/signal.h:348,
                 from sys-linux.c:22:
/usr/include/bits/sigstack.h:36: error: syntax error before numeric constant
/usr/include/bits/sigstack.h:51: error: redefinition of =E2=80=98struct sig=
altstack=E2=80=99


--zOcTNEe3AzgCmdo9--

--jITzwD3HDGXid3BE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDGWxsXaXGVTD0i/8RAo2DAJ9LzBGucYPpvx/Syb46MePC7ltMfgCfWmJp
rZMrX34bJSsmzL1t+HZhGZs=
=jKzw
-----END PGP SIGNATURE-----

--jITzwD3HDGXid3BE--
