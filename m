Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276872AbRJCSBE>; Wed, 3 Oct 2001 14:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276874AbRJCSAz>; Wed, 3 Oct 2001 14:00:55 -0400
Received: from Expansa.sns.it ([192.167.206.189]:33800 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S276872AbRJCSAr>;
	Wed, 3 Oct 2001 14:00:47 -0400
Date: Wed, 3 Oct 2001 20:01:11 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: "sebastien.cabaniols" <sebastien.cabaniols@laposte.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [POT] Which journalised filesystem uses Linus Torvalds ? 
In-Reply-To: <GKMPCZ$IZh2dKhbICnp0WDXKHB6iO7OKoHwqOxmqj9XfriOC7PjHiIDA6bHi6xrImT@laposte.net>
Message-ID: <Pine.LNX.4.33.0110031924420.8511-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would bet that Linus is using ext2 :).

apart of this, everyone will give you difefrent suggestions.

basically ext3 can journal data, but this way is slower, and is a simple
ext2 with journal.

reiserFS is really interesting, is the most space effective, thanx to
B*Tree and the advanced hash techniques, but
actually journals just meta-data. The real point is that
reiserFS does a tree traversal every time it writes  4k block, and the it
puts one pointer at time inside of the tree. So the tree is balanced every
4k write, That is bad for very large files.

jfs, should be quite stable. is a very interesting technology, and
i know it very well from AIX (but the linux one comes from OS2).
it's very solid, quite fast, can journal also data (??).
The way jfs manages free data block group is very smart, altought it is
not an extent based FS (but leaf node are piece of bitmap instead of
extent).

xfs, I dislike the way they are isering a kind of double VFS, but i
understand that Irix buffer cache was developed with some xfs features in
mind, and so they need this pagebuf module, but i dislike it. I also
dislike the concept of per-group quota, but this is just my taste.
Anyway, I have to admit that on very big file xfs is very efficient.
On Irix 6.4 i found it to be a little slow with small files.

That is just my opinion, I am wayting for reiserFS 4.

On Wed, 3 Oct 2001, sebastien.cabaniols wrote:

> Hello lkml,
>
> With the availability of XFS,JFS,ext3 and ReiserFS I am a
> little
> lost and I don't know which one I should use for entreprise
> class
> servers.
>
> In terms of intergration into the kernel, functionnalities,
> stability
> and performance which one is the best for entreprise class
> servers
>
> I guess the begining of the answer is: it depends... on what
> you are doing
>
> So, what do you think if
>
> I want a database server
reiserFS
> or
> a supercomputer (HPC use)
jfs / ext3
> or
> a Linux KDE/GNOME desktop
ext2 :)
>
Luigi

