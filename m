Return-Path: <linux-kernel-owner+w=401wt.eu-S932637AbWLSCEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbWLSCEL (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 21:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbWLSCEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 21:04:11 -0500
Received: from [85.204.20.254] ([85.204.20.254]:57973 "EHLO megainternet.ro"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932637AbWLSCEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 21:04:10 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Andrei Popa <andrei.popa@i-neo.ro>
Reply-To: andrei.popa@i-neo.ro
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
In-Reply-To: <20061218175449.3c752879.akpm@osdl.org>
References: <1166314399.7018.6.camel@localhost>
	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>
	 <20061217154026.219b294f.akpm@osdl.org> <1166460945.10372.84.camel@twins>
	 <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	 <1166466272.10372.96.camel@twins>
	 <Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
	 <1166468651.6983.6.camel@localhost>
	 <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
	 <1166471069.6940.4.camel@localhost>
	 <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	 <Pine.LNX.4.64.0612181230330.3479@woody.osdl.org>
	 <1166476297.6862.1.camel@localhost>
	 <Pine.LNX.4.64.0612181426390.3479@woody.osdl.org>
	 <1166485691.6977.6.camel@localhost>
	 <Pine.LNX.4.64.0612181559230.3479@woody.osdl.org>
	 <1166488199.6950.2.camel@localhost>
	 <Pine.LNX.4.64.0612181648490.3479@woody.osdl.org>
	 <20061218172126.0822b5d2.akpm@osdl.org>
	 <1166492691.6890.12.camel@localhost>
	 <20061218175449.3c752879.akpm@osdl.org>
Content-Type: text/plain
Organization: I-NEO
Date: Tue, 19 Dec 2006 04:04:02 +0200
Message-Id: <1166493842.6906.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > If all of test_clear_page_dirty() has been commented out then the page will
> > > never become clean hence will never fall out of pagecache, so unless Andrei
> > > is doing a reboot before checking for corruption, perhaps the underlying
> > > data on-disk is incorrect, but we can't see it.
> > 
> > if I do a sync and echo 1 > /proc/sys/vm/drop_caches
> 
> OK, that works.
> 
> >  does the reboot is
> > still necesary ?
> 
> It might be necessary to reboot in this case - if we're leaving the
> pagecache dirty, writing to drop_caches won't remove it.  And you probably
> won't be able to get a clean reboot either.
> 
> > > 
> > > Andrei, how _are_ you running this test?    What's the exact sequence of steps?
> > > 
> > > In particular, are you doing anything which would cause the corrupted file
> > > to be evicted from memory, thus forcing a read from disk?  Such as
> > > unmounting and then remounting the filesystem?
> > 
> > I boot linux, I start rtorrent and start the download, while it's
> > downloading I start evolution and i check my mail(my mbox is very large,
> > several hundered megabytes), I close evolution(I use evolution just to
> > have another application witch uses the filesystem and the memory), I
> > start evolution again. I start firefox. The download is complete.
> > Rtorrent says if the hash is good or not. I do a "unrar t qwe.rar" to
> > test that all 84 downloaded rar files are ok and see the result.
> > 
> > > 
> > > The point of my question is to check that the data is really incorrect
> > > on-disk, or whether it is incorrect in pagecache.

I rebooted and the files are still broken after reboot(tested twice) so
the data is incorrect on disk.

> > > 
> > > Also, it'd be useful if you could determine whether the bug appears with
> > > the ext2 filesystem: do s/ext3/ext2/ in /etc/fstab, or boot with
> > > rootfstype=ext2 if it's the root filesystem.
> > 
> > I will test.

Will test In a couple of hours, I have some work to do...

> 
> ok, thanks.

