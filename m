Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269354AbRHQBWc>; Thu, 16 Aug 2001 21:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269356AbRHQBWW>; Thu, 16 Aug 2001 21:22:22 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:31171 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S269354AbRHQBWM>; Thu, 16 Aug 2001 21:22:12 -0400
Message-Id: <5.1.0.14.2.20010817015007.045689b0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 17 Aug 2001 02:22:10 +0100
To: Jeff Dike <jdike@karaya.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: 2.4.9 does not compile [PATCH] 
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        phillips@bonn-fries.net (Daniel Phillips),
        davem@redhat.com (David S. Miller), tpepper@vato.org,
        f5ibh@db0bm.ampr.org, linux-kernel@vger.kernel.org
In-Reply-To: <200108170146.UAA05171@ccure.karaya.com>
In-Reply-To: <Your message of "Fri, 17 Aug 2001 00:35:02 +0100." <5.1.0.14.2.20010817002825.00b1e4e0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the reply, but...

At 02:46 17/08/2001, Jeff Dike wrote:
>aia21@cam.ac.uk said:
> > Really? Could you point out an example where using ... typeof(x) __x;
> > typeof(y) __y; ... in the macros wouldn't work? - I just tried a few
> > examples I thought wouldn't work (side-effects ones) but I was
> > pleasantly  surprised to that gcc always produced the exact same
> > assembler output for  both the 3 arg and the 2 arg + typeof macros.
>
>Try min(a, min(b, c)).  Look at the cpp expansion and notice all the variable
>name clashes.

There are no clashes; unless my knowledge of C has abandoned me at the 
moment, you can reuse variable names within local statement blocks and the 
compiler is intelligent enough to sort it out.

I tried egcs-1.1.2/gcc-2.91.66, gcc 2.95.3 (SuSE 7.1) and gcc 2.96 (RHL 7.1 
2.96-85) and the generated assembler is fully correct with all these 
compilers for follwing little test (I compiled it with the same gcc command 
line as the kernel uses for the ntfs source files):

--- cut ---
#define min(x,y) \
         ({ typeof(x) __x = (x); typeof(y) __y = (y); __x < __y ? __x : __y; })

int test(int a, int b, int c)
{
         return min(a, min(b, c));
}
--- cut ---

No warnings are emitted and the assembler is correct if I am not mistaken.

Is my test invalid? I guess I must be missing something, but I can't figure 
out what. )-: Perhaps sleeping over it might help...

>We went through this on #kernel one night, and Alan concocted some amazingly
>gross unique identifier generators as a result.  To me, this looks like the
>best way to do this.

Shame I missed that... </me really ignorant> which IRC network is this 
channel on? Doesn't seem to be on openprojects.net...

Best regards,

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

