Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262109AbSJDPrt>; Fri, 4 Oct 2002 11:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262111AbSJDPrt>; Fri, 4 Oct 2002 11:47:49 -0400
Received: from angband.namesys.com ([212.16.7.85]:48003 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S262109AbSJDPrq>; Fri, 4 Oct 2002 11:47:46 -0400
Date: Fri, 4 Oct 2002 19:53:15 +0400
From: Oleg Drokin <green@namesys.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [STUPID TESTCASE] ext3 htree vs. reiserfs on 2.5.40-mm1
Message-ID: <20021004195315.A14062@namesys.com>
References: <20021001195914.GC6318@stingr.net> <20021001204330.GO3000@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20021001204330.GO3000@clusterfs.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Oct 01, 2002 at 02:43:30PM -0600, Andreas Dilger wrote:

> As a result, if the size of the directory + inode table blocks is larger
> than memory, and also larger than 1/4 of the journal, you are essentially
> seek-bound because of random block dirtying.
> You should see what the size of the directory is at its peak (probably
> 16 bytes * 300k ~= 5MB, and add in the size of the directory blocks
> (128 bytes * 300k ~= 38MB) and make the journal 4x as large as that,
> so 192MB (mke2fs -j -J size=192) and re-run the test (I assume you have
> at least 256MB+ of RAM on the test system).

Hm. But all of that won't help if you need to read inodes from disk first,
right? (until that inode allocation in chunks implemented, of course).

BTW, in case of inode allocation in chunks attached to directory blocks,
you won't get any benefit in case if application creates file in some
tempoarry dir and then rename()s it to its proper place, or am I missing
something?

> What is very interesting from the above results is that the CPU usage
> is _much_ smaller for ext3+htree than for reiserfs.  It looks like

This is only in case of deletion, probably somehow related to constant item
shifting when some of the items are deleted.

Bye,
    Oleg
