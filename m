Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965093AbWIEPLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbWIEPLR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 11:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWIEPLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 11:11:16 -0400
Received: from mxsf41.cluster1.charter.net ([209.225.28.173]:24267 "EHLO
	mxsf41.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S965093AbWIEPLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 11:11:14 -0400
X-IronPort-AV: i="4.08,215,1154923200"; 
   d="scan'208"; a="23004252:sNHT63293960"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17661.37761.432488.28556@smtp.charter.net>
Date: Tue, 5 Sep 2006 11:10:57 -0400
From: "John Stoffel" <john@stoffel.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: John Stoffel <john@stoffel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jeff@garzik.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: PATA drivers queued for 2.6.19
In-Reply-To: <44FD7FBD.2060309@ru.mvista.com>
References: <44FC0779.9030405@garzik.org>
	<1157371363.30801.31.camel@localhost.localdomain>
	<17661.31750.457301.687508@smtp.charter.net>
	<44FD7FBD.2060309@ru.mvista.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Sergei" == Sergei Shtylyov <sshtylyov@ru.mvista.com> writes:

Sergei> John Stoffel wrote:
>>>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
>> 
>> 
Alan> Ar Llu, 2006-09-04 am 07:01 -0400, ysgrifennodd Jeff Garzik:
>> 
>>>> The following must be in all caps, though:
>>>> 
>>>> drivers/ide IS STILL THE PATA DRIVER SET THAT USERS AND DISTROS SHOULD 
>>>> CHOOSE.
>> 
>> 
Alan> Except optionally for the following for chips not handled by or broken
Alan> totally in drivers/ide:
>> 
Alan> pata_mpiix - some early pentium era laptops
Alan> pata_oldpiix - original "PIIX" chipset
Alan> pata_radisys - embedded chipset
>> 
>> What about pata_hpt37x and it's failure to work with my HPT302 Rev one
>> controller?  I admit it could be just an IRQ problem, but since
>> 2.6.18-rc5-mm1 works with the old ide/pci/hpt366.c, but not with the

Sergei>     Hm, I believe this driver hasn't been updated since
Sergei> 2.617-mm4 (I have one patch pending still).

>> new version?  It's using the same interrupt each time too.

Sergei>     What's up with it?

Look back in the archives for my messages on this.  Basically, trying
to use the pata_hpt37x driver on an Rocket133 card (HPT302 Rev 1 chip)
fails with a bunch of errors shown below.  This is a PCI add-on card
with /home and /local filesystems on there, mirrored across a pair of
120gb WD drives.  The system also has a pair of builtin SCSI
controllers (AIC7xxx) which hold the OS filesystems, as well as a tape
drive for backups.  It's an SMP system.  I guess I should try to boot
it up UP and see how it goes then as well.

I've tried booting 2.6.18-rc4-mm3 with the irqpoll option, but it
didn't make a difference.  

Do you need more details?

  irq 18: nobody cared (try booting with the "irqpoll" option)
   [<c0104061>] dump_trace+0x1e1/0x210
   [<c01040aa>] show_trace_log_lvl+0x1a/0x30
   [<c0104832>] show_trace+0x12/0x20
   [<c01049a9>] dump_stack+0x19/0x20
   [<c01406d7>] __report_bad_irq+0x27/0x90
   [<c0140966>] note_interrupt+0x226/0x260
   [<c0141221>] handle_fasteoi_irq+0xc1/0xd0
   [<c0105b38>] do_IRQ+0x88/0xf0
   [<c01039ee>] common_interrupt+0x1a/0x20
   [<c0101be4>] default_idle+0x34/0x70
   [<c0101c8c>] cpu_idle+0x6c/0x90
   [<c0100725>] rest_init+0x25/0x30
   [<c0565839>] start_kernel+0x2f9/0x400
   =======================
  handlers:
  [<c03004c0>] (ahc_linux_isr+0x0/0x60)
  [<c03004c0>] (ahc_linux_isr+0x0/0x60)
  [<c03155c0>] (ata_interrupt+0x0/0x1a0)
  Disabling IRQ #18
  ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
  ata2.00: (BMDMA stat 0x4)
  ata2.00: tag 0 cmd 0xca Emask 0x4 stat 0x40 err 0x0 (timeout)
  ata2: soft resetting port
  ata2.00: qc timeout (cmd 0xec)
  ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
  ata2.00: revalidation failed (errno=-5)
  ata2: failed to recover some devices, retrying in 5 secs
  ata2: soft resetting port
  ata2.00: qc timeout (cmd 0xec)
  ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
  ata2.00: revalidation failed (errno=-5)
  ata2: failed to recover some devices, retrying in 5 secs
  ata2: soft resetting port
  ata2.00: qc timeout (cmd 0xec)
  ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
  ata2.00: revalidation failed (errno=-5)
  ata2.00: disabled
  ata2: EH complete
  sd 3:0:0:0: SCSI error: return code = 0x00040000
  end_request: I/O error, dev sdd, sector 234436423
  raid1: Disk failure on sdd1, disabling device.
	  Operation continuing on 1 devices
  ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
  ata1.00: tag 0 cmd 0xe7 Emask 0x4 stat 0x40 err 0x0 (timeout)
  ata1: soft resetting port
  ata1.00: qc timeout (cmd 0xec)
  ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
  ata1.00: revalidation failed (errno=-5)
  ata1: failed to recover some devices, retrying in 5 secs
  ata1: soft resetting port
  ata1.00: qc timeout (cmd 0xec)
  ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
  ata1.00: revalidation failed (errno=-5)
  ata1: failed to recover some devices, retrying in 5 secs
  ata1: soft resetting port
  ata1.00: qc timeout (cmd 0xec)
  ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
  ata1.00: revalidation failed (errno=-5)
  ata1.00: disabled
  ata1: EH complete
  sd 2:0:0:0: SCSI error: return code = 0x00040000
  end_request: I/O error, dev sdc, sector 234436423
  sd 2:0:0:0: SCSI error: return code = 0x00040000
  end_request: I/O error, dev sdc, sector 234436415
  md: ... autorun DONE.
  RAID1 conf printout:
   --- wd:1 rd:2
   disk 0, wo:0, o:1, dev:sdc1
   disk 1, wo:1, o:0, dev:sdd1
  RAID1 conf printout:
   --- wd:1 rd:2
   disk 0, wo:0, o:1, dev:sdc1
