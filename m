Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314099AbSDQOtq>; Wed, 17 Apr 2002 10:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314100AbSDQOtp>; Wed, 17 Apr 2002 10:49:45 -0400
Received: from otter.mbay.net ([206.55.237.2]:38410 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S314099AbSDQOtn>;
	Wed, 17 Apr 2002 10:49:43 -0400
Date: Wed, 17 Apr 2002 07:49:22 -0700 (PDT)
From: John Alvord <jalvo@mbay.net>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
cc: Nikita@Namesys.COM, Andrey Ulanov <drey@rt.mipt.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: FPU, i386
In-Reply-To: <200204171440.JAA76065@tomcat.admin.navo.hpc.mil>
Message-ID: <Pine.LNX.4.20.0204170747550.21678-100000@otter.mbay.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2002, Jesse Pollard wrote:

> ---------  Received message begins Here  ---------
> 
> > 
> > Andrey Ulanov writes:
> >  > Look at this:
> >  > 
> >  > $ cat test.c
> >  > #include <stdio.h>
> >  > 
> >  > main()
> >  > {
> >  > 	double h = 0.2;
> >  > 	
> >  > 	if(1/h == 5.0)
> >  > 	    printf("1/h == 5.0\n");
> >  > 
> >  > 	if(1/h < 5.0)
> >  > 	    printf("1/h < 5.0\n");
> >  > 	return 0;
> >  > }
> >  > $ gcc test.c
> > 
> > $ gcc -O test.c
> > $ ./a.out
> > 1/h == 5.0
> > 
> > without -O, gcc initializes h to 0.2000000000000000111
> > 
> >  > $ ./a.out
> >  > 1/h < 5.0
> >  > $ 
> >  > 
> >  > I also ran same a.out under FreeBSD. It says "1/h == 5.0".
> >  > It seems there is difference somewhere in FPU 
> >  > initialization code. And I think it should be fixed.
> 
> Nope. -O2 implies constant folding, and h is a constant. What you are
> compairing is runtime vs compile time values. 5.0 is compile time.
> 1/h where h is a constant is compile time (O2) and that would
> come out at 5.0 also
> 
> Been there done that... My solution (based on the problem I was working
> in) was to multiply both sides by the 10^<number of siginificant digits
> of the problem set>. Taking the simplistic approach:
> 
> if (int(1/h * 100) == int(5.0 * 100))
> 
> will give a "proper" result within two decimal places. This is still
> limited since there are irrational numbers within that range that COULD
> still come out with a wrong answer, but is much less likely to occur.
> 
> Exact match of floating point is not possible - 1/h is eleveated to a float.
> 
> If your 1/h was actually num/h, and num computed by summing .01 100 times
> I suspect the result would also be "wrong".

In most portable floating point work, you never use ==. Instead, the
difference is compared to a small epsilon value and division is avoided by
scaling.

john alvord

