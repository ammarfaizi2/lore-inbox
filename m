Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTLDQNq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 11:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbTLDQNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 11:13:46 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:48055 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S262598AbTLDQNm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 11:13:42 -0500
Date: Thu, 4 Dec 2003 17:09:12 +0100
From: Kristian Peters <kristian.peters@korseby.net>
To: Jimmie Mayfield <mayfield+kernel@sackheads.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23 : timeouts and lost interrupts using IDE-SCSI
Message-Id: <20031204170912.6075f36e.kristian.peters@korseby.net>
In-Reply-To: <YImw.6Dc.5@gated-at.bofh.it>
References: <YImw.6Dc.5@gated-at.bofh.it>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Operating-System: i686 Linux 2.4.23-ck1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jimmie Mayfield <mayfield+kernel@sackheads.org> schrieb:
> Since upgrading from 2.4.20 to 2.4.23, I can no longer mount my ATAPI CDROM and
> CDR/W drives using IDE-SCSI.  Attempts to mount those drives result in
> lost interrupts messages:

That is normal and intended. You should see some "dma disabled" messages in your kernel-log (unless if you haven't enabled "DMA only for disks"). ATAPI/cdrom does not work reliable with DMA on 2.4. I think Andre Hedrick has switched that off after 2.4.20.
If you really want ide-scsi with dma you should try 2.6.

This is how it should like:

SCSI subsystem driver Revision: 1.00
hdb: attached ide-scsi driver.
hdb: DMA disabled		<------
hdd: attached ide-scsi driver.
hdd: DMA disabled		<------
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: COMPAQ    Model: CD-ROM LTN485     Rev: KQA4
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: HP        Model: CD-Writer+ 9100b  Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02

So you should disable that option in your config or if you prefer using hdparm try it with "-d0 /dev/cdrom".

*Kristian
