Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131520AbRCNT6r>; Wed, 14 Mar 2001 14:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131517AbRCNT6j>; Wed, 14 Mar 2001 14:58:39 -0500
Received: from mg03.austin.ibm.com ([192.35.232.20]:21209 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S131513AbRCNT6c>; Wed, 14 Mar 2001 14:58:32 -0500
Message-ID: <3AAFCD2E.59A3A809@austin.ibm.com>
Date: Wed, 14 Mar 2001 13:57:34 -0600
From: Dave Kleikamp <shaggy@austin.ibm.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolinux.com>
CC: Alexander Viro <viro@math.psu.edu>,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>
Subject: Re: (struct dentry *)->vfsmnt;
In-Reply-To: <200103141945.f2EJjF410285@webber.adilger.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me start  with a disclaimer stating that it's been a few years since
I've worked with AIX, but this is what I believe happens.

mount itself doesn't do anything except read /etc/filesytems (AIX's
version of /etc/fstab).  LVM maintains the information primarily in the
ODM (yuck).  The utilities such as mkfs, mklv, chfs, etc. modify this
information in the ODM.  The exportvg command extracts the information
from the ODM (and /etc/filesystems?) and stores it somewhere in the
volume group.  Only then can the volume group be imported by another
system with the importvg command, which then populates the ODM and
/etc/filesystems.

Of course, I would NEVER suggest anything resembling AIX's ODM, but I do
think that the LVM is a reasonable place to store this kind of
information.

Andreas Dilger wrote:
> 
> David Kleikamp writes:
> > AIX stores all of this information in the LVM, not in the filesystem.
> > The filesystem itself has nothing to do with importing and exporting
> > volume groups.  Having the information stored as part of LVM's metadata
> > allows the utilities to only deal with LVM instead of every individual
> > file system.
> 
> So you are saying that mount(8) writes into a field in the LVM LVCB or
> something?  Might be possible on Linux LVM as well...
> 
> Cheers, Andreas
> --
> Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
>                  \  would they cancel out, leaving him still hungry?"
> http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

-- 
David J. Kleikamp
IBM Linux Technology Center
