Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314093AbSDQOlP>; Wed, 17 Apr 2002 10:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314094AbSDQOlO>; Wed, 17 Apr 2002 10:41:14 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:54599 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S314093AbSDQOlO>; Wed, 17 Apr 2002 10:41:14 -0400
Date: Wed, 17 Apr 2002 09:40:48 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200204171440.JAA76065@tomcat.admin.navo.hpc.mil>
To: Nikita@Namesys.COM, Andrey Ulanov <drey@rt.mipt.ru>
Subject: Re: FPU, i386
Cc: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> Andrey Ulanov writes:
>  > Look at this:
>  > 
>  > $ cat test.c
>  > #include <stdio.h>
>  > 
>  > main()
>  > {
>  > 	double h = 0.2;
>  > 	
>  > 	if(1/h == 5.0)
>  > 	    printf("1/h == 5.0\n");
>  > 
>  > 	if(1/h < 5.0)
>  > 	    printf("1/h < 5.0\n");
>  > 	return 0;
>  > }
>  > $ gcc test.c
> 
> $ gcc -O test.c
> $ ./a.out
> 1/h == 5.0
> 
> without -O, gcc initializes h to 0.2000000000000000111
> 
>  > $ ./a.out
>  > 1/h < 5.0
>  > $ 
>  > 
>  > I also ran same a.out under FreeBSD. It says "1/h == 5.0".
>  > It seems there is difference somewhere in FPU 
>  > initialization code. And I think it should be fixed.

Nope. -O2 implies constant folding, and h is a constant. What you are
compairing is runtime vs compile time values. 5.0 is compile time.
1/h where h is a constant is compile time (O2) and that would
come out at 5.0 also

Been there done that... My solution (based on the problem I was working
in) was to multiply both sides by the 10^<number of siginificant digits
of the problem set>. Taking the simplistic approach:

if (int(1/h * 100) == int(5.0 * 100))

will give a "proper" result within two decimal places. This is still
limited since there are irrational numbers within that range that COULD
still come out with a wrong answer, but is much less likely to occur.

Exact match of floating point is not possible - 1/h is eleveated to a float.

If your 1/h was actually num/h, and num computed by summing .01 100 times
I suspect the result would also be "wrong".

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
