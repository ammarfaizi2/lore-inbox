Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131687AbRCONNz>; Thu, 15 Mar 2001 08:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131688AbRCONNq>; Thu, 15 Mar 2001 08:13:46 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:4621 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S131680AbRCONNd>; Thu, 15 Mar 2001 08:13:33 -0500
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: Andreas Dilger <adilger@turbolinux.com>
cc: Matthew Wilcox <matthew@wil.cx>, Andreas Dilger <adilger@turbolinux.com>,
        Alexander Viro <viro@math.psu.edu>,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>
Message-ID: <CA256A10.00481064.00@d73mta03.au.ibm.com>
Date: Thu, 15 Mar 2001 18:29:40 +0530
Subject: Re: (struct dentry *)->vfsmnt;
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Because this is totally filesystem specific - why put extra knowledge
>of filesystem internals into mount?  I personally don't want it writing
>into the ext2 or ext3 superblock.  How can it possibly know what to do,
>without embedding a lot of knowledge there?  Yes, mount(8) can _read_
>the UUID and LABEL for ext2 filesystems, but I would rather not have it
>_write_ into the superblock.  Also, InterMezzo and SnapFS have the same
>on-disk format as ext2, but would mount(8) know that?
>
>There are other filesystems (at least IBM JFS) that could also take
>advantage of this feature, should we make mount(8) have code for each
>and every filesystem?  Yuck.  Sort of ruins the whole modularity thing.
>Yes, I know mount(8) does funny stuff for SMB and NFS, but that is a
>reason to _not_ put more filesystem-specific information into mount(8).
>

Since you've brought up this point.
I have wondered why Linux doesn't seem to yet have the option of a generic
user space filesystem type specific mount helper command. I recall having
seen code in mount(8) implementation to call mount.<fstype>, but its still
under an ifdef isn't it, except for smb or ncp perhaps ? (Hope I'm not
out-of-date on this)
Having something like that lets one stream-line userland filesystem
specific stuff like this, without having the generic part of mount(8) know
about it.

For example, in AIX, the association between type and the program for mount
helpers (and also for filesystem helpers for things like mkfs, fsck etc) is
configured in /etc/vfs, while SUN and HP look for them under particular
directory locations (by fstype name).

Actually, it'd be good to have this in such a way that if a specific helper
doesn't exist, default mount processing continues. This avoids the extra
work of writing such helpers for every new filesystem, unless we need
specialized behaviour there.



 Suparna Bhattacharya
  IBM Software Lab, India
  E-mail : bsuparna@in.ibm.com
  Phone : 91-80-5267117, Extn : 2525


