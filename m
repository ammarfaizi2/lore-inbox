Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129584AbRBYTCw>; Sun, 25 Feb 2001 14:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129589AbRBYTCm>; Sun, 25 Feb 2001 14:02:42 -0500
Received: from storm.ca ([209.87.239.69]:5831 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id <S129587AbRBYTC3>;
	Sun, 25 Feb 2001 14:02:29 -0500
Message-ID: <3A99569F.98C64B29@storm.ca>
Date: Sun, 25 Feb 2001 14:01:51 -0500
From: Sandy Harris <sandy@storm.ca>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en,fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] per-process namespaces for Linux
In-Reply-To: <Pine.GSO.4.21.0102251048280.25245-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:

> > Have you thought about supporting .tar.gz into ramfs? Creating custom
> > boot images would be simpler.
> 
> *uh*. It's definitely easier to do than it used to be, but I'm seriously
> sceptical about adding more cruft into the thing. ...
> 
> (I presume that you mean "unpacking tar.gz into initrd/floppy-loaded ramdisk"
> and not "adding into ramfs a loader of tarballs" - the latter is out of
> question, as far as I'm concerned;

Yes, indeed.

> such code belongs to do_mounts.c if it belongs anywhere at all)
> 
> IOW, look into init/do_mounts.c - that's the right place to do that
> stuff.

Methinks there are at least two possibilities that could do everything we
might need here without unnecessary complications.

One is just mount a ramdisk and extract a tarball into its root. Yes, this has
some problems -- how do you load tar when you haven't set up your root? -- but
I suspect they can be solved. At worst, this would involve some strictly limited
kluge to do that.

A better approach might be to find or invent a generic compressed file system.
Given that, you just build a compressed root, copy an image of it into ramdisk
and let the compressed FS driver handle it from there. I suspect such a driver
might be useful elsewhere as well. Does one exist?
