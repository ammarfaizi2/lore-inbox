Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129292AbRDAQvm>; Sun, 1 Apr 2001 12:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbRDAQvY>; Sun, 1 Apr 2001 12:51:24 -0400
Received: from bobas.nowytarg.top.pl ([212.244.190.69]:13331 "EHLO
	bobas.nowytarg.top.pl") by vger.kernel.org with ESMTP
	id <S129292AbRDAQvL>; Sun, 1 Apr 2001 12:51:11 -0400
From: Daniel Podlejski <underley@witch.underley.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Re: tmpfs in 2.4.3 and AC
In-Reply-To: <20010330161837.A1052@werewolf.able.es>
In-Reply-To: <20010330161837.A1052@werewolf.able.es>
X-PGP-Fingerprint: 4D 72 53 F8 FE 8C 53 B9  66 AD F6 EA C9 17 CD 82
X-I-are-no-mensan: Yes
Message-Id: <20010401152338Z32060-860+97@witch.underley.eu.org>
Date: Sun, 1 Apr 2001 17:23:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux-kernel, jamagallon@able.es wrote:
: Hi,
: 
: tmpfs (or shmfs or whatever name you like) is still different in official
: series (2.4.3) and in ac series. Its a kick in the ass for multiboot,
: as offcial 2.4.3 does not recognise 'tmpfs' in fstab:
: 
: shmfs  /dev/shm        tmpfs   ...
: 
: Any reason, or is because it has been forgotten ?

There is no tmpfs in vanilla 2.4.3 kernel.

I use this start script to mount tmp/shmfs:

#!/bin/sh

[ -d /dev/shm ] || mkdir -p /dev/shm

shmfs_avail=$(grep -qci 'shmfs' /proc/filesystems || true)
tmpfs_avail=$(grep -qci 'tmpfs' /proc/filesystems || true)
devshm_mounted=$(grep -qci '/dev/shm' /proc/mounts || true)

[ $devshm_mounted = 0 ] || exit 0

if [ $shmfs_avail = 1 ]
then
        echo -ne "Mounting shmfs: "
        mount none /dev/shm -t shmfs && echo "ok."
        exit 0
fi

if [ $tmpfs_avail = 1 ]
then
        echo -ne "Mounting tmpfs: "
        mount tmpfs /dev/shm -t tmpfs && echo "ok."
fi


-- 
Daniel Podlejski <underley@underley.eu.org>
   ... On a dark desert highway Cool wind in my hair
   Warm smell of colitas Rising up through the air ...
