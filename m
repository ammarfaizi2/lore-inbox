Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132691AbRAXXT3>; Wed, 24 Jan 2001 18:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133021AbRAXXTT>; Wed, 24 Jan 2001 18:19:19 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:53511 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S132691AbRAXXTC>; Wed, 24 Jan 2001 18:19:02 -0500
Date: Wed, 24 Jan 2001 18:19:03 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
To: <linux-kernel@vger.kernel.org>
Subject: Weird hidden /dev/audio on devfs
Message-ID: <Pine.LNX.4.30.0101241800390.1394-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm using 2.4.0-ac11 with devfs support. Something is very strange in the
way how devfs behaves with respect to OSS sound drivers.

devfsd version 1.3.10 is running. There is an entry "alias /dev/audio
/dev/sound" in modules.devfs, which is the default.

If the "sound" module is not loaded, there are no files named "audio"
under /dev:

[proski@fonzie /dev]$ ls -al audio
ls: audio: No such file or directory
[proski@fonzie /dev]$ ls -alR | grep audio
[proski@fonzie /dev]$

Now I load sound.o and strange things begin:

[proski@fonzie /dev]$ ls -al audio
lr-xr-xr-x    1 root     root           11 Jan 24 18:08 audio ->
sound/audio
[proski@fonzie /dev]$ ls -alR | grep audio
crw-rw--w-    1 root     root      14,   4 Dec 31  1969 audio
[proski@fonzie /dev]$

/dev/audio exists when named explicitly, but otherwise only
/dev/sound/audio can be found.

No sound-card specific modules are loaded at this point:

[proski@fonzie /dev]$ /sbin/lsmod
Module                  Size  Used by
sound                  60880   0 (unused)
soundcore               4240   2 [sound]
mga                    95424   1
agpgart                14080   3
floppy                 46384   0 (autoclean)
[proski@fonzie /dev]$

All relevant config files are here:
http://www.red-bean.com/~proski/sound_devfs/

Regards,
Pavel Roskin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
