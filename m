Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265104AbSJRUUK>; Fri, 18 Oct 2002 16:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265200AbSJRUUK>; Fri, 18 Oct 2002 16:20:10 -0400
Received: from mail.gmx.de ([213.165.64.20]:11432 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S265104AbSJRUUI>;
	Fri, 18 Oct 2002 16:20:08 -0400
Message-ID: <3DB06E3D.8050704@gmx.net>
Date: Fri, 18 Oct 2002 22:25:33 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2002-Q4@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.1) Gecko/20020826
X-Accept-Language: de, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Alexander Viro <viro@math.psu.edu>, Tigran Aivazian <tigran@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Forced umount
References: <Pine.LNX.3.95.1021018151840.150A-100000@chaos.analogic.com>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Fri, 18 Oct 2002, Carl-Daniel Hailfinger wrote:
> [SNIPPED,,,]
> 
>>To put it another way: Is there any chance to umount / cleanly if / is local
>>and /smbserver is a mounted remote SMB filesystem where the network link to
>>the SMB server just went down? (Without waiting half an hour for a timeout.)
>>
> You don't need to unmount a network drive (or any drive)
> from a mount-point on a file-system before you umount that
> file-system!
> 
> In other words, if I have quark:/tmp mounted on /tmp, I can
> umount / without unmounting quark:/tmp. 
> 
 > [SNIPPED]

Does not work here.

# mount /dev/fd0 /floppy/
# mount /dev/hda1 /floppy/test/
# umount /floppy/
umount: /media/floppy: device is busy
# touch /floppy/foo
umount -f /floppy/
umount2: Device or resource busy
umount: /dev/fd0: not mounted
umount: /media/floppy: Illegal seek
# touch /floppy/foo2
# mount
/dev/fd0 on /floppy type vfat (rw,sync)
/dev/hda1 on /floppy/test type vfat (rw)

In other words, your suggested method does not work here. (Kernel 2.4.18, 
util-linux-2.11n)

# mount -o remount,ro /floppy/
/dev/fd0 on /floppy type vfat (ro,sync)
/dev/hda1 on /floppy/test type vfat (rw)

This, however, seems to work.

Regards,

Carl-Daniel

