Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314241AbSDVQBz>; Mon, 22 Apr 2002 12:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314242AbSDVQBy>; Mon, 22 Apr 2002 12:01:54 -0400
Received: from [193.120.151.1] ([193.120.151.1]:62192 "EHLO mail.asitatech.com")
	by vger.kernel.org with ESMTP id <S314241AbSDVQBy>;
	Mon, 22 Apr 2002 12:01:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: DJ Barrow <dj.barrow@asitatech.com>
Organization: Asita Technologies
To: root@chaos.analogic.com,
        "Brian O'Sullivan" <brian.osullivan@asitatech.com>
Subject: Re: novice coding in /linux/net/ipv4/util.c From: DJ Barrow <dj.barrow@asitatech.com>
Date: Mon, 22 Apr 2002 17:03:50 +0100
X-Mailer: KMail [version 1.3.1]
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1020422113750.11343A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020422160154Z314241-22651+13871@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,
I agree The least offensive way would be to pass in a sring from the caller,
I didn't spot the second endian bug till you mentioned it ;-).

I wish Linus would finally get rid of the errno global as this is equally
stupid on smp machines or else make an errno_array[NR_CPUS] array
& make errno a #define errno errno_array[smp_processor_id()] or 
something similar, plenty of others have posted patches for that
rubbish.

Alan Cox is on the list of Authors, he must have wrote it ;-)

On Monday 22 April 2002 16:48, Richard B. Johnson wrote:
> On Mon, 22 Apr 2002, DJ Barrow wrote:
> > Hi ,
> > While debugging last night with Brian O'Sullivan I found this beauty.
> >
> > char *in_ntoa(__u32 in)
> > {
> >         static char buff[18];
> >         char *p;
> >
> >         p = (char *) &in;
> >         sprintf(buff, "%d.%d.%d.%d",
> >                 (p[0] & 255), (p[1] & 255), (p[2] & 255), (p[3] & 255));
> >         return(buff);
> > }
> >
> > This textbook peice of novice coding which has existed since 2.2.14.
> > For those who can't spot the error, please note that this function is
> > returning a static string, excellent stuff if you are hoping to reuse the
> > same function like the following
> > printk("%s %s\n",in_ntoa(addr1),in_ntoa(addr2));
> > -
>
> I love it! Last guy wins! I wonder how you fix it without having to
> pass it a pointer to something the caller owns?  This is, truly,
> non-trivial. Also, this is in ../linux/net, not something specific
> to Intel, and there is no macro to handle the network-order. It
> just 'comes-out-right' with Intel machines.
>
> Cheers,
> Dick Johnson
>
> Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
>
>                  Windows-2000/Professional isn't.