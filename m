Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285316AbRL2TZj>; Sat, 29 Dec 2001 14:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285329AbRL2TZ3>; Sat, 29 Dec 2001 14:25:29 -0500
Received: from paloma17.e0k.nbg-hannover.de ([62.181.130.17]:52406 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S285316AbRL2TZL>; Sat, 29 Dec 2001 14:25:11 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Harald Holzer <harald.holzer@eunet.at>
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
Date: Sat, 29 Dec 2001 20:25:15 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011229192521Z285316-18285+6271@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 29. December 2001 18:45, Alan cox wrote:
> > Are there some i686 SMP systems with more then 12 GB ram out there ?
>
> Very very few.
>
> > Is there a known problem with 2.4.x kernel and such systems ?
>
> Several 8)
>
> Hardware limits:
>         -       36bit addressing mode on x86 processors is slower
>         -       Many device drivers cant handle > 32bit DMA
>         -       The CPU can't efficiently map all that memory at once
>
> Software:
>         -       The block I/O layer doesn't cleanly handle large systems
>         -       The page struct is too big which puts undo loads on the
>                 memory that the CPU can map
>         -       We don't discard page tables when we can and should
>         -       We should probably switch to a larger virtual page size
>                 on big machines.
>
> The ones that actually bite hard are the block I/O layer and the page
> struct size. Making the block layer handle its part well is a 2.5 thing.
>
> > It looks like as the buffer_heads would fill the low memory up,
> > whether there is sufficient memory available or not, as long as
> > there is sufficient high memory for caching.
>
> That may well be happening. The Red Hat supplied 7.2 and 7.2 errata kernels
> were tested on 8Gb, I don't know what else larger.
>
> Because much of the memory cannot be used for kernel objects there is an
> imbalance in available resources and its very hard to balance them sanely.
> I'm not sure how many 8Gb+ machines Andrea has handy to tune the VM on
> either.

I think Andrea has access to some. Maybe SAP?

Have you tried with 2.4.17rc2aa2?
ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.17rc2aa2.bz2

The 10_vm-21 part applies clean to 2.4.17 (final), too.
I have it running without a glitch. But sadly a way smaller (much smaller) 
system...;-)

Regards,
	Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
