Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282305AbRKXAZ6>; Fri, 23 Nov 2001 19:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282312AbRKXAZw>; Fri, 23 Nov 2001 19:25:52 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:23031 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S282305AbRKXAYO>;
	Fri, 23 Nov 2001 19:24:14 -0500
Date: Fri, 23 Nov 2001 17:23:03 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.5.0 breakage even with fix?
Message-ID: <20011123172303.O1308@lynx.no>
Mail-Followup-To: Petr Vandrovec <VANDROVE@vc.cvut.cz>, viro@math.psu.edu,
	linux-kernel@vger.kernel.org
In-Reply-To: <A0A71547524@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <A0A71547524@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Sat, Nov 24, 2001 at 12:54:10AM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 24, 2001  00:54 +0000, Petr Vandrovec wrote:
>   I'm now running 2.5.0 with fix you posted - and now during dselect
> run I received:
> 
> Unpacking replacement manpages ...
> EXT2-fs error (device ide0(3,3)): ext2_check_page: bad entry in directory
>   #3801539: unaligned directory entry - offset=0, inode=1801675088,
>   rec_len=26465, name_len=101
> Remounting filesystem read-only
> rm: cannot remove directory `/var/lib/dpkg/tmp.ci': Read-only file system

Did you run e2fsck -f after running unpatched 2.4.15/2.5.0?  This may be
left-over garbage from the other problem.

> and system is obviously unusable. I'll probably reboot and run fsck again.
> If someone can show me how I can dump contents of some inode by number
> (and not by name) in debugfs, I can look into inode itself... I found
> only 'ncheck', to convert number to name, and this is running and running...

debugfs> stat <inum>
debugfs> dump <inum> /tmp/file


Note that you need to include the <> around the inode number.

> System was running 2.5.0 without patch for some time, but I followed
> your guidelines for rebooting:
> 
> fuser -k /
> sync
> mount -o remount,ro /
> sync
> reboot
> 
> After reboot fsck was NOT run, so it is possible that there
> might be some corruption - but I ran fsck on my non-root partition
> after boot, and it did not show any problems.

Ah, yes.  Definitely sounds like left over corruption.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

