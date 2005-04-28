Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262500AbVD2LxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262500AbVD2LxH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 07:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVD2LxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 07:53:07 -0400
Received: from smtp04.auna.com ([62.81.186.14]:35287 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S262501AbVD2LxA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 07:53:00 -0400
Date: Thu, 28 Apr 2005 21:09:37 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Extremely poor umass transfer rates
To: linux-kernel@vger.kernel.org
References: <1114704142.8410.4.camel@mjollnir.bootless.dk>
	<20050428165915.GG30768@redhat.com>
	<1114710941.8326.13.camel@mjollnir.bootless.dk>
	<20050428182655.GA6812@irc.pl>
In-Reply-To: <20050428182655.GA6812@irc.pl> (from zdzichu@irc.pl on Thu Apr
	28 20:26:55 2005)
X-Mailer: Balsa 2.3.0
Message-Id: <1114722577l.15771l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.28, Tomasz Torcz wrote:
> On Thu, Apr 28, 2005 at 07:55:40PM +0200, Mark Rosenstand wrote:
> > The line that 'hald' puts in fstab looks like this:
> > 
> > 	/dev/sdb /media/usbdisk vfat \
> > 		user,exec,noauto,utf8,noatime,sync,managed 0 0
> 
>  Are you sure it's correct? I can't even mount with those options:
> 
> #v+
> # mount /dev/sdb1 /mnt/other -t vfat -o user,exec,noauto,utf8,noatime,sync,managed 
> mount: wrong fs type, bad option, bad superblock on /dev/sdb1
>        missing codepage or other error
>        In some cases useful info is found in syslog - try
>        dmesg | tail  or so
> 
> # dmesg | tail -2 
> usb-storage: device scan complete
> FAT: Unrecognized mount option "managed" or missing value
> #v-
> 
>  Omitting "managed" seems to work. But it's slooow:
> 
> # dd if=/dev/zero  bs=1M count=100 | pv > /mnt/other/100MB
> 1,17MB 0:00:28 [41,7kB/s] [      <=>                ]
> 
> It stays at about 40 kB/s during all transfer. 
> Reading is as fast as it should be = about 18 MB/s (after umount, mount
> again, to clear cache). 
> 

Je, je, you're dreaming. The limit on pendrives, flash mp3 players and so
on is the flash memory read/write speed. You are lucky if you get 1Mb/s.
So for a flash based device, dont ever worry about if it is USB 1.1 or 2.0.
Things are different if you have a disk based device (iPod, iPod mini).
A disk is a disk.

The difference in total time should be minimal between sync and async mounts,
if you take into account filesystem sync/umount time.

Anyways, your 40 Kb/sec seem too sloow. But dont expect your 19Mb/s, only
about 1Mb/s (reading, writing thigs drop to 600Kb/s).

by

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam14 (gcc 4.0.0 (4.0.0-1mdk for Mandriva Linux


