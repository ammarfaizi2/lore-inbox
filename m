Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264203AbUDOOp2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 10:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264189AbUDOOp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 10:45:28 -0400
Received: from smtp.rol.ru ([194.67.21.9]:28379 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S264143AbUDOOpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 10:45:22 -0400
From: Konstantin Sobolev <kos@supportwizard.com>
To: Justin Cormack <justin@street-vision.com>
Subject: Re: poor sata performance on 2.6
Date: Thu, 15 Apr 2004 18:48:05 +0400
User-Agent: KMail/1.6.1
Cc: Ryan Geoffrey Bourgeois <rgb005@latech.edu>,
       Kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
References: <200404150236.05894.kos@supportwizard.com> <200404151826.54488.kos@supportwizard.com> <1082039593.19568.75.camel@lotte.street-vision.com>
In-Reply-To: <1082039593.19568.75.camel@lotte.street-vision.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Message-Id: <200404151848.05857.kos@supportwizard.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 April 2004 18:33, Justin Cormack wrote:
> On Thu, 2004-04-15 at 15:26, Konstantin Sobolev wrote:
> > On Thursday 15 April 2004 18:00, Justin Cormack wrote:
> > > hmm, odd. I get 50MB/s or so from normal (7200, 8MB cache) WD disks,
> > > and Seagate from the same controller. Can you send lspci,
> > > /proc/interrupts and dmesg...
> >
> > Attached are files for 2.6.5-mm5 with highmem, ACPI and APIC turned off.
>
> ah. Make a filesystem on it and mount it and try again. I see you have
> no partition table and so probably no filesystem. This means the block
> size is set to default 512byte not 4k which makes disk operations slow.
> Any filesystem should default to block size of 4k, eg ext2.

Very interesting!
created partition table,
kos sata # mkfs.ext2 /dev/sda1
[..skipped..]
kos mnt # cd /
kos / # mkdir wd
kos / # mount /dev/sda1 /wd
kos / # hdparm -t -a8192 /dev/sda

/dev/sda:
 setting fs readahead to 8192
 readahead    = 8192 (on)
 Timing buffered disk reads:   82 MB in  3.03 seconds =  27.02 MB/sec

kos / # mount | grep sda
/dev/sda1 on /wd type ext2 (rw)
kos / # hdparm -t -a8192 /dev/sda

/dev/sda:
 setting fs readahead to 8192
 readahead    = 8192 (on)
 Timing buffered disk reads:  206 MB in  3.02 seconds =  68.15 MB/sec
kos / # hdparm -t -a8192 /dev/sda

/dev/sda:
 setting fs readahead to 8192
 readahead    = 8192 (on)
 Timing buffered disk reads:  206 MB in  3.02 seconds =  68.18 MB/sec

So first time it gave the same loosy 27 MB/s and subsequent tests give pretty 
good 68 MB/s! Why?

/KoS
* I haven't lost my mind...It's backed up somewhere!		      
