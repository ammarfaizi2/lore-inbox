Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131346AbRBNVf0>; Wed, 14 Feb 2001 16:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130501AbRBNVfR>; Wed, 14 Feb 2001 16:35:17 -0500
Received: from janus.cypress.com ([157.95.1.1]:20682 "EHLO janus.cypress.com")
	by vger.kernel.org with ESMTP id <S131346AbRBNVe6>;
	Wed, 14 Feb 2001 16:34:58 -0500
Message-ID: <3A8AF9F9.38D467EB@cypress.com>
Date: Wed, 14 Feb 2001 15:34:49 -0600
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor Southeast Design Center
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, de-CH, de, zh-TW, zh-CN, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Jasmeet Sidhu <jsidhu@arraycomm.com>
Subject: Re: IDE DMA Problems...system hangs
In-Reply-To: <5.0.2.1.2.20010214115941.02471bb8@pop.arraycomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jasmeet Sidhu wrote:
> 
> Hey guys,
> 
> I am attaching my previous email for additional info.  Now I am using
> kernel 2.4.1-ac12 and these problems have not gone away.
> 
> Anybody else having these problems with a ide raid 5?
> 
> The Raid 5 performance should also be questioned..here are some number
> returned by hdparam
> 
> /dev/hda -    IBM DLTA 20GB (ext2)
> /dev/md0 - 8 IBM DLTA 45GB (Reiserfs)
> 
> [root@bertha hdparm-3.9]# ./hdparm -t /dev/hda
> /dev/hda:
> Timing buffered disk reads:  64 MB in  2.36 seconds = 27.12 MB/sec
> 
> [root@bertha hdparm-3.9]# ./hdparm -t /dev/md0
> /dev/md0:
> Timing buffered disk reads:  64 MB in 22.16 seconds =  2.89 MB/sec
> 
> Is this to be expected?  This much performance loss?  Anybody else using
> IDE raid, I would really appreciate your input on this setup.

md2 = RAID0 ext2

hda = hdb = IBM DTTA-351010 (10GB, 5400RPM, UDMA33)

# hdparm -tT /dev/hda /dev/md2
/dev/hda:
Timing buffered disk reads:  64 MB in  5.27 seconds = 12.14 MB/sec
Timing buffer-cache reads:   128 MB in  0.82 seconds =156.10 MB/sec

/dev/md2:
Timing buffered disk reads:  64 MB in  3.34 seconds = 19.16 MB/sec
Timing buffer-cache reads:   128 MB in  0.80 seconds =160.00 MB/sec

On AMD K7 w/ 7409 (Viper) chipset, DMA66 mode w/ 80-pin cable.
kernel = 2.4.1-ac8, no errors in kernel log.
So I get a 58% increase. You should almost max out the bus.

You probably have a bad cable. Try hdparam on each disk and see if
any of them have errors/ cause the lockup.

	-Thomas
