Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131505AbRCNTch>; Wed, 14 Mar 2001 14:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131506AbRCNTc2>; Wed, 14 Mar 2001 14:32:28 -0500
Received: from mg03.austin.ibm.com ([192.35.232.20]:14807 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S131503AbRCNTcT>; Wed, 14 Mar 2001 14:32:19 -0500
Message-ID: <3AAFC708.752B2819@austin.ibm.com>
Date: Wed, 14 Mar 2001 13:31:20 -0600
From: Dave Kleikamp <shaggy@austin.ibm.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolinux.com>
CC: Alexander Viro <viro@math.psu.edu>,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>
Subject: Re: (struct dentry *)->vfsmnt;
In-Reply-To: <200103141726.f2EHQoj09856@webber.adilger.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AIX stores all of this information in the LVM, not in the filesystem. 
The filesystem itself has nothing to do with importing and exporting
volume groups.  Having the information stored as part of LVM's metadata
allows the utilities to only deal with LVM instead of every individual
file system.

Andreas Dilger wrote:
> 
> Al writes:
> > On Tue, 13 Mar 2001, Andreas Dilger wrote:
> >
> > > On AIX, it is possible to import a volume group, and it automatically
> > > builds /etc/fstab entries from information stored in the fs.  Having the
> > > "last mounted on" would have the mount point info, and of course LVM
> > > would hold the device names.
> >
> > Wait a minute. What happens if you bring /home from one box to another,
> > that already has /home? Corrupted /etc/fstab?

> For the same reason that the UUID and LABEL are stored in the superblock:
> you want this infomation kept with the filesystem and not anywhere else,
> otherwise it will quickly get out-of-date.  Wherever you mounted the
> filesystem last is where it would be mounted if you import the VG on
> another system.  You can obviously edit /etc/fstab afterwards if it is
> wrong, and then remount the filesystem(s), and this will store the
> correct mountpoint into the filesystem for the next vgimport.

-- 
David J. Kleikamp
IBM Linux Technology Center
