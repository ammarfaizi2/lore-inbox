Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262903AbSJGGtS>; Mon, 7 Oct 2002 02:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262904AbSJGGtS>; Mon, 7 Oct 2002 02:49:18 -0400
Received: from angband.namesys.com ([212.16.7.85]:27008 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S262903AbSJGGtR>; Mon, 7 Oct 2002 02:49:17 -0400
Date: Mon, 7 Oct 2002 10:54:55 +0400
From: Oleg Drokin <green@namesys.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [STUPID TESTCASE] ext3 htree vs. reiserfs on 2.5.40-mm1
Message-ID: <20021007105455.A4429@namesys.com>
References: <20021001195914.GC6318@stingr.net> <20021001204330.GO3000@clusterfs.com> <20021004195315.A14062@namesys.com> <20021004170935.GX3000@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20021004170935.GX3000@clusterfs.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Oct 04, 2002 at 11:09:35AM -0600, Andreas Dilger wrote:
> > > As a result, if the size of the directory + inode table blocks is larger
> > > than memory, and also larger than 1/4 of the journal, you are essentially
> > > seek-bound because of random block dirtying.
> > > You should see what the size of the directory is at its peak (probably
> > > 16 bytes * 300k ~= 5MB, and add in the size of the directory blocks
> > > (128 bytes * 300k ~= 38MB) and make the journal 4x as large as that,
> > > so 192MB (mke2fs -j -J size=192) and re-run the test (I assume you have
> > > at least 256MB+ of RAM on the test system).
> > Hm. But all of that won't help if you need to read inodes from disk first,
> > right? (until that inode allocation in chunks implemented, of course).
> Ah, but see the follow-up reply - increasing the size of the journal as
> advised improved the htree performance to 15% and 55% faster than
> reiserfs for creates and deletes, respectively:

Yes, but that was the case with warm caches, as I understand it.
Usually you cannot count that all inodes of large file set are already present
and should not be read.

> > > What is very interesting from the above results is that the CPU usage
> > > is _much_ smaller for ext3+htree than for reiserfs.  It looks like
> > This is only in case of deletion, probably somehow related to constant item
> > shifting when some of the items are deleted.
> Well, even for creates it is 19% less CPU.  The re-tested wall-clock

I afraid other parts of code might have contributed there.
Like setting s_dirt way more often than needed.

Bye,
    Oleg
