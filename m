Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWGAWXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWGAWXR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 18:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWGAWXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 18:23:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9104 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750891AbWGAWXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 18:23:14 -0400
Date: Sat, 1 Jul 2006 15:22:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Neil Brown <neilb@suse.de>, Reuben Farrelly <reuben-lkml@reub.net>,
       Grant Wilson <grant.wilson@zen.co.uk>
Subject: Re: 2.6.17-mm5 dislikes raid-1, just like mm4
Message-Id: <20060701152258.bea091a6.akpm@osdl.org>
In-Reply-To: <20060701181455.GA16412@aitel.hist.no>
References: <20060701033524.3c478698.akpm@osdl.org>
	<20060701181455.GA16412@aitel.hist.no>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jul 2006 20:14:55 +0200
Helge Hafting <helgehaf@aitel.hist.no> wrote:

> I  just got mm5 up, and it has the same problem as mm4.
> Raid-1 does not work. I used 2.6.16 to resync my raids,
> and booted into 2.6.17-mm5.
> 
> [...]
> md:  adding sda2 ...
> md: created md0
> md: bind<sda2>
> md: bind<sdb1>
> md: running: <sdb1><sda2>
> raid1: raid set md0 active with 2 out of 2 mirrors
> md: ... autorun DONE.
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
>   Vendor: USB2.0    Model:       HS-CF       Rev: 1.64
>   Type:   Direct-Access                      ANSI SCSI revision: 00
> sd 3:0:0:0: Attached scsi removable disk sdf
> sd 3:0:0:0: Attached scsi generic sg5 type 0
>   Vendor: USB2.0    Model:       HS-MS       Rev: 1.64
>   Type:   Direct-Access                      ANSI SCSI revision: 00
> sd 3:0:0:1: Attached scsi removable disk sdg
> sd 3:0:0:1: Attached scsi generic sg6 type 0
>   Vendor: USB2.0    Model:       HS-SM       Rev: 1.64
>   Type:   Direct-Access                      ANSI SCSI revision: 00
> sd 3:0:0:2: Attached scsi removable disk sdh
> sd 3:0:0:2: Attached scsi generic sg7 type 0
>   Vendor: USB2.0    Model:       HS-SD/MMC   Rev: 1.64
>   Type:   Direct-Access                      ANSI SCSI revision: 00
> sd 3:0:0:3: Attached scsi removable disk sdi
> sd 3:0:0:3: Attached scsi generic sg8 type 0
> usb-storage: device scan complete
> loadkeys[2214]: segfault at 00000000000005a0 rip 00002b22e169feea rsp 00007fffc973c478 error 4
> Adding 1000424k swap on /dev/sda6.  Priority:1 extents:1 across:1000424k
> EXT3 FS on sdd1, internal journal
> raid1: Disk failure on sda2, disabling device. 
>         Operation continuing on 1 devices
> RAID1 conf printout:
>  --- wd:1 rd:2
>  disk 0, wo:1, o:0, dev:sda2
>  disk 1, wo:0, o:1, dev:sdb1
> RAID1 conf printout:
>  --- wd:1 rd:2
> 
> ...
>
> As we see, the md devices are assembled, then the filesystems are
> mounted and swap turned on.  Then all three md devices fail a 
> partition at the same time.  Somehow, I don't believe that
> is correct. ;-)
> 

I assume this is still the broken-barriers bug.  Thanks for all the help on
this, guys.  More is to be asked for, I'm afraid.

I've prepared a tree which is basically 2.6.17-mm5, only the git-scsi-misc
and git-libata-all trees have been omitted.  It's at 

http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.17-mm5-no-sata-scsi.bz2

(That's a diff against 2.6.17)

If that kernel works, then the next step is to test

http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.17-mm5-no-scsi.bz2

which is 2.6.17-mm5 without git-scsi-misc, but with git-libata-all.

Thanks.
