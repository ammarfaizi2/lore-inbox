Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319590AbSH3Pf4>; Fri, 30 Aug 2002 11:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319597AbSH3Pf4>; Fri, 30 Aug 2002 11:35:56 -0400
Received: from mx5.sac.fedex.com ([199.81.194.37]:22024 "EHLO
	mx5.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S319590AbSH3Pfv>; Fri, 30 Aug 2002 11:35:51 -0400
Date: Fri, 30 Aug 2002 23:39:31 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Klaus Dittrich <kladit@t-online.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: re: gcc3.2 compiling glibc-2.2.5
Message-ID: <Pine.LNX.4.44.0208302338190.14968-300000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/30/2002
 11:40:10 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/30/2002
 11:40:12 PM
Content-Type: MULTIPART/Mixed; BOUNDARY="0-286436026-1030721039=:14968"
Content-ID: <Pine.LNX.4.44.0208302338260.14968@boston.corp.fedex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0-286436026-1030721039=:14968
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0208302338261.14968@boston.corp.fedex.com>




Attached are the two files to solve the __udivdi3, version GLIBC_2.0 no
symbol errors ...


Put the divdi3.c to glibc-2.2.5/sysdeps/wordsize-32/divdi3.c, and Makefile
to glibc-2.2.5/sysdeps/i386/Makefile


If you can't get these attachment, you can try downloading from ...

[divdi3.c]
http://sources.redhat.com/cgi-bin/cvsweb.cgi/libc/sysdeps/wordsize-32/divdi3.c

[Makefile]
http://sources.redhat.com/cgi-bin/cvsweb.cgi/libc/sysdeps/i386/?cvsroot=glibc


After replacing these files, recompile glibc-2.2.5 again.

If you don't apply these patches, you won't be able to run X11 programs
such as mozilla or vmware (__udivdi3 undefined).

If you download divdi3.c from the cvs site, make sure you commented out
the following like below, else the code will fail to compile with the
stock glibc-2.2.5 source.

	//INTDEF(__divdi3)


All files compiled with the new gcc3.2 and recompiled glibc-2.2.5 will
save you some space after you strip them. Seems to be more efficient.

Thanks,
Jeff
[ jchua@fedex.com ]

On Fri, 30 Aug 2002, Klaus Dittrich wrote:

> I compiled linux-2.4.20-pre5 using gcc-3.2,
> glibc2.2.5 (build with gcc-3.1.1) and binutils-2.13.90.0.4.
>
> No problems here. (SMP, PIII-800, Intel-BX)
>
> Please mail me the location of the patch for glibc-2.2.5.
> --
> Regards Klaus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--0-286436026-1030721039=:14968
Content-Type: TEXT/PLAIN; NAME="divdi3.c"
Content-ID: <Pine.LNX.4.44.0208302323590.14968@boston.corp.fedex.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="divdi3.c"
Content-Transfer-Encoding: quoted-printable

/* 64-bit multiplication and division
   Copyright (C) 1989, 1992-1999, 2000, 2001, 2002
   Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, write to the Free
   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
   02111-1307 USA.  */

#include <endian.h>
#include <stdlib.h>
#include <bits/wordsize.h>

#if =5F=5FWORDSIZE !=3D 32
#error This is for 32-bit targets only
#endif

typedef unsigned int UQItype	=5F=5Fattribute=5F=5F ((mode (QI)));
typedef          int SItype	=5F=5Fattribute=5F=5F ((mode (SI)));
typedef unsigned int USItype	=5F=5Fattribute=5F=5F ((mode (SI)));
typedef          int DItype	=5F=5Fattribute=5F=5F ((mode (DI)));
typedef unsigned int UDItype	=5F=5Fattribute=5F=5F ((mode (DI)));
#define Wtype SItype
#define HWtype SItype
#define DWtype DItype
#define UWtype USItype
#define UHWtype USItype
#define UDWtype UDItype
#define W=5FTYPE=5FSIZE 32

#include <stdlib/longlong.h>

#if =5F=5FBYTE=5FORDER =3D=3D =5F=5FBIG=5FENDIAN
struct DWstruct { Wtype high, low;};
#elif =5F=5FBYTE=5FORDER =3D=3D =5F=5FLITTLE=5FENDIAN
struct DWstruct { Wtype low, high;};
#else
#error Unhandled endianity
#endif
typedef union { struct DWstruct s; DWtype ll; } DWunion;

/* Prototypes of exported functions.  */
extern DWtype =5F=5Fdivdi3 (DWtype u, DWtype v);
extern DWtype =5F=5Fmoddi3 (DWtype u, DWtype v);
extern UDWtype =5F=5Fudivdi3 (UDWtype u, UDWtype v);
extern UDWtype =5F=5Fumoddi3 (UDWtype u, UDWtype v);

static UDWtype
=5F=5Fudivmoddi4 (UDWtype n, UDWtype d, UDWtype *rp)
{
  DWunion ww;
  DWunion nn, dd;
  DWunion rr;
  UWtype d0, d1, n0, n1, n2;
  UWtype q0, q1;
  UWtype b, bm;

  nn.ll =3D n;
  dd.ll =3D d;

  d0 =3D dd.s.low;
  d1 =3D dd.s.high;
  n0 =3D nn.s.low;
  n1 =3D nn.s.high;

#if !UDIV=5FNEEDS=5FNORMALIZATION
  if (d1 =3D=3D 0)
    {
      if (d0 > n1)
	{
	  /* 0q =3D nn / 0D */

	  udiv=5Fqrnnd (q0, n0, n1, n0, d0);
	  q1 =3D 0;

	  /* Remainder in n0.  */
	}
      else
	{
	  /* qq =3D NN / 0d */

	  if (d0 =3D=3D 0)
	    d0 =3D 1 / d0;	/* Divide intentionally by zero.  */

	  udiv=5Fqrnnd (q1, n1, 0, n1, d0);
	  udiv=5Fqrnnd (q0, n0, n1, n0, d0);

	  /* Remainder in n0.  */
	}

      if (rp !=3D 0)
	{
	  rr.s.low =3D n0;
	  rr.s.high =3D 0;
	  *rp =3D rr.ll;
	}
    }

#else /* UDIV=5FNEEDS=5FNORMALIZATION */

  if (d1 =3D=3D 0)
    {
      if (d0 > n1)
	{
	  /* 0q =3D nn / 0D */

	  count=5Fleading=5Fzeros (bm, d0);

	  if (bm !=3D 0)
	    {
	      /* Normalize, i.e. make the most significant bit of the
		 denominator set.  */

	      d0 =3D d0 << bm;
	      n1 =3D (n1 << bm) | (n0 >> (W=5FTYPE=5FSIZE - bm));
	      n0 =3D n0 << bm;
	    }

	  udiv=5Fqrnnd (q0, n0, n1, n0, d0);
	  q1 =3D 0;

	  /* Remainder in n0 >> bm.  */
	}
      else
	{
	  /* qq =3D NN / 0d */

	  if (d0 =3D=3D 0)
	    d0 =3D 1 / d0;	/* Divide intentionally by zero.  */

	  count=5Fleading=5Fzeros (bm, d0);

	  if (bm =3D=3D 0)
	    {
	      /* From (n1 >=3D d0) /\ (the most significant bit of d0 is set),
		 conclude (the most significant bit of n1 is set) /\ (the
		 leading quotient digit q1 =3D 1).

		 This special case is necessary, not an optimization.
		 (Shifts counts of W=5FTYPE=5FSIZE are undefined.)  */

	      n1 -=3D d0;
	      q1 =3D 1;
	    }
	  else
	    {
	      /* Normalize.  */

	      b =3D W=5FTYPE=5FSIZE - bm;

	      d0 =3D d0 << bm;
	      n2 =3D n1 >> b;
	      n1 =3D (n1 << bm) | (n0 >> b);
	      n0 =3D n0 << bm;

	      udiv=5Fqrnnd (q1, n1, n2, n1, d0);
	    }

	  /* n1 !=3D d0...  */

	  udiv=5Fqrnnd (q0, n0, n1, n0, d0);

	  /* Remainder in n0 >> bm.  */
	}

      if (rp !=3D 0)
	{
	  rr.s.low =3D n0 >> bm;
	  rr.s.high =3D 0;
	  *rp =3D rr.ll;
	}
    }
#endif /* UDIV=5FNEEDS=5FNORMALIZATION */

  else
    {
      if (d1 > n1)
	{
	  /* 00 =3D nn / DD */

	  q0 =3D 0;
	  q1 =3D 0;

	  /* Remainder in n1n0.  */
	  if (rp !=3D 0)
	    {
	      rr.s.low =3D n0;
	      rr.s.high =3D n1;
	      *rp =3D rr.ll;
	    }
	}
      else
	{
	  /* 0q =3D NN / dd */

	  count=5Fleading=5Fzeros (bm, d1);
	  if (bm =3D=3D 0)
	    {
	      /* From (n1 >=3D d1) /\ (the most significant bit of d1 is set),
		 conclude (the most significant bit of n1 is set) /\ (the
		 quotient digit q0 =3D 0 or 1).

		 This special case is necessary, not an optimization.  */

	      /* The condition on the next line takes advantage of that
		 n1 >=3D d1 (true due to program flow).  */
	      if (n1 > d1 || n0 >=3D d0)
		{
		  q0 =3D 1;
		  sub=5Fddmmss (n1, n0, n1, n0, d1, d0);
		}
	      else
		q0 =3D 0;

	      q1 =3D 0;

	      if (rp !=3D 0)
		{
		  rr.s.low =3D n0;
		  rr.s.high =3D n1;
		  *rp =3D rr.ll;
		}
	    }
	  else
	    {
	      UWtype m1, m0;
	      /* Normalize.  */

	      b =3D W=5FTYPE=5FSIZE - bm;

	      d1 =3D (d1 << bm) | (d0 >> b);
	      d0 =3D d0 << bm;
	      n2 =3D n1 >> b;
	      n1 =3D (n1 << bm) | (n0 >> b);
	      n0 =3D n0 << bm;

	      udiv=5Fqrnnd (q0, n1, n2, n1, d1);
	      umul=5Fppmm (m1, m0, q0, d0);

	      if (m1 > n1 || (m1 =3D=3D n1 && m0 > n0))
		{
		  q0--;
		  sub=5Fddmmss (m1, m0, m1, m0, d1, d0);
		}

	      q1 =3D 0;

	      /* Remainder in (n1n0 - m1m0) >> bm.  */
	      if (rp !=3D 0)
		{
		  sub=5Fddmmss (n1, n0, n1, n0, m1, m0);
		  rr.s.low =3D (n1 << b) | (n0 >> bm);
		  rr.s.high =3D n1 >> bm;
		  *rp =3D rr.ll;
		}
	    }
	}
    }

  ww.s.low =3D q0;
  ww.s.high =3D q1;
  return ww.ll;
}

DWtype
=5F=5Fdivdi3 (DWtype u, DWtype v)
{
  Wtype c =3D 0;
  DWtype w;

  if (u < 0)
    {
      c =3D ~c;
      u =3D -u;
    }
  if (v < 0)
    {
      c =3D ~c;
      v =3D -v;
    }
  w =3D =5F=5Fudivmoddi4 (u, v, NULL);
  if (c)
    w =3D -w;
  return w;
}
//INTDEF(=5F=5Fdivdi3)

DWtype
=5F=5Fmoddi3 (DWtype u, DWtype v)
{
  Wtype c =3D 0;
  DWtype w;

  if (u < 0)
    {
      c =3D ~c;
      u =3D -u;
    }
  if (v < 0)
    v =3D -v;
  =5F=5Fudivmoddi4 (u, v, &w);
  if (c)
    w =3D -w;
  return w;
}

UDWtype
=5F=5Fudivdi3 (UDWtype u, UDWtype v)
{
  return =5F=5Fudivmoddi4 (u, v, NULL);
}

UDWtype
=5F=5Fumoddi3 (UDWtype u, UDWtype v)
{
  UDWtype w;

  =5F=5Fudivmoddi4 (u, v, &w);
  return w;
}

--0-286436026-1030721039=:14968
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=Makefile
Content-ID: <Pine.LNX.4.44.0208302323591.14968@boston.corp.fedex.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=Makefile
Content-Transfer-Encoding: quoted-printable

# The mpn functions need a #define for asm syntax flavor.
# Every i386 port in use uses gas syntax (I think).
asm-CPPFLAGS +=3D -DGAS=5FSYNTAX

# The i386 `long double' is a distinct type we support.
long-double-fcts =3D yes

ifeq ($(subdir),csu)
# On i686 we must avoid generating the trampoline functions generated
# to get the GOT pointer.
CFLAGS-initfini.s +=3D -march=3Di386 -mcpu=3Di386

ifeq (yes,$(build-shared))
# Compatibility
sysdep=5Froutines +=3D divdi3
shared-only-routines +=3D divdi3
endif
endif

ifeq ($(subdir),db2)
CPPFLAGS +=3D -DHAVE=5FSPINLOCKS=3D1 -DHAVE=5FASSEM=5FX86=5FGCC=3D1
endif

ifeq ($(subdir),gmon)
sysdep=5Froutines +=3D i386-mcount
endif

ifeq ($(subdir),elf)
CFLAGS-rtld.c +=3D -Wno-uninitialized -Wno-unused
CFLAGS-dl-load.c +=3D -Wno-unused
CFLAGS-dl-reloc.c +=3D -Wno-unused
endif

--0-286436026-1030721039=:14968--
