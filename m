Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281718AbRKULVb>; Wed, 21 Nov 2001 06:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281294AbRKULVR>; Wed, 21 Nov 2001 06:21:17 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:12819 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S281718AbRKULU4>; Wed, 21 Nov 2001 06:20:56 -0500
From: Nikita Danilov <Nikita@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Message-ID: <15355.39821.401925.96954@beta.reiserfs.com>
Date: Wed, 21 Nov 2001 15:18:21 +0300
To: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Andreas Dilger <adilger@turbolabs.com>,
        ReiserFS List <reiserfs-list@namesys.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-list] Re: [REISERFS TESTING] new patches on ftp.namesys.com: 2.4.15-pre7
In-Reply-To: <20011121102517Z281563-17408+16912@vger.kernel.org>
In-Reply-To: <200111210110.fAL1Atc11275@beta.namesys.com>
	<20011121011655.M1308@lynx.no>
	<15355.31671.983925.611542@beta.reiserfs.com>
	<20011121102517Z281563-17408+16912@vger.kernel.org>
X-Mailer: VM 6.96 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Nützel writes:
 > Am Mittwoch, 21. November 2001 11:02 schrieb Nikita Danilov:
 > 
 > > Yes, it's right, but currently we have what we have currently. I am
 > > going to extend inode-attrs.patch and add new mount option
 > > "noattrs". With it ioctls to set and get attributes will continue to
 > > work, but attributes themselves will not have any effect. Then, one can
 > > boot with "rootflags=noattrs" and read-write root, clear all attributes
 > > by chattr -R and remount root.
 > >
 > > I put new version of the patch in the same place, Dieter, can you please
 > > try it?
 > 
 > So here it goes.
 > You made one mistake in your README file:
 > 
 > [-]
 >         chattr -R -SAadiscu /reiserfs-mount-point
 > 
 >     for each reiserfs file system. Said garbage on root file-system can
 >     prevent system from booting (for example spurious immutable flag on
 >     /dev/console) to work around this, new mount option
 >     "noattrs" is provided. With it chattr and lsattr still work, but
 >     attributes don't have any actual effect. So, boot system with
 >         "rootflags=noattr", clear all attributes and reboot or remount root
 >         file system.
 > [-]
 > 
 > You've forgotten the little "s"  but had it right in your post.
 > 
 > After I've 'booted  into single user mode with "linux rootflags=noattrs" I 
 > could change my archives but _NOT_ /dev/console the right way. After the 
 > second reboot I got the warning and kernel hang, again. Something wrong with 
 > your patch or my installation?

Something is wrong with my head, it looks. Well, the simplest way to get
it working is 

chattr -SAadiscu /dev
rm /dev/console
mknod /dev/console c 5 1
chmod 700 /dev/console

this way /dev/console will be recreated and attributes of parent
directory "/dev" will be inherited.

 > 
 > SunWave1 /# l /dev/console
 > crw-------    1 root     root       5,   1 Nov 21 11:01 /dev/console
 > SunWave1 /# lsattr /dev/console
 > lsattr: Invalid argument While reading flags on /dev/console
 > 
 > Two other FS in /dev have some problems, too. But I think that is right.
 > 
 > SunWave1 /# chattr -R -SAadiscu /dev/
 > chattr: Inappropriate ioctl for device while reading flags on /dev//pts
 > chattr: Inappropriate ioctl for device while reading flags on /dev//shm
 > 
 > All the files in /proc show the same.
 > 
 > Here comes a little positive example, I think.
 > 
 > SunWave1 /# lsattr /tmp/
 > ----------X-j /tmp//xwlog
 > --------B-X-j /tmp//kde-nuetzel
 > ------------- /tmp//dcop6SKhoM
 > ---------D-Ej /tmp//YaST2.tdir
 > ----------XEj /tmp//ksocket-root
 > --------B-X-j /tmp//mcop-nuetzel
 > --------B--Ej /tmp//kde-root
 > --------B-X-j /tmp//ksocket-nuetzel
 > --------B--Ej /tmp//INSTALL
 > --------BD-Ej /tmp//modules.conf.-
 > ---------DX-j /tmp//vi.recover
 > --------BD-Ej /tmp//mcop-root
 > ------------j /tmp//lost+found
 > --------BD-Ej /tmp//modules.conf
 > 
 > What next?
 > 
 > Thanks,
 > 	Dieter
 > 
 > PS Have you read about the latest ACL discussion on LKML?

Yes, but Hans thinks we shouldn't do ACL reiserfs 3.x and concentrate on
v4 in stead. You can try to persuade him though. Same for extended
attributes.

Nikita.

