Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274107AbRISQuP>; Wed, 19 Sep 2001 12:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274106AbRISQuG>; Wed, 19 Sep 2001 12:50:06 -0400
Received: from CM-46-158.chello.cl ([24.152.46.158]:53641 "EHLO
	ronto.dewback.cl") by vger.kernel.org with ESMTP id <S274105AbRISQtu>;
	Wed, 19 Sep 2001 12:49:50 -0400
Date: Wed, 19 Sep 2001 12:49:54 -0400 (CLT)
From: Fabian Arias <dewback@vtr.net>
X-X-Sender: dewback@ronto.dewback.cl
To: Pavel Roskin <proski@gnu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac12 - problem mounting reiserfs (parse error?)
In-Reply-To: <Pine.LNX.4.33.0109191053400.1244-100000@portland.hansa.lan>
Message-ID: <Pine.LNX.4.40.0109191248360.5460-100000@ronto.dewback.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Same here, cannot mount reiserfs partitions on boot.

- Debian Sid
- mount 2.11h
- gcc-2.95.4 (20010902 Debian prerelease) and 3.0.2pre010908.

But in my case I don't have "defaults" on fstab on my reiserfs partitions:

/dev/hdc1  /      ext2          defaults,errors=remount-ro      0 1
/dev/hdc5  /home  reiserfs      rw                              0 2
/dev/hdc6  /usr   reiserfs      rw                              0 2
/dev/hdc3  /var   reiserfs      rw                              0 2


On Wed, 19 Sep 2001, Pavel Roskin wrote:

> Hello!
>
> I've compiled 2.4.9-ac12 and it has problems mounting reiserfs partitions.
>
> This forks fine:
>
> mount /dev/hda6 /usr/local
>
> but "mount /dev/hda6" doesn't work if I have this in /etc/fstab:
>
> /dev/hda6    /usr/local    reiserfs defaults  0 0
>
> It appears that "defaults" is confusing some code in the kernel.  Here are
> more results:
>
> # mount -t reiserfs -o defaults /dev/hda6 /usr/local
> reiserfs kgetopt: there is not option
> mount: wrong fs type, bad option, bad superblock on /dev/hda6,
>        or too many mounted file systems
> # mount -t reiserfs -o rw /dev/hda6 /usr/local
> reiserfs kgetopt: there is not option
> mount: wrong fs type, bad option, bad superblock on /dev/hda6,
>        or too many mounted file systems
> # mount -t reiserfs -o bogus /dev/hda6 /usr/local
> reiserfs kgetopt: there is not option bogus
> mount: wrong fs type, bad option, bad superblock on /dev/hda6,
>        or too many mounted file systems
>
> As you see, invalid options are distinguished ("there is not option
> bogus", as opposed to "there is not option"), but all options are
> considered invalid.
>
> "reiserfs kgetopt: there is not option" appears on the console and in the
> dmesg output, it's not coming from mount.
>
> RedHat 7.1, i686, mount-2.11b-3 (from RedHat).
>
> No problems with 2.4.9-ac10.  I haven't tried 2.4.9-ac12.
>
> I hope to send fix soon.  Sorry, but I'm writing it in hurry to alert
> others that 2.4.9-ac12 is not quite usable, at least with reiserfs.
>
> --
> Regards,
> Pavel Roskin
>
 ---
 Fabian Arias Mun~oz                   |              Debian GNU/Linux Sid
 a.k.a. dewback en		       |		 Kernel 2.4.9-ac10
 #linuxhelp IRC.CHILE		       |			  ReiserFS

