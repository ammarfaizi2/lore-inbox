Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261582AbSJQBnh>; Wed, 16 Oct 2002 21:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261619AbSJQBnh>; Wed, 16 Oct 2002 21:43:37 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:59107 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261582AbSJQBng>; Wed, 16 Oct 2002 21:43:36 -0400
Date: Wed, 16 Oct 2002 21:49:34 -0400
From: Doug Ledford <dledford@redhat.com>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.5.43 oops in adaptec driver
Message-ID: <20021017014934.GM8159@redhat.com>
Mail-Followup-To: Matthew Wilcox <willy@debian.org>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
References: <20021016184122.J15163@parcelfarce.linux.theplanet.co.uk> <20021016175754.GA8112@redhat.com> <20021016210914.P15163@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021016210914.P15163@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 09:09:14PM +0100, Matthew Wilcox wrote:
> On Wed, Oct 16, 2002 at 01:57:54PM -0400, Doug Ledford wrote:
> > Duh, forgot to add INIT_LIST_HEAD(&p->aic_devs); to aic7xxx_register() so 
> > the list_add() is oopsing.  Patch attached.  Let me know if this *doesn't* 
> > solve the problem (I'm not at work where I can test this yet).
> 
> well, it partially solves the problem.  it doesn't oops any more, but
> it still offlines all the devices.
> 
> here's the boot log:
> 
> SCSI subsystem driver Revision: 1.00
> (scsi0) <Adaptec AIC-7899 Ultra 160/m SCSI host adapter> found at PCI 2/1/0
> (scsi0) Wide Channel A, SCSI ID=7, 32/255 SCBs
> (scsi0) Downloading sequencer code... 396 instructions downloaded
> (scsi1) <Adaptec AIC-7899 Ultra 160/m SCSI host adapter> found at PCI 2/1/1
> (scsi1) Wide Channel B, SCSI ID=7, 32/255 SCBs
> (scsi1) Downloading sequencer code... 396 instructions downloaded
> scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.5/5.2.0
>        <Adaptec AIC-7899 Ultra 160/m SCSI host adapter>
> scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.5/5.2.0
>        <Adaptec AIC-7899 Ultra 160/m SCSI host adapter>
>   Vendor:           Model:                   Rev:     
>   Type:   Direct-Access                      ANSI SCSI revision: 00
> scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 0 lun 0
> scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 1 lun 0
>   Vendor:           Model:                   Rev:     
>   Type:   Direct-Access                      ANSI SCSI revision: 00

Hmmm...this is classic interrupt routing problem type symptoms.  Can you
try booting with noapic or with a up kernel and see what happens?  Also,
try Justin's driver.  Interestingly enough, here mine works with no more
changes than just the one I already sent to you and Justin's doesn't :-/  
Going to start debugging Justin's driver for now until I hear back from 
you.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
