Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281694AbRKUKZg>; Wed, 21 Nov 2001 05:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281599AbRKUKZ0>; Wed, 21 Nov 2001 05:25:26 -0500
Received: from paloma16.e0k.nbg-hannover.de ([62.159.219.16]:29154 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S281563AbRKUKZL>; Wed, 21 Nov 2001 05:25:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Nikita Danilov <Nikita@namesys.com>,
        Andreas Dilger <adilger@turbolabs.com>
Subject: Re: [reiserfs-list] Re: [REISERFS TESTING] new patches on ftp.namesys.com: 2.4.15-pre7
Date: Wed, 21 Nov 2001 11:24:50 +0100
X-Mailer: KMail [version 1.3.2]
Cc: ReiserFS List <reiserfs-list@namesys.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200111210110.fAL1Atc11275@beta.namesys.com> <20011121011655.M1308@lynx.no> <15355.31671.983925.611542@beta.reiserfs.com>
In-Reply-To: <15355.31671.983925.611542@beta.reiserfs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011121102517Z281563-17408+16912@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 21. November 2001 11:02 schrieb Nikita Danilov:

> Yes, it's right, but currently we have what we have currently. I am
> going to extend inode-attrs.patch and add new mount option
> "noattrs". With it ioctls to set and get attributes will continue to
> work, but attributes themselves will not have any effect. Then, one can
> boot with "rootflags=noattrs" and read-write root, clear all attributes
> by chattr -R and remount root.
>
> I put new version of the patch in the same place, Dieter, can you please
> try it?

So here it goes.
You made one mistake in your README file:

[-]
        chattr -R -SAadiscu /reiserfs-mount-point

    for each reiserfs file system. Said garbage on root file-system can
    prevent system from booting (for example spurious immutable flag on
    /dev/console) to work around this, new mount option
    "noattrs" is provided. With it chattr and lsattr still work, but
    attributes don't have any actual effect. So, boot system with
        "rootflags=noattr", clear all attributes and reboot or remount root
        file system.
[-]

You've forgotten the little "s"  but had it right in your post.

After I've 'booted  into single user mode with "linux rootflags=noattrs" I 
could change my archives but _NOT_ /dev/console the right way. After the 
second reboot I got the warning and kernel hang, again. Something wrong with 
your patch or my installation?

SunWave1 /# l /dev/console
crw-------    1 root     root       5,   1 Nov 21 11:01 /dev/console
SunWave1 /# lsattr /dev/console
lsattr: Invalid argument While reading flags on /dev/console

Two other FS in /dev have some problems, too. But I think that is right.

SunWave1 /# chattr -R -SAadiscu /dev/
chattr: Inappropriate ioctl for device while reading flags on /dev//pts
chattr: Inappropriate ioctl for device while reading flags on /dev//shm

All the files in /proc show the same.

Here comes a little positive example, I think.

SunWave1 /# lsattr /tmp/
----------X-j /tmp//xwlog
--------B-X-j /tmp//kde-nuetzel
------------- /tmp//dcop6SKhoM
---------D-Ej /tmp//YaST2.tdir
----------XEj /tmp//ksocket-root
--------B-X-j /tmp//mcop-nuetzel
--------B--Ej /tmp//kde-root
--------B-X-j /tmp//ksocket-nuetzel
--------B--Ej /tmp//INSTALL
--------BD-Ej /tmp//modules.conf.-
---------DX-j /tmp//vi.recover
--------BD-Ej /tmp//mcop-root
------------j /tmp//lost+found
--------BD-Ej /tmp//modules.conf

What next?

Thanks,
	Dieter

PS Have you read about the latest ACL discussion on LKML?
