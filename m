Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbUEKPvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUEKPvV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 11:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264806AbUEKPvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 11:51:21 -0400
Received: from [195.167.170.152] ([195.167.170.152]:33462 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id S262756AbUEKPvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 11:51:17 -0400
Date: Tue, 11 May 2004 16:51:16 +0100
From: Athanasius <link@miggy.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
Message-ID: <20040511155116.GA19038@miggy.org>
Mail-Followup-To: Athanasius <link@miggy.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <409F4944.4090501@keyaccess.nl> <200405102125.51947.bzolnier@elka.pw.edu.pl> <409FF068.30902@keyaccess.nl> <200405102352.24091.bzolnier@elka.pw.edu.pl> <40A0B7E4.7060103@keyaccess.nl> <1084280198.9420.5.camel@amilo.bradney.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084280198.9420.5.camel@amilo.bradney.info>
User-Agent: Mutt/1.3.28i
X-gpg-fingerprint: B34E4BC3
X-gpg-key: http://www.fysh.org/~athan/gpg-key
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 02:56:38PM +0200, Craig Bradney wrote:
> > > Rene, can you send me copies of /proc/ide/hda/identify and
> > > /proc/ide/hdc/identify?
> At a guess the 80P0 drives will also be affected (80G, 8mb cache), but
> as yet I havent tried 2.6.6 on the boxes with them. Tonight if theres
> time.

/dev/hda:

 Model=Maxtor 6Y080P0, FwRev=YAR41BW0, SerialNo=Y24X835E
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16, MultSect=off
 CurCHS=4047/16/255, CurSects=16511760, LBA=yes, LBAsects=160086528
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 udma6 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null): 

At boot-time I did get two lots of:

hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: Write Cache FAILED Flushing!

Still on the first boot of 2.6.6 atm, so don't know if it bitches at
shutdown too.

16:50:02 0$ cat /proc/ide/hda/identify
0040 3fff c837 0010 0000 0000 003f 0000
0000 0000 5932 3458 3833 3545 2020 2020
2020 2020 2020 2020 0003 3e00 0039 5941
5234 3142 5730 4d61 7874 6f72 2036 5930
3830 5030 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 2f00 4000 0200 0000 0007 0fcf 0010
00ff f310 00fb 0100 ba00 098a 0000 0007
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
00fe 001e 7c6b 7b09 4003 7c69 3a01 4003
207f 0000 0000 0000 fffe 600b c0fe 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0009 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0001 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 d6a5
root@emelia:~;
16:50:03 0$ 

-Ath
-- 
- Athanasius = Athanasius(at)miggy.org / http://www.miggy.org/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME
