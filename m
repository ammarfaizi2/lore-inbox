Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315260AbSG1I7z>; Sun, 28 Jul 2002 04:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315285AbSG1I7z>; Sun, 28 Jul 2002 04:59:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:775 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315260AbSG1I7x>;
	Sun, 28 Jul 2002 04:59:53 -0400
Message-ID: <3D43B54C.E33BF47F@zip.com.au>
Date: Sun, 28 Jul 2002 02:11:40 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 12/13] direct IO updates
References: <3D439E47.A227A2B7@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> ...
>
> And against four IDE disks on an HPT374 controller.  Throughput is 120
> megabytes/sec:
> 
> c01eed8c 80       0.292462    end_that_request_first
> c01fe850 87       0.318052    hpt3xx_intrproc
> c01ed574 123      0.44966     blk_rq_map_sg
> c01f8f10 141      0.515464    ata_select
> c014db38 153      0.559333    do_direct_IO
> c010bb78 235      0.859107    timer_interrupt
> c01f9144 281      1.02727     ata_irq_enable
> c01ff990 290      1.06017     udma_pci_init
> c01fe878 308      1.12598     hpt3xx_maskproc
> c02006f8 379      1.38554     idedisk_do_request
> c02356a0 609      2.22637     pci_conf1_read
> c01ff8dc 611      2.23368     udma_pci_start
> c01ff950 922      3.37062     udma_pci_irq_status
> c01f8fac 1002     3.66308     ata_status
> c01ff26c 1059     3.87146     ata_start_dma
> c01feb70 1141     4.17124     hpt374_udma_stop
> c01f9228 3072     11.2305     ata_out_regfile
> c01052d8 15193    55.5422     poll_idle
> 
> Not so good.

Actually...

The adaptecs are on different PCI buses, so there is plenty of
spare PCI capacity.

The HPT374 is on a single 33MHz/32bit PCI bus, which is saturated.

So CPU access to the IDE controller registers will be contending
with all that busmastering traffic, which may explain a lot of
this difference.

-
