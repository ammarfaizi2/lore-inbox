Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130759AbRA3GdH>; Tue, 30 Jan 2001 01:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130807AbRA3Gc6>; Tue, 30 Jan 2001 01:32:58 -0500
Received: from ns1.cc0.net ([206.190.76.110]:3592 "HELO ns1.cc0.net")
	by vger.kernel.org with SMTP id <S130759AbRA3Gcv>;
	Tue, 30 Jan 2001 01:32:51 -0500
Message-ID: <000901c08a86$6803e3b0$15f3a2cd@ws1>
Reply-To: "Dave" <dave@cc0.net>
From: "Dave" <dave@cc0.net>
To: <linux-kernel@vger.kernel.org>
Subject: VIA 686B/IBM DTLA
Date: Mon, 29 Jan 2001 22:32:24 -0800
Organization: cc0 Internet
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

First post to the list...hope I get it right.


I have noticed extended discussions regarding the VIA chipset and ATA100
problems...well ATA66 problems for that matter. I am curious as to how I can
verify 100%, whether or not I am subject to the problems being discussed or
not.

I have been using (4) IBM DTLA-307075 (75GB) on a Tyan S2505 SMP board which
has onboard Promise (PDC20267) and VIA 686B. I do not use the Promise at all
but rather I have all 4 drives attached to the VIA controller. I recently
(couple weeks ago) built a 2.2.19 kernel and a 2.4.0 kernel with the
following VIA versions:

2.4.0:  $Id: via82cxxx.c,v 2.1e 2000/10/03 10:01:00 vojtech Exp $
2.2.18: linux/drivers/block/via82cxxx.c  Version 0.09    Apr. 02, 2000


With the 2.2.18, dmesg reports tuning sucess for all 4 drives and shows DMA
mode for all 4. When I do a hdparm -Tt /dev/hd[a-d] I get great numbers and
no timeouts or errors whatsoever....

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 9345/255/63, sectors = 150136560, start = 0

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.82 seconds =156.10 MB/sec
 Timing buffered disk reads:  64 MB in  1.77 seconds = 36.16 MB/sec

/dev/hdc:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 17873/16/63, sectors = 150136560, start = 0

/dev/hdc:
 Timing buffer-cache reads:   128 MB in  0.76 seconds =168.42 MB/sec
 Timing buffered disk reads:  64 MB in  1.76 seconds = 36.36 MB/sec



With the 2.4, dmesg reports tuning sucess for all 4 drives and shows DMA
mode for all 4. Same here when I do hdparm...(hd settings omitted but
identical) numbers look great and no errors (UDMA2 I guess)

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.81 seconds =158.02 MB/sec
 Timing buffered disk reads:  64 MB in  2.65 seconds = 24.15 MB/sec

/dev/hdc:
 Timing buffer-cache reads:   128 MB in  0.75 seconds =170.67 MB/sec
 Timing buffered disk reads:  64 MB in  2.39 seconds = 26.78 MB/sec

First...I am wondering why others are having substantial problems with
similar setups. I have never experienced any data loss or timeouts with the
above described setup. Is there something I can do to test whether my
configuration is subject to the problems being discussed?

I do notice that on the 2.4 UDMA is locked down to mode 2 which is indicated
by the lower transfer speeds. It seems though that when I was building a 2.4
a couple weeks ago that the VIA did run at mode 5 as I was able to hit the
same speeds roughly as the 2.2.18.

Are the problems limited to 2.4 kernels? Any suggestions on what to do to
test the current setup at UDMA2 on the 2.4?

Thanks for any assistance...


-Dave

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
