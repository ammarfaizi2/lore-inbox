Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263001AbRFCSSN>; Sun, 3 Jun 2001 14:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263693AbRFCRil>; Sun, 3 Jun 2001 13:38:41 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:65273 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263675AbRFCRTj>;
	Sun, 3 Jun 2001 13:19:39 -0400
Date: Sun, 3 Jun 2001 13:19:37 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: symlink_prefix
In-Reply-To: <UTC200106031636.SAA183957.aeb@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0106031310070.27673-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 3 Jun 2001 Andries.Brouwer@cwi.nl wrote:

> > Current interface had grown an impressive collection of warts.
> > Worse yet, you _can't_ put parsing into generic code.
> > There are filesystems that have a binary object as 'data'.
> 
> Yes, that was a very unfortunate decision, back in the good old times
> when nfs was implemented. And smb, ncp, coda followed nfs.
> 
> Nevertheless, there is no problem adding vfs_parse_mount_options().
> For example, one can have a flag FS_HAS_BINARY_MOUNT_DATA in
> the fs_flags field of the struct file_system_type that describes
> the filesystem type, and refrain from trying to parse the mount data
> when this bit is set.

We can kludge around anything. The question being, what for? It still
leaves ncp with its ioctls ugliness. It still treats device name
in a special way for no good reason - it _is_ an option, just like any
other. Hell, less generic than nosuid or read-only. It still leaves us
with cruft in flags. What for? To maintain binary compatibility with
one utility? We can leave the old interface in place and freeze it.


