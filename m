Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbQJ3NUY>; Mon, 30 Oct 2000 08:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129074AbQJ3NUO>; Mon, 30 Oct 2000 08:20:14 -0500
Received: from devserv.devel.redhat.com ([207.175.42.156]:31753 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129055AbQJ3NUD>; Mon, 30 Oct 2000 08:20:03 -0500
Date: Mon, 30 Oct 2000 08:19:39 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test10-pre6: Use of abs()
Message-ID: <20001030081938.K6207@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <200010281629.e9SGTah07672@sleipnir.valparaiso.cl> <39FD7F2C.9A3F3976@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <39FD7F2C.9A3F3976@evision-ventures.com>; from dalecki@evision-ventures.com on Mon, Oct 30, 2000 at 03:01:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 03:01:16PM +0100, Martin Dalecki wrote:
> Horst von Brand wrote:
> > 
> > Red Hat 7.0, i686, gcc-20001027 (Yes, I know. Just to flush out bugs on
> > both sides).
> > 
> > abs() is used at least in:
> > 
> > arch/i386/kernel/time.c
> > drivers/md/raid1.c
> > drivers/sound/sb_ess.c
> > 
> > gcc warns about use of a non-declared function each time.
> > 
> > No definition for the function is to be found (grep over all include/ comes
> > up clean, except for extern definitions in asm-{mips,ppc}; ditto for lib/).
> > Presumably gcc is using a builtin (it doesn't show up in System.map). Is
> > this the desired state of affairs? Should a include/linux/stdlib.h be
> 
> Yes abs will be transformed into an internal function, which will be
> fully
> unrolled due to -O2.

No matter what it should be prototyped in some header. And all uses should
be checked, because abs is 
int abs (int) __attribute__ ((__const__));
and sometimes people use it on `long' instead (such a bug has been fixed in
the kernel some months ago).

	Jakub
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
