Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292857AbSC1M2S>; Thu, 28 Mar 2002 07:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292957AbSC1M2I>; Thu, 28 Mar 2002 07:28:08 -0500
Received: from pc132.utati.net ([216.143.22.132]:31377 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S292857AbSC1M2E>; Thu, 28 Mar 2002 07:28:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: linux-kernel@vger.kernel.org
Subject: ssh won't work from initial ram disk in 2.4.18
Date: Thu, 28 Mar 2002 07:28:05 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020328124257.99FD54FF@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using a 2.4.18 kernel and ssh 3.0.2, and I'm trying to run ssh from the 
initrd, and it's refusing to work.  The exact same setup works booted from a 
small partition, but if I take a tarball of that filesystem and dump it into 
a ramdisk, ssh always fails to authenticate.  (Public key or password, it 
doesn't matter.  When I run it from sh in initrd, it doesn't even prompt me 
for a password, just prints out three failure messages and exits.  The same 
setup from /dev/hda1 works just fine...)

Both filesystems (/dev/hda1 and the initrd.img) are formatted ext3.  (Because 
ext2 support is a seperate driver I'd have to compile in, the journal size is 
1 meg.  The initrd is 16 megs, and yes I upped the default ramdisk size to 16 
megs.  The box itself has 128 megs of ram.)  Modules are disabled.

(In case you're wondering, I'm running dhcpcd, which is happy, followed by a 
variant of "ssh 10.0.0.1 cat yourbrain.sh | /bin/bash".  The reason I need to 
make it run from a ramdisk is that the script I'm trying to suck accross will 
repartion the box, format the partitions, and untar a big tarball into it.  
It's quick and dirty a system manufacturing thing.  sfdisk won't reread the 
partition table if you have any partitions from the drive, and a reboot 
between "partition" and "format" stages is, um, problematic.)

As I said, it works fine when it's NOT running from an initial ramdisk.  ssh 
connects and has no problem transferring data.  But from a ramdisk, instant 
failure, either password or public key pair.  I don't even get to ENTER my 
password.  (Run /bin/bash and try to ssh as root.  It WILL prompt me about 
the box's fingerprint not being recognized, but it immediately goes 
"Permission denied, please try again." three times for the password without 
lettiing me type anything.)

If this is an ssh problem I'll be happy to go bug those guys, but why would 
it be different from initrd than from an actual mounted partition?  
(Permissions are the same, I checked.)

If somebody wants a tarball of this test case, drop me an email.  It's only a 
couple megabytes...

Rob
