Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRADWIz>; Thu, 4 Jan 2001 17:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130024AbRADWIp>; Thu, 4 Jan 2001 17:08:45 -0500
Received: from zeus.kernel.org ([209.10.41.242]:2316 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129324AbRADWI3>;
	Thu, 4 Jan 2001 17:08:29 -0500
Date: Thu, 4 Jan 2001 22:04:33 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Andreas Dilger <adilger@enel.ucalgary.ca>,
        Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] Re: [RFC] ext2_new_block() behaviour
Message-ID: <20010104220433.T1290@redhat.com>
In-Reply-To: <20010103121609.C1290@redhat.com> <Pine.GSO.4.21.0101031051080.15658-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0101031051080.15658-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Jan 03, 2001 at 11:12:48AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 03, 2001 at 11:12:48AM -0500, Alexander Viro wrote:
> 
> On Wed, 3 Jan 2001, Stephen C. Tweedie wrote:
> 
> > Having preallocated blocks allocated immediately is deliberate:
> > directories grow slowly and remain closed most of the time, so the
> > normal preallocation regime of only preallocating open files and
> > discarding preallocation on close just doesn't work.
> 
> Erm. For directories we would not have the call of discard_prealloc()
> on close(2) - they have NULL ->release() anyway and for them it would
> happen only on ext2_put_inode(), i.e. upon the final dput(). Which would
> not happen while some descendent would stay in dcache.
> 
> IOW, if directory is really going to grow (which normally mean that we
> are busily writing into files in it or its subdirectories) we will not
> get discard_prealloc() until it's all over.

The problem with directories is that they don't always grow rapidly
like that.  Spool directories are perfect examples of directories
which grow sporadically over a long time, which is why we wanted
persistent preallocation.

The most common instance where that happens to regular files is the
case of log files, but those tend to be held open even while idle so
the preallocation persists anyway.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
