Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275790AbRJNRXl>; Sun, 14 Oct 2001 13:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275811AbRJNRXb>; Sun, 14 Oct 2001 13:23:31 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:33428 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S275790AbRJNRXY>; Sun, 14 Oct 2001 13:23:24 -0400
Date: Sun, 14 Oct 2001 20:23:36 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mount --bind and -o [re: nosuid/noexec/nodev handling]
Message-ID: <20011014202336.T1074@niksula.cs.hut.fi>
In-Reply-To: <20011014191218.Q1074@niksula.cs.hut.fi> <Pine.GSO.4.21.0110141217000.6026-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0110141217000.6026-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Oct 14, 2001 at 12:20:34PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Oct 2001, Ville Herva wrote:
> 
> $ mount --bind -o nosuid,noexec,ro /bin /tmp/test
> $ mount --bind -o nosuid,noexec,ro /bin /tmp/test
> $ mount --bind -o remount,nosuid,noexec,ro /tmp/test

Ignore the that, sorry.

For simplicity's sake, I changed the dirs in the above example. In reality
the situation was more like this:

/mnt1 and /mnt2 are separate fs's.

/mnt2/test1 is symlink to /mnt1/directory

then 

mount --bind -o ro /mnt2/test1 /mnt2/test2
mount --bind -o remount,ro /mnt2/test2

but it seems I'm longer able to duplicate that either. (The reason I was
able to duplicate it in the first place was propably that the first hanging
mount process kept /mnt2/test1 somehow busy and I retried with mount --bind
-o ro /mnt2/test1 /mnt2/test3.)

I'll drop you a note if I figure out how to reproduce it.

BTW: This should be reproducible (for what it's worth):

$ mount
(...)
/dev/hde1 on /mnt/ext2-2 type reiserfs (rw,noatime,nodiratime)
$ touch /mnt/ext2-2/a
$ rm /mnt/ext2-2/a
$ mount --bind -o ro /mnt/ext2-2 /tmp/test
$ mount --bind -o remount,ro  /tmp/test           
$ mount
(...)
/dev/hde1 on /mnt/ext2-2 type reiserfs (rw,noatime,nodiratime)
/mnt/ext2-2 on /tmp/test type none (ro,bind)
$ touch /mnt/ext2-2/a
touch: /mnt/ext2-2/a: Read-only file system
$ umount /tmp/test
$ mount
(...)
/dev/hde1 on /mnt/ext2-2 type reiserfs (rw,noatime,nodiratime)
$ touch /mnt/ext2-2/a
touch: /mnt/ext2-2/a: Read-only file system
$ mount -o remount,rw /mnt/ext2-2
$ touch /mnt/ext2-2/a

 
-- v --

v@iki.fi
