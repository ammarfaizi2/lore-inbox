Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282297AbRKXAG1>; Fri, 23 Nov 2001 19:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282298AbRKXAGS>; Fri, 23 Nov 2001 19:06:18 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:53009 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S282297AbRKXAGL>;
	Fri, 23 Nov 2001 19:06:11 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: viro@math.psu.edu
Date: Sat, 24 Nov 2001 01:05:56 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.5.0 breakage even with fix?
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <A0AA3407CDC@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Nov 01 at 0:54, viro@math.psu.edu wrote:
> Hi Al,
>   I'm now running 2.5.0 with fix you posted - and now during dselect
> run I received:
> 
> Unpacking replacement manpages ...
> EXT2-fs error (device ide0(3,3)): ext2_check_page: bad entry in directory
>   #3801539: unaligned directory entry - offset=0, inode=1801675088,
>   rec_len=26465, name_len=101
> Remounting filesystem read-only
> rm: cannot remove directory `/var/lib/dpkg/tmp.ci': Read-only file system

Well, ncheck finished.

debugfs: stat /var/lib/dpkg/tmp.ci
Inode: 3801539  Type: directory  Mode: 0755  Flags: 0x0  Generation: 537829
User:     0   Group:   0    Size: 4096
File ACL: 0   Directory ACL: 0
Links: 2  Blockcount: 8
Fragment: Address: 0   Number: 0   Size: 0
ctime: 0x3bfede00 -- Sat Nov 24 00:38:40 2001
atime: dtto
mtime: dtto
BLOCKS:
(0):7603845
TOTAL: 1

debugfs: cat /var/lib/dpkg/tmp.ci
Package: diff
Version: 2.7-28
Section: base
Priority: required
Architecture: i386
...

It does not look like a directory to me. Unfortunately, as we
do not have coherent /dev/hda3 cache, I have no idea how to read
real contents of /var/lib/dpkg/tmp.ci, but
ls -l /var/lib/dpkg/tmp.ci/ reemited error message about
ext2-fs error, so I think that it is real problem, and my tmp.ci directory
contains some file contents instead. And I'm 100% sure that
/var/lib/dpkg/tmp.ci was created with patched kernel :-(
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
