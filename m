Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282203AbRKWSUp>; Fri, 23 Nov 2001 13:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282202AbRKWSUf>; Fri, 23 Nov 2001 13:20:35 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:1524 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S282201AbRKWSUT>;
	Fri, 23 Nov 2001 13:20:19 -0500
Date: Fri, 23 Nov 2001 11:20:09 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: =?iso-8859-1?Q?Ra=FAlN=FA=F1ez_de_Arenas_Coronado?= 
	<dervishd@jazzfree.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Moving ext3 journal file
Message-ID: <20011123112009.V1308@lynx.no>
Mail-Followup-To: =?iso-8859-1?Q?Ra=FAlN=FA=F1ez_de_Arenas_Coronado?= <dervishd@jazzfree.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E167Fuw-00001K-00@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
In-Reply-To: <E167Fuw-00001K-00@DervishD>; from dervishd@jazzfree.com on Fri, Nov 23, 2001 at 01:58:54PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 23, 2001  13:58 +0100, RaúlNúñez de Arenas Coronado wrote:
>     Is there any problem on moving the /.journal file (even renaming
> it) so it doesn't lives on the root? I mean, maintaining its inode
> number, of course ;))

The name is irrelevant.  The kernel only accesses the journal by inode
number, and only once at boot time.  Rather than "renaming" it and
causing problems, you should just unmount the filesystem, and run
"e2fsck -f /dev/hdX" (with e2fsck 1.25) and it will hide it for you.

>     Anyway, ext3 shouldn't (just an idea) show the journal as a
> normal file. It may add some load on the kernel, because the inode
> number should be compared with that of the journal every time a file
> is accessed, but it's just a suggestion ;))

???? This doesn't make sense.  Having the .journal file places no load
on the system.  OK, when you do "ls -a /" it has to list an extra file,
but that is so little work as to be unnoticable.  Even with a hidden
journal, it is still in an inode with an inode number, it's just not
in a directory anywhere.

As to "comparing the inode number to that of the journal every time a
file is accessed" it appears you just don't understand how file access
works in the kernel.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

