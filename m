Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVFCVTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVFCVTY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 17:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVFCVTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 17:19:24 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:25152 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261397AbVFCVTK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 17:19:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bNAyXXrrwdcGSeKy895XKM9DLLQXIEaqBEJMg0WFUone3KRnuLF6lepe+686Qs78XB+gQhqZ5xFmuvh2MpE41NoC0Rbgxrozy8edSDaai+0WCF+IFd/V2kXYZ8c3zCC+HqenGHh67v2pnuYHgJmPBK3br+ITwsEtql49yNalOsY=
Message-ID: <253818670506031419603479ac@mail.gmail.com>
Date: Fri, 3 Jun 2005 17:19:08 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc5-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050601022824.33c8206e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050601022824.33c8206e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I'm encountering the following annoying bug messages in 2.6.12-rc5-mm1
and -mm2 that I can't reproduce in 2.6.12-rc5 with the sym53c8xx_2
SCSI driver. I don't use the SCSI card/drive for booting but the
driver is compiled into my kernel, and reading from the drive seems
OK. Booting -mm2 I get the following :

scan_host_selected+0xdd/0xf0
 [<c03e10e0>] scsi_scan_host+0x30/0x40
 [<c03e8d5f>] sym2_probe+0xef/0x140
 [<c0105800>] do_simd_coprocessor_error+0x70/0xb0
 [<c0102000>] sys_get_thread_area+0x10/0x140
 [<c0331722>] pci_device_probe_static+0x52/0x70
 [<c033177c>] __pci_device_probe+0x3c/0x50
 [<c03317bf>] pci_device_probe+0x2f/0x50
 [<c039ee1b>] driver_probe_device+0x3b/0xb0
 [<c039ef10>] __driver_attach+0x0/0x60
 [<c039ef60>] __driver_attach+0x50/0x60
 [<c039e499>] bus_for_each_dev+0x69/0x80
 [<c039ef95>] driver_attach+0x25/0x30
 [<c039ef10>] __driver_attach+0x0/0x60
 [<c039e968>] bus_add_driver+0x88/0xc0
 [<c0331900>] pci_device_shutdown+0x0/0x30
 [<c0331a9d>] pci_register_driver+0x7d/0xa0
 [<c06c5732>] sym2_init+0x32/0x60
 [<c06a2a7b>] do_initcalls+0x2b/0xc0
  [<c01003b9>] init+0x99/0x1b0
  [<c0100320>] init+0x0/0x1b0
 [<c0101245>] kernel_thread_helper+0x5/0x10

Followed by many repeats of:

BUG: atomic counter underflow at:
 [<c03a5c41>] blk_cleanup_queue+0xc1/0xd0
 [<c03e1739>] scsi_device_dev_release+0x139/0x190
 [<c039d4cb>] device_release+0x5b/0x60
 [<c03247b8>] kobject_cleanup+0x98/0xa0
 [<c03247c0>] kobject_release+0x0/0x10
 [<c0325225>] kref_put+0x45/0xd0
 [<c03247ef>] kobject_put+0x1f/0x30
 [<c03247c0>] kobject_release+0x0/0x10
 [<c03dfb6e>] scsi_alloc_sdev+0x1ae/0x1f0
 [<c03e051f>] scsi_probe_and_add_lun+0x6f/0x1f0
 [<c032470a>] kobject_get+0x1a/0x30
 [<c03e0e73>] scsi_scan_target+0xe3/0x170
 [<c03e0f9d>] scsi_scan_channel+0x9d/0xc0
 [<c03e109d>] scsi_scan_host_selected+0xdd/0xf0
 [<c03e10e0>] scsi_scan_host+0x30/0x40
 [<c03e8d5f>] sym2_probe+0xef/0x140
 [<c0105800>] do_simd_coprocessor_error+0x70/0xb0
 [<c0102000>] sys_get_thread_area+0x10/0x140
 [<c0331722>] pci_device_probe_static+0x52/0x70
 [<c033177c>] __pci_device_probe+0x3c/0x50
 [<c03317bf>] pci_device_probe+0x2f/0x50
 [<c039ee1b>] driver_probe_device+0x3b/0xb0
 [<c039ef10>] __driver_attach+0x0/0x60
 [<c039ef60>] __driver_attach+0x50/0x60
 [<c039e499>] bus_for_each_dev+0x69/0x80
 [<c039ef95>] driver_attach+0x25/0x30
 [<c039ef10>] __driver_attach+0x0/0x60
 [<c039e968>] bus_add_driver+0x88/0xc0
 [<c0331900>] pci_device_shutdown+0x0/0x30
 [<c0331a9d>] pci_register_driver+0x7d/0xa0
 [<c06c5732>] sym2_init+0x32/0x60
 [<c06a2a7b>] do_initcalls+0x2b/0xc0
  [<c01003b9>] init+0x99/0x1b0
  [<c0100320>] init+0x0/0x1b0
 [<c0101245>] kernel_thread_helper+0x5/0x10

Thanks,
Yani
