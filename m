Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286146AbRLJCS6>; Sun, 9 Dec 2001 21:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286144AbRLJCSj>; Sun, 9 Dec 2001 21:18:39 -0500
Received: from mercury.ccmr.cornell.edu ([128.84.231.97]:56591 "EHLO
	mercury.ccmr.cornell.edu") by vger.kernel.org with ESMTP
	id <S286143AbRLJCSf>; Sun, 9 Dec 2001 21:18:35 -0500
From: Daniel Freedman <freedman@ccmr.cornell.edu>
Date: Sun, 9 Dec 2001 21:18:34 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: NFS stale mount after chroot...
Message-ID: <20011209211834.A13340@ccmr.cornell.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011209205707.A13073@ccmr.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011209205707.A13073@ccmr.cornell.edu>; from freedman@ccmr.cornell.edu on Sun, Dec 09, 2001 at 08:57:08PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2001, Daniel Freedman wrote:
> 
> Hi,
> 
> It seems like I can generate reproducible stale NFS mounts by mounting
> a partition, chroot'ing into that mount, immediately exiting the
> chroot, and then finding myself unable to unmount the NFS partition.
> I'm pretty sure I've confirmed that nothing is using the partition
> (both with fuser and lsof) and even tried to force umount the
> partition (which seems like it should definitely umount it, rather
> than returning with the same "device is busy" errors), to no avail.
> The only method which I've used that seems to be able to get rid of
> this NFS mount, is to reboot the NFS client, and clearly that's not a
> good one at all.  If I'm missing something obvious here, my apologies
> in advance.  Also, if there's any further information I can provide,
> I'd be happy to help.  The dump of my procedure follows this message.
> 
> Thanks again and take care,
> Daniel

Arggg... (Continuing above, appending to previous email's client
output, and sorry for leaving off some info...)

Here's my general system info, as well as a counterpoint successful
attempt (to hopefully narrow the search area) at unmounting the same
NFS fs, the only difference is that I didn't do a chroot into that
mount in the interim.  Hope this helps as well.

Take care,
Daniel


--------
NFS Client:
________


feynman:/var/space/freedman# uname -a 
Linux feynman 2.4.16 #1 SMP Wed Nov 28 12:48:20 EST 2001 i686 unknown
feynman:/var/space/freedman# cat /boot/config-2.4.16 |grep NFS
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NCPFS_NFS_NS=y
feynman:/var/space/freedman# cat /proc/sys/kernel/tainted 
0
feynman:/var/space/freedman# lsmod
Module                  Size  Used by    Not tainted
r128                   91608   1 
emu10k1                58880   0  (unused)
sound                  56940   0  [emu10k1]
soundcore               4036   7  [emu10k1 sound]
ac97_codec              9760   0  [emu10k1]
nfs                    73692   1 
lockd                  48704   1  [nfs]
sunrpc                 65108   1  [nfs lockd]
eepro100               17584   1 
rtc                     6296   0  (autoclean)
unix                   16004  19  (autoclean)
ide-disk                6880   8  (autoclean)
ide-probe-mod           8096   0  (autoclean)
ide-mod               132876   8  (autoclean) [ide-disk ide-probe-mod]
ext2                   32960   5  (autoclean)
feynman:/var/space/freedman# mount -t nfs newton:/var/tftpboot-NFS/ ./node1/
feynman:/var/space/freedman# cat /proc/mounts 
/dev/root.old /initrd cramfs rw 0 0
/dev/root / ext2 rw 0 0
proc /proc proc rw 0 0
devpts /dev/pts devpts rw 0 0
/dev/hda5 /boot ext2 rw 0 0
/dev/hda7 /usr ext2 rw 0 0
/dev/hda8 /var ext2 rw 0 0
/dev/hda12 /var/space ext2 rw 0 0
newton:/home /home nfs rw,v3,rsize=8192,wsize=8192,hard,intr,udp,lock,addr=newton 0 0
newton:/var/tftpboot-NFS/ /var/space/freedman/node1 nfs rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=newton 0 0
feynman:/var/space/freedman# cd node1/
feynman:/var/space/freedman/node1# ls  
bin  boot  cdrom  dev  etc  floppy  home  initrd  lib  mnt  opt  proc  root  sbin  tmp  usr  var  vmlinuz
feynman:/var/space/freedman/node1# id
uid=0(root) gid=0(root) groups=0(root)
feynman:/var/space/freedman/node1# cd ..
feynman:/var/space/freedman# umount /var/space/freedman/node1/
feynman:/var/space/freedman# cat /proc/mounts 
/dev/root.old /initrd cramfs rw 0 0
/dev/root / ext2 rw 0 0
proc /proc proc rw 0 0
devpts /dev/pts devpts rw 0 0
/dev/hda5 /boot ext2 rw 0 0
/dev/hda7 /usr ext2 rw 0 0
/dev/hda8 /var ext2 rw 0 0
/dev/hda12 /var/space ext2 rw 0 0
newton:/home /home nfs rw,v3,rsize=8192,wsize=8192,hard,intr,udp,lock,addr=newton 0 0
feynman:/var/space/freedman# 


-- 
Daniel A. Freedman
Laboratory for Atomic and Solid State Physics
Department of Physics
Cornell University
