Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262702AbRFCAt1>; Sat, 2 Jun 2001 20:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262703AbRFCAtS>; Sat, 2 Jun 2001 20:49:18 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:40378 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262702AbRFCAtF>;
	Sat, 2 Jun 2001 20:49:05 -0400
Date: Sat, 2 Jun 2001 20:49:03 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: symlink_prefix
In-Reply-To: <UTC200106022354.BAA182685.aeb@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0106022036200.25668-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 3 Jun 2001 Andries.Brouwer@cwi.nl wrote:

> This evening I needed to work on a filesystem of a non-Linux OS,
> full of absolute symlinks. After mounting the fs on /mnt, each
> symlink pointing to /foo/bar in that filesystem should be
> regarded as pointing to /mnt/foo/bar.
> 
> Since doing ls -ld on every component of every pathname was
> far too slow, I made a small kernel wart, where a mount option
> -o symlink_prefix=/pathname would cause /pathname to be prepended
> in front of every absolute symlink in the given filesystem
> (when the symlink is followed). That works satisfactorily.
> 
> Remain the questions:
> (i) is there already a mechanism that would achieve this?
> (ii) if not, do we want something like this in the kernel?
> 
> There is already a vaguely similar (and much uglier) wart,
> namely that of "altroot". It is really ugly - requires a path
> set at kernel compile time. And the scope is different.
> Instead of all processes and a single filesystem and symlinks only,
> altroot affects a single process and all filesystems and all paths.
> 
> I do not immediately see a common generalization of these two.

altroot should be buried, not generalized. It was a mistake and
we will be better off forgetting about that nightmare instead of
trying to design something around it.

Absolute symlinks... Dunno. _If_ we want that at all, we probably
want it on per-mountpoint basis. However, that opens a door to
_really_ ugly feature requests. E.g. "if symlink starts with
/foo - replace it with /mnt/bar, but if it starts with /foo/baz -
replace with /mnt/splat instead".

I can see how to implement per-mountpoint variant. However, I'm
less than enthusiastic about the API side of that and about the
ugliness it will lead to. It smells like a wrong approach. And
no, I don't see a good one right now.

As for the API... How would you pass that option? Yet another
mount(2) argument?

