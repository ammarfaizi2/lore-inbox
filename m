Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269061AbRHBSPm>; Thu, 2 Aug 2001 14:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269018AbRHBSPc>; Thu, 2 Aug 2001 14:15:32 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:27917 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S269057AbRHBSPU>; Thu, 2 Aug 2001 14:15:20 -0400
Date: Thu, 2 Aug 2001 19:37:50 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: intermediate summary of ext3-2.4-0.9.4 thread
Message-ID: <20010802193750.B12425@emma1.emma.line.org>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	"Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <20010801170230.B7053@redhat.com> <20010802110341.B17927@emma1.emma.line.org> <01080219261601.00440@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <01080219261601.00440@starship>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Aug 2001, Daniel Phillips wrote:

[file name must be flushed on fsync()]
> I don't know why it is hard or inefficient to implement this at the VFS 
> level, though I'm sure there is a reason or this thread wouldn't 
> exist.  Stephen, perhaps you could explain for the record why sys_fsync 
> can't just walk the chain of dentry parent links doing fdatasync?  Does 
> this create VFS or Ext3 locking problems?  Or maybe it repeats work 
> that Ext3 is already supposed to have done?

Well, the course was that I asked whether ext3 would do synchronous
directory updates, and some people jumped in and said that one should
fsync() the parent directory, however, since we figure from SUS, that's
invalid.

After some forth and back, we finally figured that at least ext2 is
implementing fsync() improperly.

So this part is covered.

The other thing is, that Linux is the only known system that does
asynchronous rename/link/unlink/symlink -- people have claimed it might
not be the only one, but failed to name systems.

So we need to assume that Linux is the only system that does
asynchronous rename/link/unlink/symlink, however a directory fsync() is
believed to be rather expensive.

Still, some people object to a dirsync mount option. But this has been
the actual reason for the thread - MTA authors are refusing to pamper
Linux and use chattr +S instead which gives unnecessary (premature) sync
operations on write() - but MTAs know how to fsync().

> The prescription for symlinks is, if you want them safely on disk you 
> have to explicitly fsync the containing directory.

Yes, and it doesn't matter, since MTAs don't use symlinks (symlinks
waste inodes on most systems).

-- 
Matthias Andree
