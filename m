Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135689AbRDSUT3>; Thu, 19 Apr 2001 16:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135686AbRDSUTR>; Thu, 19 Apr 2001 16:19:17 -0400
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:22537 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S135680AbRDSUSs>; Thu, 19 Apr 2001 16:18:48 -0400
Date: Thu, 19 Apr 2001 14:18:44 -0600
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: Re: BUG: Global FPU corruption in 2.2
Message-ID: <20010419141844.A26200@mail.harddata.com>
In-Reply-To: <cpx7l0g3mfk.fsf@goat.cs.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <cpx7l0g3mfk.fsf@goat.cs.wisc.edu>; from zandy@cs.wisc.edu on Thu, Apr 19, 2001 at 11:05:03AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 19, 2001 at 11:05:03AM -0500, Victor Zandy wrote:
> 
> We have found that one of our programs can cause system-wide
> corruption of the x86 FPU under 2.2.16 and 2.2.17.
....
> 
> We see this problem on dual 550MHz Xeons with 1GB RAM.

Hm, I started to wonder if this is not somewhat related to a recent
report I got.  "The victim" was running 2.2.19 (basically) on an SMP
Alpha UP2000+ with two 800 MHz processors.  He managed to reduce the
problem to a rather small test case and I attach sources,  Makefile and
a "loop.sh" driver as a shar archive if you want to have a closer look.

This "loop.sh" simply fires triplets of "harry" process in a loop.
The guy hit by this gets apparently random floating point exceptions
starting with roughly sixth process and later intervals between bombs
will vary.  I have also 'strace' outputs from failing processes but
they are not telling very much.  'gdb' is also not very illuminating:

Program received signal SIGFPE, Arithmetic exception.
0x1200010a8 in vadd_ (a=0x11fff21e4, ia=0x120003294, b=0x11fff7004, 
    ib=0x120003294, c=0x11fffbe20, ic=0x120003294, n=0x11ffffc70) at vadd.f:99
99               C(CI) = A(AI) + B(BI)
Current language:  auto; currently fortran

(gdb) p *ia
$10 = 1
(gdb) p *ib
$11 = 1
(gdb) p *ic
$12 = 1
(gdb) p *n
Cannot access memory at address 0x4
(gdb) p *(0x11ffffc70)
$13 = 1024

(gdb) info locals
n = (PTR TO -> ( integer )) 0x4
__g77_expr_0 = 10


He tells me that he is getting that on two different machines he has
around.

The trouble is that I tried to repeat that with different hardware,
kernels, compilers and libraries and I failed even on SMP; but I got an
access to a box with only 667 MHz processors.  OTOH he is running
right now 2.4.3-ac9 plus Andrea Arcangeli patches for rw semaphores
on Alpha and he reports that the problem went away (and, hopefuly,
nothing else will crop out :-).

Anybody can offer an insight what that may really be?  It may be,
of course, totally unrelated to this report from Victor Zandy.

  Michal
  michal@harddata.com


--ibTvN161/egqYuK8
Content-Type: application/x-shar
Content-Disposition: attachment; filename="fpbomb.shar"

#!/bin/sh
# This is a shell archive (produced by GNU sharutils 4.2).
# To extract the files from this archive, save it to some FILE, remove
# everything before the `!/bin/sh' line above, then type `sh FILE'.
#
# Made on 2001-04-19 13:48 MDT by <michal@mail>.
# Source directory was `/home/michal/broi'.
#
# Existing files will *not* be overwritten unless `-c' is specified.
#
# This shar contains:
# length mode       name
# ------ ---------- ------------------------------------------
#    117 -rw-rw-r-- Makefile
#    288 -rw-rw-r-- harry.f
#   3209 -rw-rw-r-- vadd.f
#   2829 -rw-rw-r-- vmov.f
#     69 -rwxrwxr-x loop.sh
#
save_IFS="${IFS}"
IFS="${IFS}:"
gettext_dir=FAILED
locale_dir=FAILED
first_param="$1"
for dir in $PATH
do
  if test "$gettext_dir" = FAILED && test -f $dir/gettext \
     && ($dir/gettext --version >/dev/null 2>&1)
  then
    set `$dir/gettext --version 2>&1`
    if test "$3" = GNU
    then
      gettext_dir=$dir
    fi
  fi
  if test "$locale_dir" = FAILED && test -f $dir/shar \
     && ($dir/shar --print-text-domain-dir >/dev/null 2>&1)
  then
    locale_dir=`$dir/shar --print-text-domain-dir`
  fi
done
IFS="$save_IFS"
if test "$locale_dir" = FAILED || test "$gettext_dir" = FAILED
then
  echo=echo
else
  TEXTDOMAINDIR=$locale_dir
  export TEXTDOMAINDIR
  TEXTDOMAIN=sharutils
  export TEXTDOMAIN
  echo="$gettext_dir/gettext -s"
fi
touch -am 1231235999 $$.touch >/dev/null 2>&1
if test ! -f 1231235999 && test -f $$.touch; then
  shar_touch=touch
else
  shar_touch=:
  echo
  $echo 'WARNING: not restoring timestamps.  Consider getting and'
  $echo "installing GNU \`touch', distributed in GNU File Utilities..."
  echo
fi
rm -f 1231235999 $$.touch
#
if mkdir _sh26171; then
  $echo 'x -' 'creating lock directory'
else
  $echo 'failed to create lock directory'
  exit 1
fi
# ============= Makefile ==============
if test -f 'Makefile' && test "$first_param" != -c; then
  $echo 'x -' SKIPPING 'Makefile' '(file already exists)'
else
  $echo 'x -' extracting 'Makefile' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'Makefile' &&
FC=g77
FFLAGS=-O2
X
harry: harry.o vmov.o vadd.o
X	$(FC) -v -o harry harry.o vmov.o vadd.o
X
clean:
X	rm -rf harry *.o
X
X
SHAR_EOF
  $shar_touch -am 04111758101 'Makefile' &&
  chmod 0664 'Makefile' ||
  $echo 'restore of' 'Makefile' 'failed'
  if ( md5sum --help 2>&1 | grep 'sage: md5sum \[' ) >/dev/null 2>&1 \
  && ( md5sum --version 2>&1 | grep -v 'textutils 1.12' ) >/dev/null; then
    md5sum -c << SHAR_EOF >/dev/null 2>&1 \
    || $echo 'Makefile:' 'MD5 check failed'
c211b540542140580404c93197c51381  Makefile
SHAR_EOF
  else
    shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'Makefile'`"
    test 117 -eq "$shar_count" ||
    $echo 'Makefile:' 'original size' '117,' 'current size' "$shar_count!"
  fi
fi
# ============= harry.f ==============
if test -f 'harry.f' && test "$first_param" != -c; then
  $echo 'x -' SKIPPING 'harry.f' '(file already exists)'
else
  $echo 'x -' extracting 'harry.f' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'harry.f' &&
X
C TMATH
X
X	REAL A(5000), B(5000),C(5000)
X
X	NTIME=50000
X	N=1024
X	TMAX=1000.0
X	TEMP=0.0
X	NZERO=0
X
X	DO I=1,5000
X	  A(I)=sin(TEMP)
X	  B(I)=REAL(I)*0.9
X	  TEMP=TEMP+0.2
X	ENDDO
X
X	DO J=1,NTIME
X	  CALL VMOV(a,1,C,1,N)
X	ENDDO
X
X	DO J=1,NTIME
X	  CALL VADD(a,1,b,1,C,1,N)
X	ENDDO
X
X
X	call exit(1)
X	end
SHAR_EOF
  $shar_touch -am 04111113101 'harry.f' &&
  chmod 0664 'harry.f' ||
  $echo 'restore of' 'harry.f' 'failed'
  if ( md5sum --help 2>&1 | grep 'sage: md5sum \[' ) >/dev/null 2>&1 \
  && ( md5sum --version 2>&1 | grep -v 'textutils 1.12' ) >/dev/null; then
    md5sum -c << SHAR_EOF >/dev/null 2>&1 \
    || $echo 'harry.f:' 'MD5 check failed'
4916022df127194190f21283288bba26  harry.f
SHAR_EOF
  else
    shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'harry.f'`"
    test 288 -eq "$shar_count" ||
    $echo 'harry.f:' 'original size' '288,' 'current size' "$shar_count!"
  fi
fi
# ============= vadd.f ==============
if test -f 'vadd.f' && test "$first_param" != -c; then
  $echo 'x -' SKIPPING 'vadd.f' '(file already exists)'
else
  $echo 'x -' extracting 'vadd.f' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'vadd.f' &&
C****** @(#)VADD 5.1 10/11/89  Copyright (c) 1989 by FPS Computing
C
C  Copyright (c) 1989 by FPS Computing
C
C  Permission to use, copy, modify, and distribute this software, 
C  FPSMath (TM), and its documentation for any purpose and without fee 
C  is hereby granted, provided that the above copyright notice and this
C  permission notice appear in all copies of this software and its 
C  supporting documentation, and that FPS Computing and FPSMath (TM) be
C  mentioned in all documentation and advertisement of any products 
C  derived from or using this software.  This software library may not 
C  be renamed in any way and must be called FPSMath (TM).  FPS Computing
C  makes no representations about the suitability of this software for 
C  any purpose.  It is provided AS IS without express or implied 
C  warranty including any WARRANTY OF FITNESS FOR A PARTICULAR PURPOSE 
C  AND MERCHANTABILITY.  The information contained in FPSMath (TM) is 
C  subject to change without notice.
C  
C  FPSMath and FPS Computing are Trademarks of Floating Point Systems, 
C  Inc.
C
C-----------------------------------------------------------------------
C
C  V E C T O R    A D D
C
C  PURPOSE:
C       To add the elements of two vectors.
C
C  FORTRAN SYNOPSIS:
C       SUBROUTINE VADD (A, IA, B, IB, C, IC, N)
C       REAL*4       A(1), B(1), C(1)
C       INTEGER*4    IA, IB, IC, N
C
C  INPUT PARAMETERS:
C       A               Real            Vector
C                       Input vector.
C       IA              Integer         Scalar
C                       Element stride for A.
C       B               Real            Vector
C                       Input vector.
C       IB              Integer         Scalar
C                       Element stride for B.
C       IC              Integer         Scalar
C                       Element stride for C.
C       N               Integer         Scalar
C                       Element count.
C
C  OUTPUT PARAMETERS:
C       C               Real            Vector
C                       Output vector.
C
C  DESCRIPTION:
C       C(m) = B(m) + A(m);    for m = 1 to N
C
C  EXAMPLE:
C       Input:
C
C         N  = 3
C         IA = 1
C         IB = 1
C         IC = 1
C
C         A:  0.0   1.0   2.0
C         B:  1.0   2.0   3.0
C
C       Output:
C
C         C:  1.0   3.0   5.0
C
C-----------------------------------------------------------------------
C
X      SUBROUTINE VADD (A, IA, B, IB, C, IC, N)
C
X      REAL*4       A(1), B(1), C(1)
X      INTEGER*4    IA, IB, IC, N
C
C----------------------------------------------------------------------
C
X      INTEGER*4    AI
C                       Pointer to A vector
X      INTEGER*4    BI
C                       Pointer to B vector
X      INTEGER*4    CI
C                       Pointer to C vector
X      INTEGER*4    I
C                       Index for DO loop
C
C----------------------------------------------------------------------
C
C  Verify parameter
C
X      IF (N .LE. 0) GOTO 9999
C
X      AI = 1
X      BI = 1
X      CI = 1
C
X      DO 10 I = 1, N
X         C(CI) = A(AI) + B(BI)
X         AI    = AI + IA
X         BI    = BI + IB
X         CI    = CI + IC
X   10 CONTINUE
C
X 9999 CONTINUE
X      RETURN
X      END
SHAR_EOF
  $shar_touch -am 04111113101 'vadd.f' &&
  chmod 0664 'vadd.f' ||
  $echo 'restore of' 'vadd.f' 'failed'
  if ( md5sum --help 2>&1 | grep 'sage: md5sum \[' ) >/dev/null 2>&1 \
  && ( md5sum --version 2>&1 | grep -v 'textutils 1.12' ) >/dev/null; then
    md5sum -c << SHAR_EOF >/dev/null 2>&1 \
    || $echo 'vadd.f:' 'MD5 check failed'
30b99c91c250dd3ef848f627f3d2cb6e  vadd.f
SHAR_EOF
  else
    shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'vadd.f'`"
    test 3209 -eq "$shar_count" ||
    $echo 'vadd.f:' 'original size' '3209,' 'current size' "$shar_count!"
  fi
fi
# ============= vmov.f ==============
if test -f 'vmov.f' && test "$first_param" != -c; then
  $echo 'x -' SKIPPING 'vmov.f' '(file already exists)'
else
  $echo 'x -' extracting 'vmov.f' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'vmov.f' &&
C****** @(#)VMOV 5.1 10/11/89  Copyright (c) 1989 by FPS Computing
C
C  Copyright (c) 1989 by FPS Computing
C
C  Permission to use, copy, modify, and distribute this software, 
C  FPSMath (TM), and its documentation for any purpose and without fee 
C  is hereby granted, provided that the above copyright notice and this
C  permission notice appear in all copies of this software and its 
C  supporting documentation, and that FPS Computing and FPSMath (TM) be
C  mentioned in all documentation and advertisement of any products 
C  derived from or using this software.  This software library may not 
C  be renamed in any way and must be called FPSMath (TM).  FPS Computing
C  makes no representations about the suitability of this software for 
C  any purpose.  It is provided AS IS without express or implied 
C  warranty including any WARRANTY OF FITNESS FOR A PARTICULAR PURPOSE 
C  AND MERCHANTABILITY.  The information contained in FPSMath (TM) is 
C  subject to change without notice.
C  
C  FPSMath and FPS Computing are Trademarks of Floating Point Systems, 
C  Inc.
C
C-----------------------------------------------------------------------
C
C  V E C T O R   M O V E
C
C  PURPOSE:
C       To move elements from one vector to another.
C
C  FORTRAN SYNOPSIS:
C       SUBROUTINE VMOV (A, IA, C, IC, N)
C       REAL*4       A(1), C(1)
C       INTEGER*4    IA, IC, N
C
C  INPUT PARAMETERS:
C       A               Real            Vector
C                       Input vector.
C       IA              Integer         Scalar
C                       Element stride for A.
C       IC              Integer         Scalar
C                       Element stride for C.
C       N               Integer         Scalar
C                       Element count.
C
C  OUTPUT PARAMETERS:
C       C               Real            Vector
C                       Output vector.
C
C  DESCRIPTION:
C       C(m) = A(m);    for m = 1 to N
C
C  EXAMPLE:
C       Input:
C
C         N  = 3
C         IA = 1
C         IC = 1
C
C         A:  0.0  1.0  2.0
C
C       Output:
C
C         C:  0.0  1.0  2.0
C
C----------------------------------------------------------------------
C
X      SUBROUTINE VMOV(A, IA, C, IC, N)
C
X      REAL*4       A(1), C(1)
X      INTEGER*4    IA, IC, N
C
C----------------------------------------------------------------------
C
X      INTEGER*4    AI
C                       Pointer to A vector
X      INTEGER*4    CI
C                       Pointer to C vector
X      INTEGER*4    I
C                       Index for DO loop
C
C----------------------------------------------------------------------
C
C  Verify parameter
C
X      IF (N .LE. 0) GOTO 9999
C
X      AI = 1
X      CI = 1
C
X      DO 10 I = 1, N
X         C(CI) = A(AI)
X         AI = AI + IA
X         CI = CI + IC
X   10 CONTINUE
C
X 9999 CONTINUE
X      RETURN
X      END
SHAR_EOF
  $shar_touch -am 04111113101 'vmov.f' &&
  chmod 0664 'vmov.f' ||
  $echo 'restore of' 'vmov.f' 'failed'
  if ( md5sum --help 2>&1 | grep 'sage: md5sum \[' ) >/dev/null 2>&1 \
  && ( md5sum --version 2>&1 | grep -v 'textutils 1.12' ) >/dev/null; then
    md5sum -c << SHAR_EOF >/dev/null 2>&1 \
    || $echo 'vmov.f:' 'MD5 check failed'
4948aa1db01ce8e130b0417787feb22d  vmov.f
SHAR_EOF
  else
    shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'vmov.f'`"
    test 2829 -eq "$shar_count" ||
    $echo 'vmov.f:' 'original size' '2829,' 'current size' "$shar_count!"
  fi
fi
# ============= loop.sh ==============
if test -f 'loop.sh' && test "$first_param" != -c; then
  $echo 'x -' SKIPPING 'loop.sh' '(file already exists)'
else
  $echo 'x -' extracting 'loop.sh' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'loop.sh' &&
#!/bin/sh
X
while : ; do
X    ./harry &
X    ./harry &
X    ./harry
done
SHAR_EOF
  $shar_touch -am 04111759101 'loop.sh' &&
  chmod 0775 'loop.sh' ||
  $echo 'restore of' 'loop.sh' 'failed'
  if ( md5sum --help 2>&1 | grep 'sage: md5sum \[' ) >/dev/null 2>&1 \
  && ( md5sum --version 2>&1 | grep -v 'textutils 1.12' ) >/dev/null; then
    md5sum -c << SHAR_EOF >/dev/null 2>&1 \
    || $echo 'loop.sh:' 'MD5 check failed'
1120d720e9bf809b9972eaced9030d7b  loop.sh
SHAR_EOF
  else
    shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'loop.sh'`"
    test 69 -eq "$shar_count" ||
    $echo 'loop.sh:' 'original size' '69,' 'current size' "$shar_count!"
  fi
fi
rm -fr _sh26171
exit 0

--ibTvN161/egqYuK8--
