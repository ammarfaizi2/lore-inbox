Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281609AbRKPWlX>; Fri, 16 Nov 2001 17:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281604AbRKPWlN>; Fri, 16 Nov 2001 17:41:13 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:10244 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S281603AbRKPWlE>; Fri, 16 Nov 2001 17:41:04 -0500
Date: Fri, 16 Nov 2001 23:40:58 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: synchronous mounts
Message-ID: <20011116234058.B4415@emma1.emma.line.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3BF376EC.EA9B03C8@zip.com.au> <20011115214525.C14221@redhat.com> <3BF45B9F.DEE1076B@mandrakesoft.com> <20011116122855.C2389@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20011116122855.C2389@redhat.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2001, Stephen Tweedie wrote:

> If you want to sync _everything_, it's at least 5 seeks per write
> syscall when you're writing a new file: superblock, group descriptor,
> block bitmap, inode, data, and potentially inode indirect.
> 
> There's no point doing all that, especially since some of that data is
> redundant and will be rebuilt by e2fsck anyway after a crash.

The file system cannot judge on what's needed, neither can the file
system developer.

The developer however can offer the administrator
and/or application developer the corresponding interfaces. In the sense
of portability, however, it may be rather useful to correspond to BSD
semantics, so I vote to change sync and offer dirsync -- it might be
useful to use BSD nomenclature though and offer a synonymous noasync
option (which also has dirsync semantics as laid out in this thread
before).

It does not matter whether you look at BSD or Linux man pages, either
one documents "sync - All I/O to the file system should be done
synchronously." It should behave like documented. Let's not introduce
compatibility problems by fixing the documentation.

> Is it really such an important feature that we're willing to suffer a
> factor-of-100 or more slowdown for it?

It depends on the task. If the machine regularly reads data from an
external interface and records it to disk, like in a log, synchronous
data writes may be important.

BTW, Wietse Venema was dazzled when he got to know that Linux values its
syslog (defaults to all-synchronous writes) more than its mail (defaults
to all-asynchronous writes that not even a file fsync() rectifies).

> Not-scalable is doing 5000 seeks to write a 4MB file.  

If that's what the admin wants, let him do so.

> what the inode is like during the write.  All that is desired in that
> example is fsync-on-close, and it is insane to implement
> fsync-on-close by writing every single block of the file
> synchronously.

Yes, but you cannot generalize this example.

> appropriate.  If we want that, lets add it as a new option, but I
> don't see the benefit in making o- sync do all file data writes 100%
> synchronously.

Compatibility and reliability are good points.

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
