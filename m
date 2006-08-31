Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751624AbWHaMdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbWHaMdW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 08:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWHaMdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 08:33:21 -0400
Received: from cs.columbia.edu ([128.59.16.20]:50670 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id S1751390AbWHaMdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 08:33:20 -0400
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the
	block	layer [try #2]
From: Shaya Potter <spotter@cs.columbia.edu>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Matthew Wilcox <matthew@wil.cx>, John Stoffel <john@stoffel.org>,
       Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
In-Reply-To: <44F6A385.9090508@s5r6.in-berlin.de>
References: <20060829115138.GA32714@infradead.org>
	 <20060825142753.GK10659@infradead.org>
	 <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com>
	 <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com>
	 <10117.1156522985@warthog.cambridge.redhat.com>
	 <15945.1156854198@warthog.cambridge.redhat.com>
	 <20060829122501.GA7814@infradead.org> <20060829195845.GA13357@kroah.com>
	 <17652.44254.620358.974993@stoffel.org>
	 <20060831030134.GA4919@parisc-linux.org>
	 <1156993496.4381.3.camel@localhost.localdomain>
	 <44F6A385.9090508@s5r6.in-berlin.de>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 08:32:00 -0400
Message-Id: <1157027520.4381.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92 
Content-Transfer-Encoding: 7bit
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, X-Seen-By filter2.cs.columbia.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 10:53 +0200, Stefan Richter wrote:
> Shaya Potter wrote:
> > On Wed, 2006-08-30 at 21:01 -0600, Matthew Wilcox wrote:
> >> On Tue, Aug 29, 2006 at 05:08:46PM -0400, John Stoffel wrote:
> >> > Maybe the better solution is to remove SCSI as an option, and to just
> >> > offer SCSI drivers and USB-STORAGE and other SCSI core using drivers
> [...]
> >> People don't want to have to say "no" to umpteen scsi drivers.  They
> >> just want to say "no" to SCSI, because they know they don't have scsi.
> > 
> > so then that's shows a problem with the kconfig syntax.
> > 
> > CONFIG_SCSI should perhaps be hidden, and what's visible to the user is
> > CONFIG_SCSI_DRIVER
> [...]
> 
> But drivers like usb-storage and sbp2 are SCSI drivers too. What you
> mean is CONFIG_SCSI_DRIVERS_WHICH_APPEAR_IN_THE_SCSI_MENU.

when I said "driver" I meant more along the line of SCSI hardware
instead of things that use the "Linux" scsi subsystem.  i.e. usb, sata
are not scsi hardware even though they use the scsi subsystem.

Or to put it another way, perhaps no "select"able option should ever be
visibly selectable in XYZconfig.  And XYZconfig should only show an
option that is "select"able if by selecting it one ends up with a
consistent configuration.

So you have a "virtual" SCSI_SUBSYSTEM which usb-storage, sbp2, sata all
pull in by selecting it.

you have SCSI_HARDWARE that adaptec, buslogic, lsilogic...... depend on.
SCSI_HARDWARE would also select "SCSI_SUBSYSTEM".

