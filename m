Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbSITGrT>; Fri, 20 Sep 2002 02:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261207AbSITGrT>; Fri, 20 Sep 2002 02:47:19 -0400
Received: from mta06bw.bigpond.com ([139.134.6.96]:41166 "EHLO
	mta06bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S261205AbSITGrS>; Fri, 20 Sep 2002 02:47:18 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Reg Clemens <reg@dwf.com>, linux-kernel@vger.kernel.org
Subject: Re: Dont understand hdc=ide-scsi behaviour.
Date: Fri, 20 Sep 2002 16:46:00 +1000
User-Agent: KMail/1.4.5
References: <200209192108.g8JL8iT6010419@orion.dwf.com>
In-Reply-To: <200209192108.g8JL8iT6010419@orion.dwf.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209201646.00202.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 20 Sep 2002 07:08, Reg Clemens wrote:
> I dont understand the behaviour of kernel 2.4.18 (and probably all others)
> when I put the line
> 		hdc=ide-scsi
> on the load line.
>
> I would EXPECT to get the ide-scsi driver for hdc (my cdwriter) but instead
> get it for BOTH hdc and hdd, the cdwriter and the zip drive.
>
> After starting this way (with hdc=ide-scsi), I find that
> 	/dev/cdrom2 -> /dev/scd0
> and that to access the zip drive I have to use /dev/sda1 (or /dev/sda4)
There are two slightly different things happening, I think.

1. When you say hdc=ide-scsi, you are telling the IDE system that you don't 
want to use the normal IDE interfaces to userland (such as ide-cdrom), but 
instead want all access to this device to be accessed through the SCSI 
midlayer (and associated SCSI interfaces, like the sg and scd drivers). So 
ide-scsi becomes the driver, instead of ide-cdrom. You should be able to see 
this in /proc/ide/hdc/driver

2. ide-scsi is greedy, and will grab any IDE device without a driver. ATAPI 
floppy devices (hopefully) like your zip drive need the IDE floppy device 
driver, which is probably not loaded. What does CONFIG_BLK_DEV_IDEFLOPPY 
equal in your kernel config?

> I would EXPECT to get to them via /dev/hdd1 or /dev/hdd4.
And you will, with the right driver loaded :-)

> Did I miss something or is this a bug????
If you load ide-floppy before ide-scsi, and it still doesn't work, then there 
is a bug.

Brad
- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9isQoW6pHgIdAuOMRAtfvAJ9QxzwAyyaLFRIHisEiZ9oEzGm9ngCfZMHB
X/OxH0BykeRSrQKAKj22u2Y=
=E/AW
-----END PGP SIGNATURE-----

