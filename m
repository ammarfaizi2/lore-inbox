Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbULPSgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbULPSgD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 13:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbULPSgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 13:36:03 -0500
Received: from main.gmane.org ([80.91.229.2]:20971 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261976AbULPSfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 13:35:51 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Dan Stromberg <strombrg@dcs.nac.uci.edu>
Subject: recovering data from a corrupt ext3?
Date: Thu, 16 Dec 2004 10:20:44 -0800
Message-ID: <pan.2004.12.16.18.20.43.438752@dcs.nac.uci.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: tesuji.nac.uci.edu
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have an ext3, under lvm3, on a Fedora Core 3 system, that:

1) Is corrupt

2) Contains data I want back, including some financial records, some
opensource applications I was developing, my list of URL's for conversion
from HTML to palmdoc, and so on.

I've tried the usual: booting up, fsck'ing, fsck'ing with alternative
superblocks, running e2salvage, running e2extract...  But none are
providing satisfaction.  The fsck's give "invalid superblock" or "invalid
argument", running e2salvage apparently OOM'd with the message
"Terminated", and e2extract just listed a huge number of 0 length files. 
Also, when I boot from a Fedora Core 3 cdrom and let it try to mount my
filesystems, it 

When I boot up into
the FC3 rescue CD and let it try to find my fedora install, it gets really
confused.  More specifically, it says:

Searching for Fedora Core installations...

        0%              install exited abnormally -- received signal 15
                                kernel panic - not syncing: Out of
memory and no killable processes


If I remove "quiet" and add "single" to my boot options, I get:

EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: dm-0: orphan cleanup on readonly fs

...and there it hangs.




My questions are:

1) Is there a better tool for ext3 data recovery?

2) If there isn't, is there a document that provides an overview of the
ext3 on-disk filesystem structure, so that I might write a tool for doing
the recovery?  (I wrote one once for the atari 800 floppy disk filesystem).

3) Given that this ext3 is under LVM2, and that I haven't rearranged disk
blocks within LVM2 (say, by mucking with pv's, vg's or lv's), is it then
reasonably safe to conclude that the blocks of my ext3 are contiguous, as
they would be if they weren't under LVM2?

On the subject of question #2 immediately above, I'm primarily interested
in:

1) What kind of alignment assumptions can I make about the various data
structures?  EG, if I can assume that a bunch of directory entries always
start on a 512 byte boundary, that'll speed up directory entry hunting
considerably.

2) What are the relationships between the on-disk datastructures?  A tree
diagram that indicates 1-n, n-1, 1-1 and n-n relationships would probably
be really useful.  I believe I mostly grok the superblock, inode and
directory entry datastructures, but the block_group and fragment
structures are a relative unknown to me.  I am familiar with the idea of
"cylinder groups" though - is that basically what the "block_group" stuff
is about?

3) Are there any on-disk data structures that are strictly (or
mostly) contiguous? Or are the various pieces distributed throughout the
filesystem to minimize track to track seeking?  Or are none of the
datastructures contiguous, aside from some of the disk blocks belonging to
individual files?

Thanks!




