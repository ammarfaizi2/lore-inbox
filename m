Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbWBMAqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWBMAqf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 19:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWBMAqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 19:46:35 -0500
Received: from ms-smtp-03-smtplb.tampabay.rr.com ([65.32.5.133]:48025 "EHLO
	ms-smtp-03.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751505AbWBMAqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 19:46:34 -0500
Message-ID: <43EFD6E4.60601@cfl.rr.com>
Date: Sun, 12 Feb 2006 19:46:28 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: Nicolas George <nicolas.george@ens.fr>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem for mobile hard drive
References: <20060212150331.GA22442@clipper.ens.fr>
In-Reply-To: <20060212150331.GA22442@clipper.ens.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas George wrote:
> Hi.
> 
> I am about to buy a mobile hard drive (actually, a FireWire/USB box and a
> normal hard drive), and it raises the question of which filesystem to put on
> it. I am not wondering which of ext3, reiserfs, XFS or JFS is best, but more
> basically whether I should use a Linux/Unix-style filesystem or the horrible
> FAT.
> 
> The drawbacks of FAT are numerous and well-known: poor efficiency with big
> files, fragmentation, bad handling of file names, lack of robustness, and
> worst of all, the 4 Go limit. On the other hand, FAT gives the possibility
> to easyly read the drive on non-Unix systems (I know there are ext2 and
> reiserfs readers for windows, I do not know for XFS or JFS, but at the worst
> it should be possible to do something with colinux).
> 

If by FAT you mean FAT16, then yes, you have an 8 GB limit for the 
entire filesystem.  Fat32 on the other hand, can handle much more and so 
should be suitable in this aspect.  Fragmentation is also a property not 
of the filesystem, but of Microsoft's filesystem drivers.  I'm fairly 
sure that the linux fat implementations do not use absurdly stupid 
allocation algorithms that lead to lots of fragmentation.

> All these elements are rather feeble, but the Unix-style filesystems have a
> big drawback as mobile filesystems: they store UIDs. UIDs make sense inside
> a given system, but not across systems. On the most annoying case, I can
> have my disk automatically mounted on a system where I am not root, and all
> my files unreadable because they belong to another user.

This can be overcome with the UDF filesystem by using the uid and gid 
mount options, allowing the files to appear to be owned by the correct 
local user.  It would be nice if the other filesystems were patched to 
allow such options as well.


> 
> Since big mobile mass-storage devices which require efficient filesystems
> will become more and more common, I think this problem should be addressed.
> Someone suggested to me to use some sort of network filesystem (NFS or SMB),
> and its UID mapping facility. That should work, but that is rather an ugly
> solution, and that is not something that can be done in five minutes while
> visiting a friend.
> 

Network filesystems are not on disk filesystems, so they have nothing to 
do with this discussion; you can't format a disk as "nfs" or "smb".

> I believe that we lack an option at the VFS to completely override file
> ownership of a filesystem. But maybe there are other solutions.

I agree.  I recently submitted a patch fixing a bug in the udf 
filesystem so it correctly uses the uid and gid mount options to 
translate the ownership of files owned on disc by id -1 to the values 
you specify.  It would be nice if you could also specify that should be 
done for all files, not just those owned by nobody, and if all 
filesystems allowed you to do this.

> 
> Did someone already think in depths about this issue?
> 
> 
> Regards,
> 

