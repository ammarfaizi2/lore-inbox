Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274085AbRISPBW>; Wed, 19 Sep 2001 11:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274086AbRISPBM>; Wed, 19 Sep 2001 11:01:12 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:57105 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S274085AbRISPBD>; Wed, 19 Sep 2001 11:01:03 -0400
Date: Wed, 19 Sep 2001 11:02:52 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@portland.hansa.lan>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.9-ac12 - problem mounting reiserfs (parse error?)
Message-ID: <Pine.LNX.4.33.0109191053400.1244-100000@portland.hansa.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I've compiled 2.4.9-ac12 and it has problems mounting reiserfs partitions.

This forks fine:

mount /dev/hda6 /usr/local

but "mount /dev/hda6" doesn't work if I have this in /etc/fstab:

/dev/hda6    /usr/local    reiserfs defaults  0 0

It appears that "defaults" is confusing some code in the kernel.  Here are
more results:

# mount -t reiserfs -o defaults /dev/hda6 /usr/local
reiserfs kgetopt: there is not option
mount: wrong fs type, bad option, bad superblock on /dev/hda6,
       or too many mounted file systems
# mount -t reiserfs -o rw /dev/hda6 /usr/local
reiserfs kgetopt: there is not option
mount: wrong fs type, bad option, bad superblock on /dev/hda6,
       or too many mounted file systems
# mount -t reiserfs -o bogus /dev/hda6 /usr/local
reiserfs kgetopt: there is not option bogus
mount: wrong fs type, bad option, bad superblock on /dev/hda6,
       or too many mounted file systems

As you see, invalid options are distinguished ("there is not option
bogus", as opposed to "there is not option"), but all options are
considered invalid.

"reiserfs kgetopt: there is not option" appears on the console and in the
dmesg output, it's not coming from mount.

RedHat 7.1, i686, mount-2.11b-3 (from RedHat).

No problems with 2.4.9-ac10.  I haven't tried 2.4.9-ac12.

I hope to send fix soon.  Sorry, but I'm writing it in hurry to alert
others that 2.4.9-ac12 is not quite usable, at least with reiserfs.

-- 
Regards,
Pavel Roskin

