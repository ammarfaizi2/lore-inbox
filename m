Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262498AbRENVTM>; Mon, 14 May 2001 17:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262499AbRENVSw>; Mon, 14 May 2001 17:18:52 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:13062 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262498AbRENVSk>; Mon, 14 May 2001 17:18:40 -0400
Message-ID: <3B004B90.5B2BD131@transmeta.com>
Date: Mon, 14 May 2001 14:18:08 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Andreas Dilger <adilger@turbolinux.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Re: Inodes]
In-Reply-To: <Pine.GSO.4.21.0105141700360.18112-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Mon, 14 May 2001, Andreas Dilger wrote:
> 
> > Just to clarify, this means that the "inode numbers" reported by an
> > msdos filesystem are a function of the disk-layout itself (i.e. they
> > are determined at mount time), and not numbers created when the file
> > is first accessed (AFAIK).
> 
> Wrong. open file. rename() it to another directory. truncate it to
> zero. write to it. ->i_ino must have stayed they same. _Nothing_
> on-disk that would be related to that file had stayed the same.
> FAT simply doesn't allow inode numbers as functions of disk layout.
> 

Correct.  At least at one time it used the offset of the directory entry
when that particular inode was last "seen" by the kernel... meaning that
when it finally dropped out of the inode cache, it would change inode
numbers.  I thought that was a reasonable (by no means perfect, though)
solution to a very sticky problem.

iso9660 also uses the offset of the directory entry, but iso9660
obviously doesn't have the problem of modifications.  It also means the
inode number is different if you mount a disk with Joliet (but not
RockRidge) or not, since Joliet uses a separate directory hierarchy.

	-hpa  

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
