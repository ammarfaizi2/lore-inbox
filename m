Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268139AbRG3Vg1>; Mon, 30 Jul 2001 17:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268086AbRG3VgR>; Mon, 30 Jul 2001 17:36:17 -0400
Received: from nathan.polyware.nl ([193.67.144.241]:33540 "EHLO
	nathan.polyware.nl") by vger.kernel.org with ESMTP
	id <S268139AbRG3VgH>; Mon, 30 Jul 2001 17:36:07 -0400
Date: Mon, 30 Jul 2001 23:35:58 +0200
From: Pauline Middelink <middelink@polyware.nl>
To: LINUX-KERNEL@vger.kernel.org
Subject: Re: Reserving large amounts of RAM for busmastering PCI card.
Message-ID: <20010730233558.A19009@polyware.nl>
Mail-Followup-To: Pauline Middelink <middelin@polyware.nl>,
	LINUX-KERNEL@vger.kernel.org
In-Reply-To: <mailman.996053899.5490.linux-kernel2news@redhat.com> <200107252200.f6PM0IJ01020@devserv.devel.redhat.com> <3B5F428F.14DCAA44@mandrakesoft.com> <20010726082925.B2322@devserv.devel.redhat.com> <3B604612.F5FCC8E7@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B604612.F5FCC8E7@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Jul 26, 2001 at 12:32:18PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001 around 12:32:18 -0400, Jeff Garzik wrote:
> Pete Zaitcev wrote:
> > 
> > > > >  Since the 2.4 kernels introduce the e820map structure, I'd like to
> > > > >  plug into that infrastructure, and create a new type memory segment
> > > > >  for this storage (I envisage having more than one segment), but in the
> > > > >  2.4.4 kernel (which I am forced to remain with for quite a while) it
> > > > >  seems not to be used apart from set up at boot time.
> > > >
> > > > Stop reinventing the wheel and take Matt & Pauline's bigphisarea.
> > > >  http://www.polyware.nl/~middelink/patch/bigphysarea-2.4.4.tar.gz
> > >
> > > Is bigphysarea needed in 2.4?   You have alloc_bootmem...
> > 
> > I thought bigphisarea allowed to unload and reload modules,
> > at least I used it that way with C-cube MPEG board. Makes
> > for faster tests.
> 
> AFAICS this is only useful to developers, not end users, yes?
> 
> Memory will get fragmented if done at some time other than boot, so
> module loads will randomly fail based on conditions unrelated to the
> module at hand.  It's not a reliable operation, as a module...

No, bigphysarea takes it memory from bootmem not from kmalloc, and
gives it out to requesters of contingious memory.
When used with modules (like my zoran driver, it alloc at driver
open time and frees the memory at driver close time, giving the
user a second chance at nicely grabbed pictures :) )

    Met vriendelijke groet,
        Pauline Middelink
-- 
GPG Key fingerprint = 2D5B 87A7 DDA6 0378 5DEA  BD3B 9A50 B416 E2D0 C3C2
For more details look at my website http://www.polyware.nl/~middelink
