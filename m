Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVCaM6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVCaM6u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 07:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVCaM6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 07:58:50 -0500
Received: from 134.106-14-84.ripe.coltfrance.com ([84.14.106.134]:50652 "EHLO
	office.mandrakesoft.com") by vger.kernel.org with ESMTP
	id S261417AbVCaM6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 07:58:47 -0500
To: James Bottomley <jejb@steeleye.com>
Cc: Christoph Hellwig <hch@infradead.org>, Bruno Cornec <Bruno.Cornec@hp.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: megaraid driver (proposed patch)
X-URL: <http://www.linux-mandrake.com/
References: <20050325182252.GA4268@morley.grenoble.hp.com>
	<1111775992.5692.25.camel@mulgrave>
	<20050325184718.GA15215@infradead.org>
	<1111777477.5692.29.camel@mulgrave>
From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Organization: Mandrakesoft
Date: Thu, 31 Mar 2005 14:58:42 +0200
In-Reply-To: <1111777477.5692.29.camel@mulgrave> (James Bottomley's message
 of "Fri, 25 Mar 2005 13:04:37 -0600")
Message-ID: <m2zmwk9dkt.fsf@vador.mandrakesoft.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <jejb@steeleye.com> writes:

> > > > Would you consider to apply the following patch proposed by
> > > > Thierry Vignaud as a solution for the MandrakeSoft kernel in
> > > > the mainstream 2.6 kernel ?
> > > 
> > > Well, to be considered you'd need to cc the megaraid maintainers
> > > and the linux-scsi mailing list.
> > > 
> > > > -if MEGARAID_NEWGEN=n
> > > 
> > > No, this is wrong it would break allyes configs and I'd get shot.
> > 
> > Why?  The megaraid drivers shouldn't have any conflicting
> > non-static symbols
> 
> You get a kernel with two drivers trying to claim some of the same
> set of cards.  The winner will be the driver that gets its init
> routines called first, but this isn't a desirable outcome.

well, this is not the first occurence:

- one can build both oss and alsa drivers which claimed quite the same
  ids set.
eg, one example from modules.pcimap:
snd-intel8x0         0x00001039 0x00007012 0xffffffff 0xffffffff 0x00000000 0x00000000 0x0
i810_audio           0x00001039 0x00007012 0xffffffff 0xffffffff 0x00000000 0x00000000 0x0

- at one point, atiixp and sata_sil used to overlap on one sata
  controller
- tg3 and bcm5700 totally overlap
- the same for e100 and eepro100, e1000 and eepro1000
- sata drivers ahci and ata_piix used to overlap too on a cople of
  devices
- b44 and bcm4400 totally overlap
- 8139too and 8139cp overlap
- i2c-ali15x3 and i2c-ali1535 overlap too
- qla6322 and qla6312 used to overlap in the past
- via-ircc and i2c-viapro overlaps
- dvb
- saa7134 and saa7134-dvb overlap
- sonypi and i2c-piix4 overlap
- cx88 and cx88-dvb overlap
- radio-gemtek-pci and radio-maxiradio overlap too
- ...

so this argument looks totally bogus for me since few of these drivers
prevent them being build in-core at both time b/c there're quite a lot
of other driver that will "break"  allyes configs

> I wouldn't object to a patch that allows both *modules* to be built,
> which is all I think the distros are after.

indeed. but the first patch should have been accpeted as this.

the in fact policy isn't currently to prevent overlapping drivers to
being compiled in-core at the same time, so i think we shouldn't
prevent it but convert all these drivers' build rules so that they
allow to be built as modules at the same time, but not in core at the
same time

