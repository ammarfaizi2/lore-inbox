Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265996AbUITEYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265996AbUITEYk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 00:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbUITEYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 00:24:39 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:9619 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265996AbUITEWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 00:22:48 -0400
Subject: Re: 2.6.9-rc2-mm1
From: Albert Cahalan <albert@users.sf.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton OSDL <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040920023452.GR9106@holomorphy.com>
References: <20040916024020.0c88586d.akpm@osdl.org>
	 <20040920023452.GR9106@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1095653925.4969.100.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 Sep 2004 00:18:45 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-19 at 22:34, William Lee Irwin III wrote:
> On Thu, Sep 16, 2004 at 02:40:20AM -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm1/
> > - Added lots of Ingo's low-latency patches
> > - Lockmeter doesn't compile.  Don't enable CONFIG_LOCKMETER.
> > - Several architecture updates
> 
> top(1) shows no tasks on sparc64.

It would be nice if I had such a box. I can't even
find a user account on one. I have 32-bit ppc, plus
non-root accounts on alpha, i386, and x86_64 boxes
with obsolete kernels.

> Large negative inode numbers appear
> to be showing up for /proc/stat and other /proc/ special files on
> 64-bit irrespective of endianness, and all processes appear to have the
> same inode number once again irrespective of endianness.

The inode numbering patch looks sane enough...

> It's unclear
> why top(1) enumerates tasks on x86-64 and does not do so on sparc64,
> unless 2.6.9-rc2-mm1 shows some behavior procps-3.2.3 is sensitive to
> that 3.2.1 is not, or some numbers are overflowing on 32-bit apps but
> not 64-bit ones (top(1) is 64-bit on x86-64 but 32-bit on sparc64)

In no place does procps itself care about ino_t.

Perhaps your 32-bit glibc chokes on 64-bit inode numbers.
If so, yuck. It's really sad that we have a zillion
versions of stat(), many with oversize dev_t, and still
we use 32-bit ino_t in many places.

Whether or not that's the problem...

1. install a 64-bit or bi-arch gcc
2. install a 64-bit libc
3. install a 64-bit ncurses
4. install a 64-bit procps

(suggestion: keep going until /bin is done)

That's pretty much it. The procps package goes to
great lengths to compile itself 64-bit, even passing
the -m64 option and installing to /lib64 as needed.
If you've broken this, you get to keep the pieces.

In other words: seriously unsupported

I see no reason why 32-bit SPARC users should have
to suffer the pain of running code bloated up to
handle 64-bit SPARC. The 32-bit SPARC hardware is
slow enough already. Just try to look a 32-bit SPARC
user in the eye and tell him "Your system should run
even slower now, so that my hot new hardware can keep
running old 32-bit executables meant for you"





