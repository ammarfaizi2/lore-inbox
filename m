Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281137AbRKENF1>; Mon, 5 Nov 2001 08:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281135AbRKENFQ>; Mon, 5 Nov 2001 08:05:16 -0500
Received: from mons.uio.no ([129.240.130.14]:61840 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S281128AbRKENFJ>;
	Mon, 5 Nov 2001 08:05:09 -0500
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] ramfs/tmpfs readdir()
In-Reply-To: <3BE58883.844058@colorfullife.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 05 Nov 2001 14:05:00 +0100
In-Reply-To: <3BE58883.844058@colorfullife.com>
Message-ID: <shspu6xz7ur.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Manfred Spraul <manfred@colorfullife.com> writes:

     > Content-Type: text/plain; charset=us-ascii
     > Content-Transfer-Encoding: 7bit

    >>
    >> Note that other filesystems would already enjoy having a
    >> d_offset in the dentry: it allows for various other
    >> optimizations (ie making "unlink()" a O(1) operation, by not
    >> having to search the directory).
    >>
     > The dentry structure already contains 2 members for filesystem
     > use (d_time and d_fsdata), is a third member really required?

It could be useful. For NFS, we're also looking for 64-bits in which
to store the parent directory's mtime. This is needed in order to
improve the dentry revalidation heuristics.

Ultimately, though, allowing the filesystem to allocate dentries
itself on its own slab might be a preferable manner to accomodate the
need for these private fields. IOW to allow one to allocate

   struct nfs_dentry { 
        struct dentry dentry;
        ... private fields ....
   };

Cheers,
  Trond
