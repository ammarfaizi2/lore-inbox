Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbSIWUmq>; Mon, 23 Sep 2002 16:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261374AbSIWUmq>; Mon, 23 Sep 2002 16:42:46 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:20147 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S261305AbSIWUml>; Mon, 23 Sep 2002 16:42:41 -0400
Subject: Re: Sleeping function called from illegal context at slab.c:1378
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3D8F77B4.A8B9DDC4@digeo.com>
References: <3D8F5DB2.A3E36E16@digeo.com>
	<1032811220.28332.24.camel@spc9.esa.lanl.gov>  <3D8F77B4.A8B9DDC4@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 23 Sep 2002 14:43:58 -0600
Message-Id: <1032813839.28405.30.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-23 at 14:21, Andrew Morton wrote:
> Steven Cole wrote:
> > 
> > ...
> > I guess that traced warning was of interest, so here are two
> > more from 2.5.38-mm2.
> 
> Well this is fun.
>  
> > 
> > Trace; c0119986 <__might_sleep+56/5d>
> > Trace; c0135166 <kmalloc+66/1f0>
> > Trace; c0120048 <__request_region+18/c0>
> > Trace; c0215ca2 <eata2x_detect+142/d60>
> > Trace; c02037a4 <ahc_linux_alloc_device+14/70>
> > Trace; c020298c <ahc_linux_queue+16c/1a0>
> > Trace; c0117c71 <schedule+351/3e0>
> > Trace; c01f1c6a <scsi_request_fn+13a/450>
> > Trace; c0117fe2 <wait_for_completion+b2/110>
> > Trace; c01f149d <scsi_queue_next_request+5d/140>
> > Trace; c01ea9da <scsi_release_command+13a/150>
> > Trace; c013432d <kmem_slab_destroy+dd/110>
> > Trace; c0134f07 <free_block+b7/120>
> > Trace; c013533a <kmem_cache_free+4a/80>
> > Trace; c01c7b43 <elevator_exit+13/20>
> > Trace; c01f3c06 <scan_scsis+96/a0>
> > Trace; c01ec218 <scsi_register_host+48/340>
> > Trace; c01b0133 <put_bus+13/57>
> > Trace; c01050b1 <init+51/1d0>
> > Trace; c0105060 <init+0/1d0>
> > Trace; c01070b9 <kernel_thread_helper+5/c>
> > 
> 
> eata2x_detect() calls port_detect() under driver_lock.
> port_detect() calls request_region(), which can sleep.

Here is the output from dmesg just before that warning:

SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

blk: queue f1a15018, I/O limit 4095Mb (mask 0xffffffff)
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 126, 16bit)
blk: queue f1a15418, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: HITACHI   Model: DK32CJ-36MW       Rev: JBBB
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 126, 16bit)
blk: queue f1a15818, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: HITACHI   Model: DK32CJ-36MW       Rev: JBBB
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 8
scsi0:A:1:0: Tagged Queuing enabled.  Depth 8
blk: queue f1a15018, I/O limit 4095Mb (mask 0xffffffff)
PCI: Enabling device 01:04.0 (0116 -> 0117)
PCI: Enabling device 01:04.1 (0116 -> 0117)
Sleeping function called from illegal context at slab.c:1378


> > Trace; c0119986 <__might_sleep+56/5d>
> > Trace; c0135166 <kmalloc+66/1f0>
> > Trace; c0271e03 <convert_ipfw+63/130>
> > Trace; c027216a <ip_fw_ctl+29a/4d0>
> 
> That's the ip_fw_ctl() one.

Oops, sorry for the double report on that one.  I'm lost in a maze of
twisty traces, all alike.

Steven

