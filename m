Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263357AbRFFOtk>; Wed, 6 Jun 2001 10:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263393AbRFFOta>; Wed, 6 Jun 2001 10:49:30 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:30361 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263357AbRFFOtS>;
	Wed, 6 Jun 2001 10:49:18 -0400
Message-ID: <3B1E42EA.B0AE7F6E@mandrakesoft.com>
Date: Wed, 06 Jun 2001 10:49:14 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Tom Vier <tmv5@home.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        rth@twiddle.net
Subject: Re: [patch] Re: Linux 2.4.5-ac6
In-Reply-To: <Pine.GSO.3.96.1010606115046.23232A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" wrote:
> 
> On Wed, 6 Jun 2001, Ivan Kokshaysky wrote:
> 
> > > No need to patch arch_get_unmapped_area(), but OSF/1 compatibility code
> > > might need fixing.  I suppose an OSF/1 binary must have an appropriate
> > > flag set in its header after building with the -taso option so that the
> > > system knows the binary wants 32-bit addressing.
> >
> > I'm not sure if COFF headers have such flag at all. I'll check this.
> 
>  Then how does OSF/1, especially the dynamic linker, know if a binary
> needs 32-bit addressing?  I suppose we could use the same way of
> selection.

There are two things you can do here, one is easy:  use linker tricks to
make sure that an application built on alpha -- with 64-bit pointers --
uses no more than the lower 32 bits of each pointer for addressing. 
This should fix a ton of applications which cast pointer values to ints
and similar garbage.

The other option, hacking gcc to output "32-bit alpha" binary code, is a
tougher job.

I had mentioned this to Richard Henderson a while back, when I was
wondering how easy it is to implement -taso under Linux, and IIRC he
seemed to think that linker tricks were much easier.

	Jeff


-- 
Jeff Garzik      | An expert is one who knows more and more about
Building 1024    | less and less until he knows absolutely everything
MandrakeSoft     | about nothing.
