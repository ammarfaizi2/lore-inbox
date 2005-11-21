Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbVKUMQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbVKUMQU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 07:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbVKUMQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 07:16:20 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:57027 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S932286AbVKUMQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 07:16:19 -0500
Date: Mon, 21 Nov 2005 13:15:53 +0100 (CET)
From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Marvell SATA fixes v2
In-Reply-To: <20051118215209.GA9425@havoc.gtf.org>
Message-ID: <Pine.LNX.4.63.0511211311260.22263@dingo.iwr.uni-heidelberg.de>
References: <437D2DED.5030602@pobox.com>
 <Pine.LNX.4.44.0511182241420.5095-100000@kenzo.iwr.uni-heidelberg.de>
 <20051118215209.GA9425@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2005, Jeff Garzik wrote:

> Yes, for both 50xx and 60xx, I had to turn off MSI in order to get
> sata_mv to work...

With MSI and libata DEBUG turned off I had a crash - solid one, SysRQ 
doesn't work. I have forgotten to set console to serial port when 
booting this kernel, so what follows is what I had on the screen, 
hopefully without any typos (and without the initial addresses):

do_IRQ+0x4e/0x86
=====================
common_interrupt+0x1a/0x20
__do_softirq+0x5e/0xdc
do_sortirq+0x4b/0x4f
=====================
apic_timer_interrupt+0x1c/0x24
scsi_request_fn+0x221/0x369 [scsi_mod]
blk_run_queue+0x28/0x37
scsi_next_command+0x26/0x30 [scsi_mod]
scsi_end_request+0x83/0xb0 [scsi_mod]
scsi_io_completion+0x151/0x4d7 [scsi_mod]
sd_rw_intr+0xc9/0x3b4 [sd_mod]
apic_timer_interrupt+0x1c/0x24
scsi_finish_command+0x82/0xd0 [scsi_mod]
scsi_error_handler+0x0/0x124 [scsi_mod]
ata_scsi_qc_complete+0x64/0x77 [libata]
ata_qc_complete+0x32/0xaa [libata]
mv_eng_timeout+0x8b/0x9e [sata_mv]
ata_scsi_error+0xf/0x23 [libata]
scsi_error_handler+0xbc/0x124 [scsi_mod]
kthread+0x93/0x97
kthread+0x0/0x97
kernel+thread_helper+0x5/0xb

This was a SMP kernel running on an Intel PIV with HyperThreading and 
with 2 disks attached to the controller. I'll try to get this crash 
again with serial console...

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De
