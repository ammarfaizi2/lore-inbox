Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265982AbSKKJZa>; Mon, 11 Nov 2002 04:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265983AbSKKJZ3>; Mon, 11 Nov 2002 04:25:29 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:10650 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S265982AbSKKJZ2>;
	Mon, 11 Nov 2002 04:25:28 -0500
Date: Mon, 11 Nov 2002 10:31:23 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>
cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NCR53C9x ESP: C99 designated initializers
In-Reply-To: <1036939080.1005.10.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0211111029030.20946-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Nov 2002, Alan Cox wrote:
> On Sun, 2002-11-10 at 10:27, Geert Uytterhoeven wrote:
> ut soft reset.
> >   */
> > -int esp_reset(Scsi_Cmnd *SCptr, unsigned int how)
> > +int esp_reset(Scsi_Cmnd *SCptr)
> >  {
> >  	struct NCR_ESP *esp = (struct NCR_ESP *) SCptr->host->hostdata;
> >  
> >  	(void) esp_do_resetbus(esp, esp->eregs);
> > -	return SCSI_RESET_PENDING;
> > +	wait_event(esp->reset_queue, (esp->resetting_bus == 0));
> > +
> > +	return SUCCESS;
> >  }
> 
> Reset is called with the lock held surely. How can the wait_event be
> right ? 

I don't know. I just ported the Sun/SPARC ESP SCSI driver changes in 2.5.45 to
the NCR53C9x ESP SCSI drivers. If you're right, the same bug is present in
esp.c.

Dave?

BTW, what about merging esp.c and NCR53C9x.c?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

