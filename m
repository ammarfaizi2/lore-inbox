Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274064AbRJYNox>; Thu, 25 Oct 2001 09:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274162AbRJYNop>; Thu, 25 Oct 2001 09:44:45 -0400
Received: from krynn.axis.se ([193.13.178.10]:57831 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S274055AbRJYNoc> convert rfc822-to-8bit;
	Thu, 25 Oct 2001 09:44:32 -0400
Message-ID: <B6B64A8D263A4945BB5DCF3F9F400EB495455E@mailse02.axis.se>
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: =?iso-8859-1?Q?=27Peter_W=E4chtler=27?= <pwaechtler@loewe-komp.de>,
        =?iso-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] strtok --> strsep in framebuffer drivers (part 2)
Date: Thu, 25 Oct 2001 15:44:40 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Peter Wächtler [mailto:pwaechtler@loewe-komp.de]
> Sent: 25 October 2001 15:36
> To: René Scharfe
> Cc: Linus Torvalds; Linux Kernel Mailing List
> Subject: Re: [PATCH] strtok --> strsep in framebuffer drivers (part 2)
> 
> René Scharfe wrote:
> > 
> > Hello,
> > 
> > I just noticed two framebuffer drivers with strtok calls 
> > that somehow passed below my radar (cscope). Patch below
> > converts them, too. And it re-adds "ignore empty tokens"
> > functionalty, which I forgot about the last time. Please apply.
> > 
> > René

[snip]

> > diff -Nur ../linux-2.4.13-pre6/drivers/video/riva/fbdev.c 
> ./drivers/video/riva/fbdev.c
> > --- ../linux-2.4.13-pre6/drivers/video/riva/fbdev.c     Tue 
> Oct 23 22:13:43 2001
> > +++ ./drivers/video/riva/fbdev.c        Tue Oct 23 23:31:33 2001
> > @@ -2046,6 +2046,8 @@
> >                 return 0;
> > 
> >         while (this_opt = strsep(&options, ",")) {
> > +               if (!*this_opt)
> > +                       continue;
> 
> NAME
>        strsep - extract token from string
> [...]
> RETURN VALUE
>        The strsep() function returns a pointer to the  token,  or
>        NULL if delim is not found in stringp.
> 
> If strsep returns NULL, and you dereference it -> Oops.
> 
> 
> ! if (!this_opt)
> 	continue;

If strsep() returns NULL, then the while-loop will terminate.
Thus this is already taken care of.

//Peter
