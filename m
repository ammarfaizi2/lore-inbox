Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289659AbSBNEXb>; Wed, 13 Feb 2002 23:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289655AbSBNEXW>; Wed, 13 Feb 2002 23:23:22 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:29198
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S289653AbSBNEXM>; Wed, 13 Feb 2002 23:23:12 -0500
Date: Wed, 13 Feb 2002 23:24:24 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
Subject: Re: XFS + rmap12e + 2.4.18-pre9
In-Reply-To: <Pine.LNX.4.40.0202120224240.3161-100000@coredump.sh0n.net>
Message-ID: <Pine.LNX.4.40.0202132321110.10816-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I will be releasing -shawn5 sometime this week, just too busy right now.

shawn5 will contain 2.4.18-pre9-ac3, 2.4.18-rc1 and fixes.

Shawn.

On Tue, 12 Feb 2002, Shawn Starr wrote:

> > Compile fails.  Apparently, 2.4.18-pre7-ac3 takes out the
> > constant for Q_RSQUASH and the switch statement that uses it,
> > but your patch keeps the reference in the switch statement
> > in fs/dquot.c.  I tried removing the case Q_RSQUASH from
> > dquot.c but it fails on link because sys_quotactl is defined
> > in both dquot.c and quota.c. :-/  Any suggestions as to which
> > one is the right one?  Compile output follows:
> >
> > gcc -D__KERNEL__
> > -I/disks/public/kernel/linux-2.4.18-pre9-xfs-shawn4/include  -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> > -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i586
> > -DKBUILD_BASENAME=dquot  -c -o dquot.o dquot.c
> > dquot.c: In function `vfsqops':
> > dquot.c:2050: warning: passing arg 4 of `get_quota' from incompatible
> > pointer type
> > dquot.c:2067: `Q_RSQUASH' undeclared (first use in this function)
> > dquot.c:2067: (Each undeclared identifier is reported only once
> > dquot.c:2067: for each function it appears in.)
> > dquot.c:2068: warning: implicit declaration of function
> > `quota_root_squash'
> > dquot.c:2076: warning: passing arg 5 of `set_dqblk' from incompatible
> > pointer type
> > make[2]: *** [dquot.o] Error 1
> > make[2]: Leaving directory
> > `/disks/public/kernel/linux-2.4.18-pre9-xfs-shawn4/fs'
> > make[1]: *** [first_rule] Error 2
> > make[1]: Leaving directory
> > `/disks/public/kernel/linux-2.4.18-pre9-xfs-shawn4/fs'
> > make: *** [_dir_fs] Error 2
> > Command exited with non-zero status 2
> >
> >
> > And then after commenting out the case:
> >
> > ld -m elf_i386  -r -o fs.o open.o read_write.o devices.o file_table.o
> > buffer.o super.o block_dev.o char_dev.o stat.o exec.o pipe.o namei.o
> > fcntl.o ioctl.o readdir.o select.o fifo.o locks.o dcache.o inode.o
> > attr.o bad_inode.o file.o iobuf.o dnotify.o filesystems.o namespace.o
> > seq_file.o quota.o dquot.o ext_attr.o posix_acl.o binfmt_script.o
> > binfmt_elf.o proc/proc.o partitions/partitions.o ext2/ext2.o
> > devfs/devfs.o nls/nls.o devpts/devpts.o
> > dquot.o: In function `sys_quotactl':
> > dquot.o(.text+0x3730): multiple definition of `sys_quotactl'
> > quota.o(.text+0x270): first defined here
> > ld: Warning: size of symbol `sys_quotactl' changed from 600 to 1070 in
> > dquot.o
> > make[2]: *** [fs.o] Error 1
> > make[2]: Leaving directory
> > `/disks/public/kernel/linux-2.4.18-pre9-xfs-shawn4/fs'
> > make[1]: *** [first_rule] Error 2
> > make[1]: Leaving directory
> > `/disks/public/kernel/linux-2.4.18-pre9-xfs-shawn4/fs'
> > make: *** [_dir_fs] Error 2
> > Command exited with non-zero status 2
> >
> > Tanner Lovelace
> > --
> > Tanner Lovelace | lovelace@wayfarer.org | http://wtl.wayfarer.org/
> > --*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--
> > GPG Fingerprint = A66C 8660 924F 5F8C 71DA  BDD0 CE09 4F8E DE76 39D4
> > GPG Key can be found at http://wtl.wayfarer.org/lovelace.gpg.asc
> > --*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--
> >  Those who are willing to sacrifice essential liberties for a little
> >  order, will lose both and deserve neither.  --  Benjamin Franklin
> >
> >  History teaches that grave threats to liberty often come in times
> >  of urgency, when constitutional rights seem too extravagant to
> >  endure.  --  Justice Thurgood Marshall, 1989
> >
>
>

