Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbTLPOiA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 09:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbTLPOiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 09:38:00 -0500
Received: from luli.rootdir.de ([213.133.108.222]:24771 "HELO luli.rootdir.de")
	by vger.kernel.org with SMTP id S261613AbTLPOh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 09:37:57 -0500
X-Qmail-Scanner-Mail-From: claas@rootdir.de via luli
X-Qmail-Scanner: 1.16 (Clear:SA:0(-8.2/5.0):. Processed in 1.796937 secs)
Date: Tue, 16 Dec 2003 15:38:08 +0100
From: Claas Langbehn <claas@rootdir.de>
To: linux-kernel@vger.kernel.org
Cc: andre@linux-ide.org, chb@muc.de
Subject: [2.6.0-test11] VIA IDE DMA problems with sleeping harddisk
Message-ID: <20031216143808.GA11517@rootdir.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Reply-By: Fri Dec 19 15:14:54 CET 2003
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.0-test11 i686
X-No-archive: yes
X-Uptime: 15:14:54 up 2 days,  4:47,  6 users,  load average: 0.24, 0.48, 0.80
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


I have got two harddiscs in my system (hda, hdb) and an CD-R/W writer as
hdc. Both harddiscs are UDMA-100 drives. First of all, it is strange
that the drives are only set to a transfer rate of 88.8 MB/s and not
to 100MB/s (see below).


hdb is sleeping most of the time (hdparm -S), but when I need the drive,
it does not spin up fast enough, so that the kernel messages say:

    Dec 16 15:13:14 kernel: hdb: dma_timer_expiry: dma status == 0x61
    Dec 16 15:13:24 kernel: hdb: DMA timeout error
    Dec 16 15:13:24 kernel: hdb: dma timeout error: status=0xd0 { Busy }
    Dec 16 15:13:24 kernel: 
    Dec 16 15:13:24 kernel: hda: DMA disabled
    Dec 16 15:13:24 kernel: hdb: DMA disabled
    Dec 16 15:13:25 kernel: ide0: reset: success

In /proc/ide/via i see, that hda is using PIO now:

    -------------------drive0----drive1----drive2----drive3-----
    Transfer Mode:        PIO      UDMA      UDMA       PIO
    Address Setup:      120ns     120ns     120ns     120ns
    Cmd Active:          90ns      90ns      90ns      90ns
    Cmd Recovery:        30ns      30ns      30ns      30ns
    Data Active:         90ns      90ns      90ns     330ns
    Data Recovery:       30ns      30ns      30ns     270ns
    Cycle Time:         120ns      22ns      60ns     600ns
    Transfer Rate:   16.6MB/s  88.8MB/s  33.3MB/s   3.3MB/s

When I re-enable DMA afterwards the messages say:

Dec 16 15:13:49 zoo kernel: blk: queue dfde1200, I/O limit 4095Mb (mask
0xffffffff)



- How do I increase the dma_timer_expiry so that DMA will 
  not be disabled so fast? 
  
- Why does the kernel say "hdb: DMA disabled" but /proc/ide/via says
  that DMA was only disabled on hda?
  Is it a bug or is it enabled again without telling me?
  
- Which workaround should be considered?



Regards, Claas



# cat /proc/ide/via   (with DMA enabled)

    ----------VIA BusMastering IDE Configuration----------------
    Driver Version:                     3.38
    South Bridge:                       VIA vt8235
    Revision:                           ISA 0x0 IDE 0x6
    Highest DMA rate:                   UDMA133
    BM-DMA base:                        0xdc00
    PCI clock:                          33.3MHz
    Master Read  Cycle IRDY:            0ws
    Master Write Cycle IRDY:            0ws
    BM IDE Status Register Read Retry:  yes
    Max DRDY Pulse Width:               No limit
    -----------------------Primary IDE-------Secondary IDE------
    Read DMA FIFO flush:          yes                 yes
    End Sector FIFO flush:         no                  no
    Prefetch Buffer:              yes                 yes
    Post Write Buffer:            yes                 yes
    Enabled:                      yes                 yes
    Simplex only:                  no                  no
    Cable Type:                   80w                 80w
    -------------------drive0----drive1----drive2----drive3-----
    Transfer Mode:       UDMA      UDMA      UDMA       PIO
    Address Setup:      120ns     120ns     120ns     120ns
    Cmd Active:          90ns      90ns      90ns      90ns
    Cmd Recovery:        30ns      30ns      30ns      30ns
    Data Active:         90ns      90ns      90ns     330ns
    Data Recovery:       30ns      30ns      30ns     270ns
    Cycle Time:          22ns      22ns      60ns     600ns
    Transfer Rate:   88.8MB/s  88.8MB/s  33.3MB/s   3.3MB/s

# uname -a
    Linux zoo 2.6.0-test11 #3 Mon Dec 1 19:57:51 CET 2003 i686 GNU/Linux

