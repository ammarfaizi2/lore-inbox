Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQJ3PVM>; Mon, 30 Oct 2000 10:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129073AbQJ3PVC>; Mon, 30 Oct 2000 10:21:02 -0500
Received: from [195.63.194.11] ([195.63.194.11]:44047 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S129045AbQJ3PUr>; Mon, 30 Oct 2000 10:20:47 -0500
Message-ID: <39FD9E6A.AD10E699@evision-ventures.com>
Date: Mon, 30 Oct 2000 17:14:34 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jakub Jelinek <jakub@redhat.com>
CC: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test10-pre6: Use of abs()
In-Reply-To: <200010281629.e9SGTah07672@sleipnir.valparaiso.cl> <39FD7F2C.9A3F3976@evision-ventures.com> <20001030081938.K6207@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek wrote:
> 
> On Mon, Oct 30, 2000 at 03:01:16PM +0100, Martin Dalecki wrote:
> > Horst von Brand wrote:
> > >
> > > Red Hat 7.0, i686, gcc-20001027 (Yes, I know. Just to flush out bugs on
> > > both sides).
> > >
> > > abs() is used at least in:
> > >
> > > arch/i386/kernel/time.c
> > > drivers/md/raid1.c
> > > drivers/sound/sb_ess.c
> > >
> > > gcc warns about use of a non-declared function each time.
> > >
> > > No definition for the function is to be found (grep over all include/ comes
> > > up clean, except for extern definitions in asm-{mips,ppc}; ditto for lib/).
> > > Presumably gcc is using a builtin (it doesn't show up in System.map). Is
> > > this the desired state of affairs? Should a include/linux/stdlib.h be
> >
> > Yes abs will be transformed into an internal function, which will be
> > fully
> > unrolled due to -O2.
> 
> No matter what it should be prototyped in some header. And all uses should
> be checked, because abs is
> int abs (int) __attribute__ ((__const__));
> and sometimes people use it on `long' instead (such a bug has been fixed in
> the kernel some months ago).

Of corse right! BTW. There are tons of places where log2 is calculated
explicitly in kernel which should be replaced with the corresponding
built 
in functions as well (/dev/random code does it). And then If I remember
correctly
there is an attribute which is telling about internal functions
in declarations explicitly as well?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
