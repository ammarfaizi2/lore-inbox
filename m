Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312686AbSCVFzq>; Fri, 22 Mar 2002 00:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312683AbSCVFzh>; Fri, 22 Mar 2002 00:55:37 -0500
Received: from mail.webmaster.com ([216.152.64.131]:49087 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S312682AbSCVFzY> convert rfc822-to-8bit; Fri, 22 Mar 2002 00:55:24 -0500
From: David Schwartz <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.51 (1003) - Registered Version
Date: Thu, 21 Mar 2002 21:55:22 -0800
In-Reply-To: <20020317110008.A21369@outpost.ds9a.nl>
Subject: 2.5.7, IDE, 'handler not null', 'kernel timer added twice'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020322055523.AAA14461@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	I got the following from a 2.5.7 machine.

hdc: ide_set_handler: handler not null; old=c01e5af0, new=c01e5af0
bug: kernel timer added twice at c01e6925.
hdc: ide_set_handler: handler not null; old=c01e5af0, new=c01e5af0
bug: kernel timer added twice at c01e6925.

	The first two occured at about the same time. The second two occured the 
next day. HDC is a WDC WD307AA ATA drive. The controller is a PIIX4 (82371AB) 
using DMA (UDMA33).

	The relevant section of the system map is :

c01e52c0 T do_rw_taskfile
c01e5450 T do_taskfile
c01e55b0 T set_multmode_intr
c01e5610 T set_geometry_intr
c01e5670 T recal_intr
c01e56b0 T task_no_data_intr
c01e5720 t task_in_intr
c01e5840 t pre_task_out_intr
c01e5940 t task_out_intr
c01e5a90 t pre_bio_out_intr
c01e5af0 t bio_mulout_intr
c01e5ce0 t task_mulin_intr
c01e5e70 T ide_cmd_type_parser
c01e5ff0 t ide_init_drive_taskfile
c01e6010 T ide_wait_taskfile
c01e6120 T ide_raw_taskfile
c01e6180 t ide_wait_cmd
c01e6210 T ide_cmd_ioctl
c01e6420 T ide_task_ioctl
c01e64e0 t init_hwif_data
c01e66a0 T drive_is_flashcard
c01e67d0 T __ide_end_request
c01e68c0 T ide_set_handler
c01e6940 t ata_pre_reset
c01e6a00 T ata_capacity
c01e6a40 t ata_special

	This looks harmless, like something was set twice.

-- 
David Schwartz
<davids@webmaster.com>
Looking for news feed peering arrangements in Northern California
Email for info


