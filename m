Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbTBER2n>; Wed, 5 Feb 2003 12:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbTBER2m>; Wed, 5 Feb 2003 12:28:42 -0500
Received: from mail.ithnet.com ([217.64.64.8]:33292 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S262418AbTBER2k>;
	Wed, 5 Feb 2003 12:28:40 -0500
Date: Wed, 5 Feb 2003 18:38:08 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: rossb@google.com, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
Message-Id: <20030205183808.3a2fa115.skraw@ithnet.com>
In-Reply-To: <1044466495.684.153.camel@zion.wanadoo.fr>
References: <20030202161837.010bed14.skraw@ithnet.com>
	<3E3D4C08.2030300@pobox.com>
	<20030202185205.261a45ce.skraw@ithnet.com>
	<3E3D6367.9090907@pobox.com>
	<20030205104845.17a0553c.skraw@ithnet.com>
	<1044443761.685.44.camel@zion.wanadoo.fr>
	<3E414243.4090303@google.com>
	<1044465151.685.149.camel@zion.wanadoo.fr>
	<3E4147A0.4050709@google.com>
	<1044466495.684.153.camel@zion.wanadoo.fr>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 Feb 2003 18:34:55 +0100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2003-02-05 at 18:19, Ross Biro wrote:
> > Benjamin Herrenschmidt wrote:
> > 
> > >While I agree with you here, I don't think it's what's happening.
> > >	/* clear INTR & ERROR flags */
> > >	hwif->OUTB(dma_stat|6, hwif->dma_status);
> > >
> > >  
> > >
> > You have way to much faith in the hardware.  Promise is especially known 
> > for not keeping to the spec.  I wouldn't trust the interrupt bit to be 
> > valid unless a dma is actually active, i.e. that
> > 
> >                   hwif->OUTB(hwif->INB(dma_base)|1, dma_base);
> > 
> > has actually been written.  
> > 
> > I've actually had a manufacturer tell me that they don't worry about the 
> > spec, just making things work with Windows.
> 
> Ok, so that gives us 2 possibilities. The above problem, which would be
> fixed by locking all around ide_dma_read/write (or rather in the
> _caller_, seems better so we don't have to drop the lock for ATAPI).
> 
> And a possible wraparound of waiting_for_dma if 255 IRQs come in from
> whatever device we share the IRQ line with.
> 
> I beleive both need fixing...
> 
> Ben.

Ok, yet another small brick in the wall: this mb has 64bit/66MHz PCI slots. PDC
is only 32bit/33MHz PCI. So it may well be that others are in fact _able_ to
produce a damn lot more data/interrupts than the PDC. I am pretty astonished by
the number of interrupts created by the 3com tg3 cards anyways...

-- 
Regards,
Stephan
