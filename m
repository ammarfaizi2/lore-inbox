Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282306AbRKXARI>; Fri, 23 Nov 2001 19:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282307AbRKXAQ5>; Fri, 23 Nov 2001 19:16:57 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:22656 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S282305AbRKXAPr>; Fri, 23 Nov 2001 19:15:47 -0500
Message-ID: <001001c1747d$05a073a0$f5976dcf@nwfs>
From: "Jeff Merkey" <jmerkey@timpanogas.org>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>, <viro@math.psu.edu>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <A0AA3407CDC@vcnet.vc.cvut.cz>
Subject: Re:       Re: 2.5.0 breakage even with fix?
Date: Fri, 23 Nov 2001 17:14:45 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am seeing file system corruption in NWFS in 2.5.0 with the patch.   It's
not a severe as
ext2 directly was, and is simply creating mirror mismatches between the FAT
and DIR
tables, and is easily recovered, but it is annoying.  I am also getting
"resource busy" during reboot when I try to reboot with a mounted NWFS
volume.

Jeff

----- Original Message -----
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
To: <viro@math.psu.edu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, November 23, 2001 6:05 PM
Subject: Re: 2.5.0 breakage even with fix?


> On 24 Nov 01 at 0:54, viro@math.psu.edu wrote:
> > Hi Al,
> >   I'm now running 2.5.0 with fix you posted - and now during dselect
> > run I received:
> >
> > Unpacking replacement manpages ...
> > EXT2-fs error (device ide0(3,3)): ext2_check_page: bad entry in
directory
> >   #3801539: unaligned directory entry - offset=0, inode=1801675088,
> >   rec_len=26465, name_len=101
> > Remounting filesystem read-only
> > rm: cannot remove directory `/var/lib/dpkg/tmp.ci': Read-only file
system
>
> Well, ncheck finished.
>
> debugfs: stat /var/lib/dpkg/tmp.ci
> Inode: 3801539  Type: directory  Mode: 0755  Flags: 0x0  Generation:
537829
> User:     0   Group:   0    Size: 4096
> File ACL: 0   Directory ACL: 0
> Links: 2  Blockcount: 8
> Fragment: Address: 0   Number: 0   Size: 0
> ctime: 0x3bfede00 -- Sat Nov 24 00:38:40 2001
> atime: dtto
> mtime: dtto
> BLOCKS:
> (0):7603845
> TOTAL: 1
>
> debugfs: cat /var/lib/dpkg/tmp.ci
> Package: diff
> Version: 2.7-28
> Section: base
> Priority: required
> Architecture: i386
> ...
>
> It does not look like a directory to me. Unfortunately, as we
> do not have coherent /dev/hda3 cache, I have no idea how to read
> real contents of /var/lib/dpkg/tmp.ci, but
> ls -l /var/lib/dpkg/tmp.ci/ reemited error message about
> ext2-fs error, so I think that it is real problem, and my tmp.ci directory
> contains some file contents instead. And I'm 100% sure that
> /var/lib/dpkg/tmp.ci was created with patched kernel :-(
>                                             Petr Vandrovec
>                                             vandrove@vc.cvut.cz
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

