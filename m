Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315607AbSFJR5i>; Mon, 10 Jun 2002 13:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315611AbSFJR5h>; Mon, 10 Jun 2002 13:57:37 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:13814 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S315607AbSFJR5f>; Mon, 10 Jun 2002 13:57:35 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 10 Jun 2002 11:55:59 -0600
To: Samuel Maftoul <maftoul@esrf.fr>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: /usr/bin/df reports false size on big NFS shares
Message-ID: <20020610175559.GM20388@turbolinux.com>
Mail-Followup-To: Samuel Maftoul <maftoul@esrf.fr>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020610165432.A15246@pcmaftoul.esrf.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 10, 2002  16:54 +0200, Samuel Maftoul wrote:
> On several machines, with kernel 2.4.18 the same mounts reports different
> sizes than with 2.4.4 :
> 
> -------------------------------------------------------------------------
> maftoul@brick20:~ > uname  -a 
> Linux brick20 2.4.4-4GB #6 Thu Jul 26 10:00:30 CEST 2001 i686 unknown
> 
> maftoul@brick20:~ > df -h 
> Filesystem            Size  Used Avail Use% Mounted on
> /dev/sda1              13G  3.1G  9.5G  25% /
> shmfs                 517M     0  516M   0% /dev/shm
> grey:/disk91          230G  127G  102G  56% /mntdirect/_disk91
> yellow:/disk23        140G  100G   39G  72% /mntdirect/_disk23
> violet:/data/id19/external
>                       2.7T  1.1T  1.6T  38% /mntdirect/_data_id19_external
> maftoul@brick20:~ >
> -------------------------------------------------------------------------
> 
> maftoul@brick4:~ > uname  -a 
> Linux brick4 2.4.18 #3 Thu Apr 4 17:04:20 CEST 2002 i686 unknown
> maftoul@brick4:~ > 
> 
> maftoul@brick4:~ > df -h 
> Filesystem            Size  Used Avail Use% Mounted on
> /dev/sda1             4.7G  2.7G  2.0G  58% /
> shmfs                 125M     0  124M   0% /dev/shm
> grey:/disk91          230G  127G  102G  56% /mntdirect/_disk91
> yellow:/disk23        140G  100G   39G  72% /mntdirect/_disk23
> violet:/data/id19/external
>                       669G -7.0Z  1.6T 101% /mntdirect/_data_id19_external
> -------------------------------------------------------------------------
> 
> See the violet one ?
> The reported size is the same on every 2.4.18 machine using this mount I
> saw.

Probably an overflow in the math somewhere.  Since the overflow is in
the zettabyte range, it is probably someone not being careful with
64-bit values overflowing.  "64-bit values are large enough for
everything, right..."

> It's all suse 7.2 , first one (2.4.4) is suse 7.2 base kernel, 2.4.18 is
> our own (for firewire better firewire support).

Probably the best thing you can do is either diff the two kernel sources
looking for changes in fs/nfs, or start with 2.4.4 and apply patches
until you get a failure.

I don't think a lot of people will be able to help you test this, as
they don't have 2.7TB NFS servers available ;-).

Cheers, Andreas

FYI: In case anyone is wondering (I was) a "Z" is a Zettabyte (2^70 bytes).
     It falls between Exabyte (1024 PB = 2^60) and Yottabyte (2^80).
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

