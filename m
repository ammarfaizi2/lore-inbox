Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314727AbSEHQuV>; Wed, 8 May 2002 12:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314723AbSEHQuT>; Wed, 8 May 2002 12:50:19 -0400
Received: from c16757.eburwd2.vic.optusnet.com.au ([210.49.184.123]:61700 "EHLO
	gateway.alien.intranet") by vger.kernel.org with ESMTP
	id <S314705AbSEHQuD>; Wed, 8 May 2002 12:50:03 -0400
From: "Simon Butcher" <pickle@alien.net.au>
To: "Serguei I. Ivantsov" <admin@gsc-game.kiev.ua>,
        "Der Herr Hofrat" <der.herr@mail.hofr.at>
Cc: <linux-gcc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Measure time
Date: Thu, 9 May 2002 02:51:42 +1000
Message-ID: <NCBBLGAKEDCMNBGMONMPMEEHCKAA.pickle@alien.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <004401c1f6a7$98f06ff0$e310f43e@manowar>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

ftime() will return milliseconds, but it's considered an obsolete function.
You could use gettimeofday() (as Richard Johnson suggested) to get
microseconds and divide them to get milliseconds, although I don't know how
time critical your routines are.

If you're still looking for nanoseconds, I'm told you can use
clock_gettime() but it's still quite unavailable (I've never seen it myself,
yet).. however even if it was available you possibly wouldn't get a very
high resolution from it with current systems..

 - Simon

> -----Original Message-----
> From: linux-gcc-owner@vger.kernel.org
> [mailto:linux-gcc-owner@vger.kernel.org]On Behalf Of Serguei I. Ivantsov
> Sent: Thursday, 9 May 2002 01:47
> To: Der Herr Hofrat
> Cc: linux-gcc@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: Measure time
>
>
> Is there any function like GetTickCount() in M$ Win32 that
> retrieves time in
> milliseconds?
>
> --
>  Regards,
>   Serguei I. Ivantsov
>
> ----- Original Message -----
> From: "Der Herr Hofrat" <der.herr@mail.hofr.at>
> To: "Serguei I. Ivantsov" <administrator@svitonline.com>
> Cc: <linux-gcc@vger.kernel.org>; <linux-kernel@vger.kernel.org>
> Sent: Wednesday, May 08, 2002 3:00 PM
> Subject: Re: Measure time
>
>
> > > Hello!
> > >
> > > Is there any function for high precision time measuring.
> > > time() returns only in second. I need nanoseconds.
> > >
> > you can directly read the TSC but that will not realy give you
> nanoseconds
> > resolution as the actual read access even on a PIII/1GHz is
> going to take
> > up to a few 100 nanoseconds, and depending on what you want to time
> > stamp the overall jitter of that code can easaly be in the
> > range of a microsecond.
> >
> > There are some hard-realtime patches to the Linux kernel that will
> > allow time precission of aprox. 1us (the TSC has a precission of 32ns)
> > but I don't think you can get below that without dedicated hardware.
> >
> > for RTLinux check at ftp://ftp.rtlinux.org/pub/rtlinux/
> >
> > hofrat
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-gcc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

