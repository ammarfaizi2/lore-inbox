Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283430AbRLINQh>; Sun, 9 Dec 2001 08:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283432AbRLINQ2>; Sun, 9 Dec 2001 08:16:28 -0500
Received: from stinky.trash.net ([195.134.144.50]:55010 "HELO stinky.trash.net")
	by vger.kernel.org with SMTP id <S283430AbRLINQL> convert rfc822-to-8bit;
	Sun, 9 Dec 2001 08:16:11 -0500
Date: Sun, 9 Dec 2001 14:16:09 +0100
From: Thomas Bader <thomasb@trash.net>
To: linux-kernel@vger.kernel.org
Subject: [BUG] data_access_exception during chroot()
Message-ID: <20011209141609.A13900@trash.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
Organization: Get your free UNIX account @ http://www.trash.net/
X-URL: <http://www.trash.net/~thomasb/>
X-Cool: get your free UNIX account @ http://www.trash.net/
X-PGP-Key: mailto <thomasb+pgpkey@trash.net> (automated reply)
X-Operating-System: SunOS 5.8 (sun4u)
X-WM: Enlightenment 0.16.5
X-Editor: Vim-600 http://www.vim.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I'm running 2.4.17-pre6 on my SUN Ultra1.  Further, I've got devfs, RAID and
LVM support in my kernel config.

Now I'm trying to chroot to a specific directory:

duke:~# mount
/dev/sda8 on / type ext2 (rw,errors=remount-ro,errors=remount-ro)
proc on /proc type proc (rw)
/dev/md/0 on /mnt type ext2 (rw)
duke:~# cat /proc/mdstat
Personalities : [raid1]
read_ahead 1024 sectors
md1 : active raid1 scsi/host0/bus0/target1/lun0/part2[1] scsi/host0/bus0/target]
      627648 blocks [2/2] [UU]

md0 : active raid1 scsi/host0/bus0/target1/lun0/part1[1] scsi/host0/bus0/target]
      3145664 blocks [2/2] [UU]

unused devices: <none>
duke:~# chroot --version
chroot (GNU sh-utils) 2.0.11
duke:~# chroot /mnt /bin/bash
data_access_exception: SFSR[0000000000801009] SFAR[fffff805b2bf6afc], going.
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
chroot(224): Dax
TSTATE: 0000000011009603 TPC: 0000000000503464 TNPC: 0000000000503468 Y: 070000d
g0: 0000000000000000 g1: fffee0058b199b00 g2: 0000000000000001 g3: fffee0058b19c
g4: fffff80000000000 g5: fffee0058b199b20 g6: fffff8002741c000 g7: 0000000000004
o0: 0000000000280108 o1: 0000000000000000 o2: fffff800276b60c0 o3: fffff80000ba0
o4: 0000000000000008 o5: 0000000000000001 sp: fffff8002741e891 ret_pc: fffff800c
l0: fffff80027a5d000 l1: fffff80027a5d448 l2: 00000000005aa400 l3: 0000000000002
l4: 0000000000000001 l5: fffff80024fa6da8 l6: fffff8002772f680 l7: 0000000000000
i0: fffed805b2bf6afc i1: 0000000000000000 i2: 0000000000000000 i3: 0000000000001
i4: 0000000000000000 i5: fffff80027a5d000 i6: fffff8002741e951 i7: 0000000000500
Caller[00000000005036c0]
l0: fffff80027a5d000 l1: fffff80027a5d448 l2: 00000000005aa400 l3: 0000000000002
l4: 0000000000000001 l5: fffff80024fa6da8 l6: fffff8002772f680 l7: 0000000000000
i0: fffed805b2bf6afc i1: 0000000000000000 i2: 0000000000000000 i3: 0000000000001
i4: 0000000000000000 i5: fffff80027a5d000 i6: fffff8002741e951 i7: 0000000000500
Caller[00000000005036c0]
Caller[00000000005059c0]
Caller[00000000004b9cd0]
Caller[00000000004b9dc0]
Caller[00000000004b9f90]
Caller[000000000046353c]
Caller[0000000000489a58]
Caller[0000000000477678]
Caller[00000000004779a8]
Caller[000000000048aa38]
Caller[000000000046bbe8]
Caller[000000000046c058]
Caller[000000000046c6cc]
Caller[000000000046966c]
Caller[000000000042f88c]
Caller[0000000000410674]
Caller[00000000700de224]
Instruction DUMP: 80a6c01c  02400038  8600ffdc <c4060000> 80a0a000  124ffff3  8
Killed
duke:~#

Cheers
-- 
  .-.   Thomas Bader · thomasb@trash.net.remove · http://www.t-bader.ch/  .-.
  oo|                                                                     oo|
 /`'\     Einen Unix-Shellaccount gibt es unter http://www.trash.net/    /`'\
(\_;/)       PGP Key-ID: 0x3A4B7F5D (RSA)  0x7584F5D8 (DSA/EG)          (\_;/)
