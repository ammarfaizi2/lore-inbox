Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129230AbRBLJtl>; Mon, 12 Feb 2001 04:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129261AbRBLJtc>; Mon, 12 Feb 2001 04:49:32 -0500
Received: from ns.suse.de ([213.95.15.193]:16648 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129230AbRBLJtY>;
	Mon, 12 Feb 2001 04:49:24 -0500
To: Rogerio Brito <rbrito@iname.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
In-Reply-To: <E14S01O-0004Su-00@the-village.bc.nu> <oupvgqhkn8f.fsf@pigdrop.muc.suse.de> <20010212001757.C4457@iname.com>
From: Andi Kleen <ak@suse.de>
Date: 12 Feb 2001 10:49:17 +0100
In-Reply-To: Rogerio Brito's message of "12 Feb 2001 03:23:14 +0100"
Message-ID: <oupr914kz8i.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogerio Brito <rbrito@iname.com> writes:

> On Feb 11 2001, Andi Kleen wrote:
> > The reiserfs nfs problem in standard 2.4 is very simple -- it'll
> > barf as soon as you run out of file handle/inode cache. Any workload
> > that accesses enough files in parallel can trigger it.
> 
> 	I'm just trying to evaluate if I should use reiserfs here or
> 	not: is this phenomenon that you describe above happening
> 	independently of whether I choose the knfsd or userspace nfsd?

This should be all covered extensively in the reiserfs FAQ and list archives, 
here a last time:

It only applies to knfsd, but unfsd unfortunately has different problems
with reiserfs. It makes assumptions about the inode space by the underlying
filesystem by assuming that it can encode a dev_t in upper bits. Reiserfs
unlike ext2 periodically cycles through the full 31bit of inode values, and
after some weeks on a busy file system unfsd starts to complain about 
conflicts. There is a patch at ftp.suse.com:/pub/people/ak/nfs/unfsd*
that works around the problem when you specify --no-cross-mounts (but 
you cannot export trees of multiple file systems then with a single mount
anymore) 

Please also note that the patch also adds a rather obscure bug, which triggers
very seldom (patch partly exists, but not really tested yet)

Another alternative is to use knfsd with Chris Mason's 2.4 knfsd patches.


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
