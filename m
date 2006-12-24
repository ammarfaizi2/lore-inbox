Return-Path: <linux-kernel-owner+w=401wt.eu-S1752326AbWLXQqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbWLXQqE (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 11:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbWLXQqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 11:46:04 -0500
Received: from [85.204.20.254] ([85.204.20.254]:37718 "EHLO megainternet.ro"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752326AbWLXQqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 11:46:01 -0500
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
	corruption on ext3)
From: Andrei Popa <andrei.popa@i-neo.ro>
Reply-To: andrei.popa@i-neo.ro
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Gordon Farquharson <gordonfarquharson@gmail.com>,
       Martin Michlmayr <tbm@cyrius.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20061224043102.d152e5b4.akpm@osdl.org>
References: <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com>
	 <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com>
	 <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org>
	 <20061222100004.GC10273@deprecation.cyrius.com>
	 <20061222021714.6a83fcac.akpm@osdl.org> <1166790275.6983.4.camel@localhost>
	 <20061222123249.GG13727@deprecation.cyrius.com>
	 <20061222125920.GA16763@deprecation.cyrius.com>
	 <1166793952.32117.29.camel@twins>
	 <20061222192027.GJ4229@deprecation.cyrius.com>
	 <97a0a9ac0612240010x33f4c51cj32d89cb5b08d4332@mail.gmail.com>
	 <Pine.LNX.4.64.0612240029390.3671@woody.osdl.org>
	 <20061224005752.937493c8.akpm@osdl.org> <1166962478.7442.0.camel@localhost>
	 <20061224043102.d152e5b4.akpm@osdl.org>
Content-Type: text/plain
Organization: I-NEO
Date: Sun, 24 Dec 2006 18:45:51 +0200
Message-Id: <1166978752.7022.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-24 at 04:31 -0800, Andrew Morton wrote:
> On Sun, 24 Dec 2006 14:14:38 +0200
> Andrei Popa <andrei.popa@i-neo.ro> wrote:
> 
> > > - mount the fs with ext2 with the no-buffer-head option.  That means either:
> > > 
> > >   grub.conf:  rootfstype=ext2 rootflags=nobh
> > >   /etc/fstab: ext2 nobh
> > 
> > ierdnac ~ # mount
> > /dev/sda7 on / type ext2 (rw,noatime,nobh)
> > 
> > I have corruption.
> > 
> > > 
> > > - mount the fs with ext3 data=writeback, nobh
> > > 
> > >   grub.conf:  rootfstype=ext3 rootflags=nobh,data=writeback  (I hope this works)
> > >   /etc/fstab: ext2 data=writeback,nobh
> > 
> > ierdnac ~ # mount
> > /dev/sda7 on / type ext3 (rw,noatime,nobh)
> > 
> > ierdnac ~ # dmesg|grep EXT3
> > EXT3-fs: mounted filesystem with writeback data mode.
> > EXT3 FS on sda7, internal journal
> > 
> > I don't have corruption. I tested twice.
> 
> This is a surprising result.  Can you pleas retest ext3 data=writeback,nobh?

Yes, no corruption. Also tested only with data=writeback and had no
corruption.

