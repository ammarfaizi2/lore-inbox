Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262450AbSK0Mt1>; Wed, 27 Nov 2002 07:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262457AbSK0Mt1>; Wed, 27 Nov 2002 07:49:27 -0500
Received: from thunk.org ([140.239.227.29]:34771 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262450AbSK0MtZ>;
	Wed, 27 Nov 2002 07:49:25 -0500
Date: Wed, 27 Nov 2002 07:55:48 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Clemmitt Sigler <siglercm@jrt.me.vt.edu>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Alan Cox <Alan.Cox@linux.org>
Subject: Re: 2.4.20-rc3 ext3 fsck corruption -- tool update warning needed?
Message-ID: <20021127125547.GA7903@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Clemmitt Sigler <siglercm@jrt.me.vt.edu>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>, Alan Cox <Alan.Cox@linux.org>
References: <20021126024739.GA11903@think.thunk.org> <Pine.LNX.4.33L2.0211261042290.2368-100000@jrt.me.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0211261042290.2368-100000@jrt.me.vt.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2002 at 10:55:10AM -0500, Clemmitt Sigler wrote:
> The e2fsck run seemed to me to go normally.  It reported that it
> optimized some directories, but this has happened on other auto-fscks
> of my ext3 filesystems without corruption under earlier kernels.  (This
> is the first corruption I've seen in many, many years.)  But I didn't
> capture the messages :^( and they don't get written into
> /var/log/messages (that I could find).

Ah, ha.  I think I know what happened.

What version of e2fsprogs were you using?  If it was 1.28, that would
explain what you saw.  There was a fencepost error that could corrupt
directories when it was optimizing/rehashing them.  This bug was fixed
in in the next version, which was rushed out the door as a result of
this bug.  Fortunately, 1.28 didn't get adopted by any distro's as far
as I know, and not that many people downloaded and compiled e2fsprogs
1.28.

If you're not using the latest version of e2fsprogs, which is
e2fsprogs 1.32, I'd strongly suggest updating to it.  Version 1.28 is
just *so* three months ago.  :-)

						- Ted

P.S.  If you do have a directory which is corrupted by e2fsck 1.28, no
data is lost; it just created a directory entry which is too small, so
it triggers the sanity checks in the kernel.  Running e2fsck version
1.29 or later will unbork the directory.
