Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273781AbRIXDp3>; Sun, 23 Sep 2001 23:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273783AbRIXDpU>; Sun, 23 Sep 2001 23:45:20 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:32016 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S273781AbRIXDpK>; Sun, 23 Sep 2001 23:45:10 -0400
Message-ID: <3BAEAC52.677C064C@zip.com.au>
Date: Sun, 23 Sep 2001 20:45:22 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Lehmann <aaronl@vitelus.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.10 + ext3
In-Reply-To: <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com> <1001280620.3540.33.camel@gromit.house> <9om4ed$1hv$1@penguin.transmeta.com>,
		<9om4ed$1hv$1@penguin.transmeta.com> <20010923193008.A13982@vitelus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann wrote:
> 
> On Mon, Sep 24, 2001 at 02:06:05AM +0000, Linus Torvalds wrote:
> > We'll merge ext3 soon enough.. As RH seems to start using it more and
> > more, there's more reason to merge it into the standard kernel too.
> >
> > So don't worry. It will happen.
> 
> Kinda OT, but ext3 is often treated more like a new file system than
> an extension of ext2. I'm wondering if this is a good thing. On the
> machines where I use it I have to compile both ext3 and ext2 (because
> it would be foolish to not have ext2 support) into the kernel.
> Theoretically, is there any reason why the codebases can't be
> integrated, allowing you mount ext2 FS' without journalling using only
> the ext3 code, and not requring a copy of its ancestor ext2 in the
> kernel? Or is there a way already?

It has been discussed - this is something which Andreas is interested
in, and the ext3<->JBD layer was abstracted out with the intention
that it would be easy to disable all the journalling stuff at runtime,
so we essentially mount the filesystem in ext2-mode.

Also, we currently have some unused overhead for read-only mounts - the
kjournald thread is started, but doesn't do anything in readonly mode.

So yes, it would be nice if an ext3-only kernel could drive ext2
filesystems, but not super-important.

As for the other part of your suggestion: make ext2 "obsolete":
I don't think so.  ext3 is wickedly complex, and ext2 is the
reference filesystem for Linux.  It could be argued (at length) that
the VFS and block layers were designed for, and are almost part of
ext2.

New developments such as metadata-in-pagecache and O_DIRECT
file access were relatively straightforward to develop for
ext2, and are relatively horrid for ext3 - the developers of those
features wouldn't have appreciated having all the journalling
and ordering goop getting in their way.
