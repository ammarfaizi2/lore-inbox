Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262682AbRGCKAn>; Tue, 3 Jul 2001 06:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262614AbRGCKAY>; Tue, 3 Jul 2001 06:00:24 -0400
Received: from relay.dera.gov.uk ([192.5.29.49]:39949 "HELO relay.dera.gov.uk")
	by vger.kernel.org with SMTP id <S262389AbRGCKAQ>;
	Tue, 3 Jul 2001 06:00:16 -0400
Subject: Re: [Ext2-devel] Re: [UPDATE] Directory index for ext2
From: Tony Gale <gale@syntax.dera.gov.uk>
To: Theodore Tso <tytso@valinux.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Andreas Dilger <adilger@turbolinux.com>,
        Folkert van <f.v.heusden@ftr.nl>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net, Alexander Viro <viro@math.psu.edu>
In-Reply-To: <20010626194919.J537@think.thunk.org>
In-Reply-To: <200106251951.f5PJpOYN025503@webber.adilger.int>
	<01062600253207.01008@starship>  <20010626194919.J537@think.thunk.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 03 Jul 2001 11:00:14 +0100
Message-Id: <994154414.4699.1.camel@syntax.dera.gov.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Right, I've now disabled every grsecurity kernel config option, apart
from the overarching "Getrewted Kernel Security" one - indicating the
problem is in one of the non #ifdef parts of the patch. Could this be a
problem:

diff -ruN linux/fs/namei.c linux/fs/namei.c
--- linux/fs/namei.c    Sat May 19 18:02:45 2001
+++ linux/fs/namei.c    Tue May 29 01:23:36 2001
@@ -1851,8 +1963,6 @@
        error = vfs_rename(old_dir->d_inode, old_dentry,
                                   new_dir->d_inode, new_dentry);
        unlock_kernel();
-
-       dput(new_dentry);
 exit4:
        dput(old_dentry);
 exit3:

Thanks

-tony


On 26 Jun 2001 19:49:19 -0400, Theodore Tso wrote:
> On Tue, Jun 26, 2001 at 12:25:32AM +0200, Daniel Phillips wrote:
> > > This is only true without the COMPAT_DIR_INDEX flag.  Since e2fsck _needs_
> > > to know about every filesystem feature, it will (correctly) refuse to touch
> > > such a system for now.  You could "tune2fs -O ^FEATURE_C4 /dev/hdX" to
> > > turn of the COMPAT_DIR_INDEX flag and let e2fsck go to town.  That will
> > > break all of the directory indexes, I believe.
> > 
> > This is what he wants, a workaround so he can fsck.  However, the above 
> > command (on version 1.2-WIP) just gives me:
> > 
> >    Invalid filesystem option set: ^FEATURE_C4
> > 
> > Maybe he should just edit the source so it doesn't set the superblock flag 
> > for now.
> 
> I haven't had a chance to analyze the directory index format to see if
> an-dirindexing-ignorant e2fsck could do any damage to the index.  It's
> probably the case as long as the filesystem isn't corrupted, simply
> modifying e2fsck to ignore the compatibility flag won't hurt.  But
> it's certainly not something I would recommend for any kind of
> production operation.
> 
> 						- Ted
> 


