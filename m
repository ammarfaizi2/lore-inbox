Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbVBCLXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbVBCLXm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 06:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVBCLON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 06:14:13 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:63876 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S263014AbVBCLIN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 06:08:13 -0500
Subject: Re: [PATCH 2.6.11-rc2 0/29] ide: driver updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <tj@home-tj.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
In-Reply-To: <42008FFF.1080904@pobox.com>
References: <20050202024017.GA621@htj.dyndns.org>
	 <42008FFF.1080904@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1107341195.14787.122.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 03 Feb 2005 10:03:14 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-02-02 at 08:31, Jeff Garzik wrote:
> > 	Merges drivers/ide/pci/*.h files into their corresponding *.c
> > 	files.  Rationales are
> > 	1. There's no reason to separate pci drivers into header and
> > 	   body.  No header file is shared and they're simple enough.
> > 	2. struct pde_pci_device_t *_chipsets[] are _defined_ in the
> > 	   header files.  That isn't the custom and there's no good
> > 	   reason to do differently in these drivers.
> > 	3. Tracking changelogs shows that the bugs fixed by 00 and 01
> > 	   are introduced during mass-updating ide pci drivers by
> > 	   forgetting to update *.h files.
> 
> Personally, I agree.  However, I would ask Alan for his rationale before 
> applying this...

Historically they were split so they stayed split. SCSI has mostly (c/o
hch) switched away from that and it seems sensible for IDE to do so.

> 
> > 07_ide_reg_valid_t_endian_fix.patch
> > 
> > 	ide_reg_valid_t contains bitfield flags but doesn't reverse
> > 	bit orders using __*_ENDIAN_BITFIELD macros.  And constants
> > 	for ide_reg_valid_t, IDE_{TASKFILE|HOB}_STD_{IN|OUT}_FLAGS,
> > 	are defined as byte values which are correct only on
> > 	little-endian machines.  This patch defines reversed constants
> > 	and .h byte union structure to make things correct on big
> > 	endian machines.  The only code which uses above macros is in
> > 	flagged_taskfile() and the code is currently unused, so this
> > 	patch doesn't change any behavior.  (The code will get used in
> > 	later patches.)
> 
> doesn't this "fix" change behavior on existing big endian machines?

My question too, remember that there is I/O byte order swizzling afoot
in 
the I/O macros.



Generally looks good IMHO.

