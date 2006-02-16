Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWBPUWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWBPUWL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 15:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWBPUWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 15:22:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23464 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964900AbWBPUWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 15:22:10 -0500
Date: Thu, 16 Feb 2006 12:20:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: ce@ruault.com, linux-kernel@vger.kernel.org
Subject: Re: [BUG] kernel 2.6.15.4: soft lockup detected on CPU#0!
Message-Id: <20060216122045.7a664bc6.akpm@osdl.org>
In-Reply-To: <58cb370e0602160533n3325ba03yfedaf4e55278521d@mail.gmail.com>
References: <43EF8388.10202@ruault.com>
	<20060215185120.6c35eca2.akpm@osdl.org>
	<58cb370e0602160533n3325ba03yfedaf4e55278521d@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
>
> On 2/16/06, Andrew Morton <akpm@osdl.org> wrote:
> > Charles-Edouard Ruault <ce@ruault.com> wrote:
> > >
> > > i was trying to rip a CD when the whole machine started to freeze
> > >  periodicaly, i then looked at the logs and found the following :
> > >
> > >  Feb 12 19:23:39 ruault kernel: hdc: irq timeout: status=0x80 { Busy }
> > >  Feb 12 19:23:39 ruault kernel: ide: failed opcode was: unknown
> > >  Feb 12 19:23:39 ruault kernel: hdd: status timeout: status=0x80 { Busy }
> > >  Feb 12 19:23:39 ruault kernel: ide: failed opcode was: unknown
> > >  Feb 12 19:23:39 ruault kernel: hdd: drive not ready for command
> >
> > No idea what caused that.
> >
> > >  Feb 12 19:23:39 ruault kernel: BUG: soft lockup detected on CPU#0!
> >
> > The following was merged today.  Hopefully it suppresses this false
> > positive.
> 
> Unfortunately it won't.  Charles' problem is different (and the BUG
> output is different!) - soft lockup got triggered for PIO handling in
> ide-cd driver.  This patch fixes the problem only for generic ATA PIO
> routines (disks and [P]IDENTIFY), ATAPI PIO still needs fixing
> (ide-cd/floppy/tape/scsi drivers).

argh.  We do need to bop that warning on the head - it's consuming people's
time and causing unneeded concern.

> Andrew, there is no "high level" function for ATAPI PIO as
> ide_pio_datablock() for ATA PIO so fixing soft lockup false positives
> would require going through all drivers and adding bunch of
> touch_softlockup_watchdog() or using sledge-hammer approach
> and touching watchdog in ide-iops.c:atapi_[input,output]_bytes().

Send fixup patch, please?

