Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266038AbSKZCka>; Mon, 25 Nov 2002 21:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266053AbSKZCka>; Mon, 25 Nov 2002 21:40:30 -0500
Received: from thunk.org ([140.239.227.29]:53449 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S266038AbSKZCk3>;
	Mon, 25 Nov 2002 21:40:29 -0500
Date: Mon, 25 Nov 2002 21:47:39 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Clemmitt Sigler <siglercm@jrt.me.vt.edu>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Alan Cox <Alan.Cox@linux.org>
Subject: Re: 2.4.20-rc3 ext3 fsck corruption -- tool update warning needed?
Message-ID: <20021126024739.GA11903@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Clemmitt Sigler <siglercm@jrt.me.vt.edu>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>, Alan Cox <Alan.Cox@linux.org>
References: <Pine.LNX.4.33L2.0211242351001.2368-100000@jrt.me.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0211242351001.2368-100000@jrt.me.vt.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2002 at 12:12:55AM -0500, Clemmitt Sigler wrote:
> I'd been running 2.4.20-rc3 for two days.  While rebooting it tonight
> fsck.ext3 corrupted my / partition during an automatic fsck of the
> partition (caused by the maximal mount count being reached).  (I had
> backups so I was able to recover :^)  The symptoms were that some files
> like /etc/fstab and dirs like /etc/rc2.d disappeared -- not good.
> 
> My system is Debian Testing, with Debian e2fsprogs version
> 1.29+1.30-WIP-0930-1.  I use ext3 partitions with all options set to
> the defaults (ordered data mode).  This is an SMP system, in case
> that matters.  Please e-mail me for any other details that might help.
> 
> I'm wondering if this change between -rc1 and -rc2 might be a factor ->
> 
>    <tytso@think.thunk.org>
>            HTREE backwards compatibility patch.

Nope; I really doubt it.  All the HTREE compatibility patch does is
clear the INDEX_FL flag in a directory inode if the directory inode is
modified.  It's a very, very innocuous patch.  

> Upon rebooting to 2.4.19 (SMP kernel also), the system did another
> auto-fsck.ext3, this time on /usr.  I held my breath, but all went fine.
> This seems to me to narrow it down to a kernel/e2fsprogs incompatibility
> (but I'm not an expert).

Well, no; it could also be that some kind of filesystem corruption
either made the directories disappear, or caused e2fsck to believe
that the files needed to be removed or moved into lost+found.  There
are a million possible explanations, including a bug in a device
driver, the VM layer, or just pure coincidence.

Without some clear indication of what e2fsck actually printed we'd
only be speculating.

> If this is indeed the case, please put a LOUD WARNING in the kernel
> notes that some versions of e2fsprogs are incompatible.  HTH.

No, there shouldn't be any kind of compatibility problems.  All of the
various extensions to ext2/ext3 are all clearly marked with feature
flags in the superblock, and need to be explicitly enabled before they
take effect.

Can you can duplicate the problem?

						- Ted
