Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132973AbRDESu3>; Thu, 5 Apr 2001 14:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132972AbRDESuS>; Thu, 5 Apr 2001 14:50:18 -0400
Received: from hood.tvd.be ([195.162.196.21]:24377 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S132970AbRDESuD>;
	Thu, 5 Apr 2001 14:50:03 -0400
Date: Thu, 5 Apr 2001 20:48:29 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: st corruption with 2.4.3-pre4
In-Reply-To: <Pine.LNX.4.05.10103221947120.552-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.05.10104052040410.754-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2001, Geert Uytterhoeven wrote:
> On Tue, 20 Mar 2001, Gérard Roudier wrote:
> > On Tue, 20 Mar 2001, Geert Uytterhoeven wrote:
> > > On Tue, 20 Mar 2001, Geert Uytterhoeven wrote:
> > > > On Mon, 19 Mar 2001, Jeff Garzik wrote:
> > > I did some more tests:
> > >   - The problem also occurs when tarring up files from a disk on the Sym53c875.
> > >   - The corrupted data always occurs at offset 32*x (the `+1' above was caused
> > >     by hexdump, starting counting at 1).
> > >   - The 32 bytes of corrupted data at offset 32*x are always a copy of the data
> > >     at offset 32*x-10240.
> > >   - Since 10240 is the default blocksize of tar (bug in tar?), I made a tarball
> > >     on disk instead of on tape, but no corruption.
> > >   - 32 is the size of a cacheline on PPC. Is there a missing cacheflush
> > >     somewhere in the Sym53c875 driver? But then it should happen on disk as
> > >     well?
> 
> BTW, I tried my good old 2.4.0-test1-ac10 kernel from June 2000, and it also
> suffered from the same problem. Also note that I did read/write tests on the
> tape drive when I just bought it and when I installed the Sym53c875 later, and
> I never noticed the problem. So I'm still willing to believe it's a software
> bug in recent(?) kernels...

Status update:
  - When I connect my DDS1 to the MESH, I see no corruption (as long as I get
    no `lost arbitration' messages from the MESH driver. I never get those with
    the disk BTW. Anyone who knows what needs to be done to make the MESH
    driver recover from lost arbitration errors?). So the tape drive seems to
    be fine.
  - I wanted to try different tape drives, but all retired DDS drives I found
    at work seem to be in a non-functional state. I tried 3 of them, without
    any luck.
  - I wanted to try a 2.2.x kernel, but linuxppc_2_2 (2.2.19-pre3) just says
    `illegal instruction' and returns me to the OF prompt.
  - Adding more eieio/syncs to the sym53c8xx driver doesn't help. In fact there
    are already memory barriers where I'd expect them (as could be expected, of
    course :-)

[...]

OK, I managed to compile an old 2.2.13 kernel from the PPC bk repository that
boots more or less (no video) on my box.

Surprise! So far no corruption!! Time to let Amanda make some dumps tonight :-)

So something broke the st/sym53c8xx combination on my box between 2.2.13 and
2.4.0-test1-ac10...

I'm still waiting for other reports of st/sym53c8xx on PPC under 2.4.x. BTW,
does it work on other big-endian platforms, like sparc?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

