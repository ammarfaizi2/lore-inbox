Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422695AbWAMOX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422695AbWAMOX7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 09:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422696AbWAMOX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 09:23:59 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:55471 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422695AbWAMOX7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 09:23:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MXYXBbhwYU2cJgxW32rKvU79gGtl0ud6DFjSFiKCSjy4zB0Ikag4l9VWYKsQI7YfPrYfWuvobmy/bOWSu0FlGXI3ITizf6GXoObsf2SRSa3hk4ZZlIM1EnhcKbneLNoW6Lvoo5gDOaL9otrvfTGDQ6r6IffVvdGRijhw+4hSU04=
Message-ID: <58cb370e0601130616l25e0e25ai6b7d2025d9774eff@mail.gmail.com>
Date: Fri, 13 Jan 2006 15:16:51 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Rashkae <rashkae@tigershaunt.com>
Subject: Re: ide-cd turning off DMA when verifying DVD-R
Cc: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>,
       Ondrej Zary <linux@rainbow-software.org>,
       Robert Hancock <hancockr@shaw.ca>,
       Volker Kuhlmann <list0570@paradise.net.nz>, Jens Axboe <axboe@suse.de>,
       linux-ide <linux-ide@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060113140618.GB12360@tigershaunt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <5ujmU-1UQ-665@gated-at.bofh.it> <5uoqr-Qq-7@gated-at.bofh.it>
	 <43C72F41.5060207@shaw.ca> <20060113083009.GE12338@paradise.net.nz>
	 <58cb370e0601130119g5c62b749r1bc5da59a0d4a56c@mail.gmail.com>
	 <20060113140618.GB12360@tigershaunt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/06, Rashkae <rashkae@tigershaunt.com> wrote:
> On Fri, Jan 13, 2006 at 10:19:17AM +0100, Bartlomiej Zolnierkiewicz wrote:
>
>
> > On 1/13/06, Volker Kuhlmann <list0570@paradise.net.nz> wrote:
> > > On Fri 13 Jan 2006 17:40:33 NZDT +1300, Robert Hancock wrote:
> > >
> > > > I'm thinking the IDE code is too aggressive in assuming that the failure
> > > >  is because of a DMA problem and disabling it.. Most likely all that's
> > > > happening is the drive is taking a long time to complete the current
> > > > command.
> >
> > What actually happened is that normal command timed out
> > and because of that driver reset the device which caused
> > it to loose DMA:
> >
> > ->ide_atapi_error()
> >     ->ide_do_reset()
> >       ->pre_reset()
> >         ->check_dma_crc()
> >           ->__ide_dma_off()
> >
> > Somebody needs to investigate why __ide_dma_off() is called
> > et all and if we need to restore DMA after reset (don't count ATM
> > on me, I'm buried by bugreports).  Ondrej, could you fill the bug at
> > http://bugzilla.kernel.org so we don't lose it?
>
> Shouldn't whether DMA is restored after reset be governed by keepsettings flag?

settings should always be preserved and keepsettings flag should die

> From the hdparm man page:
>
>       -k     Get/set  the  keep_settings_over_reset flag for the
>               drive.  When this flag is set, the driver will pre­
>               serve  the -dmu options over a soft reset, (as done
>               during the error  recovery  sequence).
>
> I was a little disapointed that this didn't work as advertised.

AFAIR (2.5/2.6 and probably 2.4 also) it never worked w.r.t. to DMA
as documented in hdparm manual.

Bartlomiej
