Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130415AbQK0NNh>; Mon, 27 Nov 2000 08:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131102AbQK0NNQ>; Mon, 27 Nov 2000 08:13:16 -0500
Received: from hera.cwi.nl ([192.16.191.1]:29675 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S130415AbQK0NM5>;
        Mon, 27 Nov 2000 08:12:57 -0500
Date: Mon, 27 Nov 2000 13:42:51 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Peter Cordes <peter@llama.nslug.ns.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: access() says EROFS even for device files if /dev is mounted RO
Message-ID: <20001127134251.A8164@veritas.com>
In-Reply-To: <20001126233522.A436@llama.nslug.ns.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001126233522.A436@llama.nslug.ns.ca>; from peter@llama.nslug.ns.ca on Sun, Nov 26, 2000 at 11:35:22PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2000 at 11:35:22PM -0400, Peter Cordes wrote:

>  While doing some hdparm hacking, after booting with init=/bin/sh, I noticed
> that open(1) doesn't work when / is mounted read only.

Already long ago open(1) was renamed to openvt(1), so it may be that
have a very old version. See a recent kbd or console-tools.

> access("/dev/tty2", R_OK|W_OK)          = -1 EROFS (Read-only file system)

>  However, this is wrong.  You _can_ write to device files on read-only
> filesystems.  (open shouldn't bother calling access(), but the kernel should
> definitely give the right answer!)

You misunderstand the function of access(). The standard says

[EROFS] write access shall fail if write access is requested
        for a file on a read-only file system

It does not look at whether you ask write access to a directory
or a special device file (and whether the filesystem was mounted nodev or not).

So, probably you found a flaw in openvt: the use of access is almost always
a bug - it doesnt tell you what you want to know. You may send me a patch
if you want to.

On the other hand, on recent kernels access() doesnt fail in this situation.
That is a kernel bug, I suppose. Will investigate later.

Andries - aeb@cwi.nl
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
