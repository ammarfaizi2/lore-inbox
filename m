Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136449AbREDQ6T>; Fri, 4 May 2001 12:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136455AbREDQ6J>; Fri, 4 May 2001 12:58:09 -0400
Received: from femail2.sdc1.sfba.home.com ([24.0.95.82]:43996 "EHLO
	femail2.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S136449AbREDQ6F>; Fri, 4 May 2001 12:58:05 -0400
Message-ID: <3AF2DF96.5CEAEAE8@home.com>
Date: Fri, 04 May 2001 09:57:58 -0700
From: Seth Goldberg <bergsoft@home.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: Gordon Sadler <gbsadler1@lcisp.com>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: Athlon/VIA Kernel Experimentation (mmx.c)
In-Reply-To: <20010503150346.A18141@debian-home.lcisp.com> <3AF27C39.9BD7EC99@home.com> <3AF2ACD6.AB9D4D91@didntduck.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Doh. I feel like a moron.  Thanks.. will do...

 --S


Brian Gerst wrote:
> 
> Seth Goldberg wrote:
> >
> > Hi,
> >
> >   I implemented a small check loop at the end of the fast_page_copy
> > routine in mmx.c for the Athlon.  Booting the resulting kernel
> > yields an interesting result. Every single time, the kernel
> > panics RIGHT AFTER it frees unused kernel memory from bootup.
> > I encourage those of you with the same problem to try this and report
> > when it panics.
> >
> > Here is my patch to mmx.c: (sorry about the long lines)
> > -----------------------------------------------------cut here
> > diff -r linux-ref/arch/i386/lib/mmx.c linux/arch/i386/lib/mmx.c
> > 204a205,216
> > >
> > >       {
> > >               register int x = 0;
> > >               /* do mem compares to ensure written == read */
> > >               for ( /* initted above */; x < (4096/sizeof(int)); x++ )
> > >               {
> > >                       if ( ((int *)to)[x] != ((int *)from)[x] ) {
> > >                               panic("fast_page_copy: dest value @ 0x%lx (%x) does not equal source value @ %lx (%x)!\n",
> > >                                               (long) to, ((int *)to)[x], (long) from, ((int *) from)[x] );
> > >                       }
> > >               }
> > >       }
> > -----------------------------------------------------cut here
> >
> >   Wouldn't it be correct to say that because it is panicking, the
> > page copy was not completed properly?
> 
> No, you are comparing the following two pages... from and to are
> incremented as the copy proceeds.  Subtract PAGE_SIZE from them before
> comparing.
> 
> --
> 
>                                 Brian Gerst
