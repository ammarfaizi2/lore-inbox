Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289131AbSAGIBD>; Mon, 7 Jan 2002 03:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289120AbSAGIAy>; Mon, 7 Jan 2002 03:00:54 -0500
Received: from mail.zmailer.org ([194.252.70.162]:49280 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S289006AbSAGIAm>;
	Mon, 7 Jan 2002 03:00:42 -0500
Date: Mon, 7 Jan 2002 10:00:22 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: 2.4.17 RAID-1 EXT3  reliable to hang....
Message-ID: <20020107100022.A1914@mea-ext.zmailer.org>
In-Reply-To: <20020104163635.A1268@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020104163635.A1268@mea-ext.zmailer.org>; from matti.aarnio@zmailer.org on Fri, Jan 04, 2002 at 04:36:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 04:36:35PM +0200, Matti Aarnio wrote:
> For past few weeks I have wondered of why my web-server machine
> is hanging semi-regularly.

  Over the weekend I tried something new.
 
> I have:
>   - Two 30+ GB SCSI Ultra2-Wide disks
>   - onboard AIC7XXX controller
>   - Disks with identical partition maps
>   - RAID-1 bound pairwise on those partitions
>     (RAIDTAB entries md3/md4/md5 - the md0/md1/md2 were on
>      other older disk, which was removed latter..)
>   - EXT3 filesystem at all partitions (except at 2 G swap..)
>     Mounted with default options
>   - machine with dual-P-III 750 MHz, and 786 MB memory (3*256MB)

  .. running 2.4.17 code compiled with "SMP" disabled, but
  having APICs enabled. (e.g. Local and IO-APIC.)
  It appears to me as:
   - SMP code, SMP mode: hangup in use
   - SMP code, "nosmp" boot option: hangup in use
   - UP code: works

  Tool chain:

$ gcc -v
gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-97.1)
$ ld -V
GNU ld version 2.11.92.0.12 20011121


  I have partial evidence that EXT3 may be part of the problem,
  as another machine with RAID-1 disks with EXT2 filesystems
  is not hanging up when running RedHat 2.4.16-0.9custom kernel.
  That another machine has, however, IDE disks.

  Earlier experiements with the hanging box used that same RH
  kernel, and hangups were observed there too..

> When the machine is up all the way, and MD disks have finished
> syncing, I execute command:
> 
>   dd if=/dev/zero bs=1024k of=test.file count=8000
> 
> which will lead to hard system hangup where the keyboard won't
> react, SCSI led shines constantly, but nothig happens.
> Right at the moment when the keyboard becomes unresponsibe,
> the disk led will continue to flicker for a few seconds, but
> then the flicker will stop, and the led stays constantly on.

  Of this flicker I am not entirely sure anymore.
  Maybe it happens, maybe not.

  I tried also SGI's  kdb at 2.4.17,  but when the system
  hangs, "pause/break" won't react at all.

> Earlier guestimates of using "noapic", have no effect on
> system hangups.  Same command causes it quite soon. Even
> "noapic nosmp" does hang.
> 
> Large amount of RAM may contribute, but this 3*256MB
> does not need e.g. PAE mode extensions.

/Matti Aarnio
