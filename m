Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278428AbRKVMnb>; Thu, 22 Nov 2001 07:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278584AbRKVMnV>; Thu, 22 Nov 2001 07:43:21 -0500
Received: from mx02.uni-tuebingen.de ([134.2.3.12]:21264 "EHLO
	mx02.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S278428AbRKVMnE>; Thu, 22 Nov 2001 07:43:04 -0500
Date: Thu, 22 Nov 2001 13:43:03 +0100 (CET)
From: Richard Guenther <rguenth@tat.physik.uni-tuebingen.de>
To: Heinz-Ado Arnolds <Ado.Arnolds@dhm-systems.de>
cc: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: fs/exec.c and binfmt-xxx in 2.4.14
In-Reply-To: <3BFCE5BB.AD59B011@web-systems.net>
Message-ID: <Pine.LNX.4.33.0111221341110.1479-100000@bellatrix.tat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2001, Heinz-Ado Arnolds wrote:

> Andreas Ferber wrote:
> >
> > On Wed, Nov 21, 2001 at 05:58:26PM +0100, Heinz-Ado Arnolds wrote:
> > >
> > > When i now try to start an older binary in a.out format, which has a
> > > magic number of 0x010b0064, it is translated with the 'new' code to a
> > > request for "binfmt-0064" instead of "binfmt-267" as expected and
> > > properly handled by modprobe.
> >
> > Then add
> >
> > alias binfmt-0064 binfmt_aout
> >
> > to /etc/modules.conf. Simple, isn't it?
>
> That's a nice idea but I wouldn't rely on the fact that the third
> and the fourth byte of a file are sufficient to identify the type.
> If you look at the magic numbers in /etc/magic, you'll find:
>
>   0x00640107      Linux/i386 impure executable (OMAGIC)
>   0x00640108      Linux/i386 pure executable (NMAGIC)
>   0x0064010b      Linux/i386 demand-paged executable (ZMAGIC)
>   0x006400cc      Linux/i386 demand-paged executable (QMAGIC)
>   =0514           80386 COFF executable
>
> It's standard to count on the first (and eventually following) bytes.
>
> And if you look further on in /etc/magic, you'll see that there are
> other file types having 0x0064 as 3rd and 4th byte.

Note that the 3rd and 4th byte are not used to identify a binary
format, but just to auto-load a possibly available module that can
possibly handle that format. So it doesnt really matter if there are
multiple filetypes causing the load of the same binary handler module.

Richard.

--
Richard Guenther <richard.guenther@uni-tuebingen.de>
WWW: http://www.tat.physik.uni-tuebingen.de/~rguenth/
The GLAME Project: http://www.glame.de/

