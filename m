Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVANT1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVANT1T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 14:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbVANTYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 14:24:17 -0500
Received: from mproxy.gmail.com ([216.239.56.243]:37695 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262090AbVANTV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 14:21:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=adKwoF8Lom1bmtkUFS0uHVoLT4pxVpqWBNCdvzQ08mEBOw1TqmfE3XoZgCnqQiTGdr0ZIW+fih2jBrUsldHYJaFaeypkIl01cSqjimJ9ZFsckG5qybRvY7ei3vFg1oj6OFydoRbGsejvdZyd1iXWbmi4J7Y1YnfSrBBDjTY0jZc=
Message-ID: <7f45d9390501141121269b42b2@mail.gmail.com>
Date: Fri, 14 Jan 2005 11:21:27 -0800
From: Shaun Jackman <sjackman@gmail.com>
Reply-To: Shaun Jackman <sjackman@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Poor responsiveness during disk I/O
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My system is unresponsive and nearly unusable during period of high
disk I/O. hdparm reports it's using UDMA5 (ATA100), so it looks like
everything's up and running. I have a nForce 220-D motherboard
(A7N266-VM), a new 160 GB Maxtor ATA133 drive, and an 80 wire IDE
cable. I've compiled the amd74xx driver into the kernel.

ATA100 suggests a maximum throughput of 100 MB/s. What I should I
expect to see with hdparm -t?   I'm seeing 40 MB/s.

Please cc me in your reply. Thanks,
Shaun

# hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  132 MB in  3.05 seconds =  43.26 MB/sec
# hdparm -v /dev/hda

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 19929/255/63, sectors = 163928604672, start = 0
# hdparm -i /dev/hda

/dev/hda:

 Model=Maxtor 6Y160P0, FwRev=YAR41BW0, SerialNo=Y45EJ8KE
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 udma6
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null):

 * signifies the current active mode
# cat /proc/ide/amd74xx
----------AMD BusMastering IDE Configuration----------------
Driver Version:                     2.13
South Bridge:                       0000:00:09.0
Revision:                           IDE 0xc3
Highest DMA rate:                   UDMA100
BM-DMA base:                        0xa800
PCI clock:                          33.3MHz
-----------------------Primary IDE-------Secondary IDE------
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                 yes
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO      UDMA       PIO
Address Setup:       30ns      90ns      30ns      90ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns     330ns
Data Recovery:       30ns     270ns      30ns     270ns
Cycle Time:          20ns     600ns      60ns     600ns
Transfer Rate:   99.9MB/s   3.3MB/s  33.3MB/s   3.3MB/s
