Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261517AbSJQMO7>; Thu, 17 Oct 2002 08:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbSJQMO7>; Thu, 17 Oct 2002 08:14:59 -0400
Received: from thunk.org ([140.239.227.29]:30674 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261517AbSJQMO6>;
	Thu, 17 Oct 2002 08:14:58 -0400
Date: Thu, 17 Oct 2002 08:20:56 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Posix capabilities
Message-ID: <20021017122056.GB13573@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	linux-kernel@vger.kernel.org
References: <20021016154459.GA982@TK150122.tuwien.teleweb.at> <20021017032619.GA11954@think.thunk.org> <20021017120526.GC6014@TK150122.tuwien.teleweb.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017120526.GC6014@TK150122.tuwien.teleweb.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 02:05:26PM +0200, Stefan Schwandter wrote:
> Ah, ok... I thought that things work like this: the capabilities support
> already is in the kernel, and to give an app a particular capability,
> one has to add a particalar extended attribute to the application
> executable. So I'm wrong here it seems?

First of all, you can't use a standard user extended attribute, since
anyone with write access to the file will be allowed to set the
extended attribute.  This isn't good if you're going to be granting
root-privileged capabilities to executables!

So what would be needed is code to set and get a special system xattr
(much like the POSIX ACL patches do) that is specifically set up for
capabilities, and with appropriate authorization access checks when
setting the capability xattr.  In order to do that, we would have to
decide on the actual on-disk format encoding for capabilities (and one
which hopefully is extensible so that when additional capabilities are
added in the future, existing filesystems with capability attributes
remain backwards compatible).  Finally, the ELF loader would have be
modified to read the capability extended attribute from the
executable, decode the xattr, and then set the capability masks
appropriately.

The code which I posted is a prerequisite for the above work, yes.
It's just that there's quite a bit of additional work that would be
necessary.  (And this is all aside from the question about whether or
not it's a good idea for most system administrators to attempt to use
such a system once it was fully implemented.)

						- Ted
