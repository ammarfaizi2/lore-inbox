Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267381AbUH1QUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267381AbUH1QUl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 12:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267389AbUH1QMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 12:12:49 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:6627 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S267378AbUH1QLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 12:11:45 -0400
Date: Sat, 28 Aug 2004 12:11:14 -0400
To: flx@msu.ru, Christophe Saout <christophe@saout.de>,
       Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@osdl.org>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com
Subject: Re: reiser4 plugins (was: silent semantic changes with reiser4)
Message-ID: <20040828161113.GA27278@delft.aura.cs.cmu.edu>
Mail-Followup-To: flx@msu.ru, Christophe Saout <christophe@saout.de>,
	Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@osdl.org>,
	Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
	reiserfs-list@namesys.com
References: <412D9FE6.9050307@namesys.com> <20040826014542.4bfe7cc3.akpm@osdl.org> <1093522729.9004.40.camel@leto.cs.pocnet.net> <20040826124929.GA542@lst.de> <1093525234.9004.55.camel@leto.cs.pocnet.net> <20040826130718.GB820@lst.de> <1093526273.11694.8.camel@leto.cs.pocnet.net> <20040826132439.GA1188@lst.de> <1093527307.11694.23.camel@leto.cs.pocnet.net> <20040828111807.GC6746@alias>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828111807.GC6746@alias>
User-Agent: Mutt/1.5.6+20040803i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 03:18:07PM +0400, Alexander Lyamin wrote:
> And I honestly dont understand whats the other Christoph's worries are about.

I honestly don't understand what all this 'grassroot' campaining is all
about. Very valid technical points have been made and mostly ignored.

The whole 'it breaks backups' noise is just that, noise.

- It breaks VFS locking rules.
- It pretends to provide a uniform way to store streams or metadata.
  However it only does so files and not for directories, symlinks,
  fifos, unix domain sockets, or device nodes, which makes it less than
  uniform.
- From what I saw in one part of the discussion, it allows for infinite
  depth recursion (file/metas/metas/metas/...). Some applications are
  going to have a lot of fun with that.

And finally,

- When reiserfs3 got merged, it introduced iget3 and read_inode2 in the
  VFS layer. Later on when I started to use them for Coda I almost
  immediately found serious consistency problems, resulting in the
  iget4_locked implementation in the 2.5 kernels.
  
  I don't think anyone ever fixed that race in reiser3. It should hit
  occasionally on concurrent lookups on SMP or preempt kernels. In 2.4,
  Coda needed a semaphore to prevent concurrency during the iget3 lookup
  until the new inode is actually initialized.

> Its got perfomance. Its there. It can emulate "conventional
> filesystem" behaviour, for legacy apps.

So does ramfs.

> Yes, I think it would be nice to have this infrastructure in VFS.
> Technically. But its not possible, cause of "committee clusterfuck".
> Socially. Stupidly.

It will get there, just consider it constructive criticism. If we can
help resolve or refute the technical issues, all the better. We might
even end up with improvements or extensions to the VFS or MM making life
easier for everyone.

Jan

