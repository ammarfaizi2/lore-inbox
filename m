Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262308AbRFBXzp>; Sat, 2 Jun 2001 19:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262313AbRFBXzf>; Sat, 2 Jun 2001 19:55:35 -0400
Received: from hera.cwi.nl ([192.16.191.8]:9980 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262308AbRFBXzW>;
	Sat, 2 Jun 2001 19:55:22 -0400
Date: Sun, 3 Jun 2001 01:54:43 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106022354.BAA182685.aeb@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: symlink_prefix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This evening I needed to work on a filesystem of a non-Linux OS,
full of absolute symlinks. After mounting the fs on /mnt, each
symlink pointing to /foo/bar in that filesystem should be
regarded as pointing to /mnt/foo/bar.

Since doing ls -ld on every component of every pathname was
far too slow, I made a small kernel wart, where a mount option
-o symlink_prefix=/pathname would cause /pathname to be prepended
in front of every absolute symlink in the given filesystem
(when the symlink is followed). That works satisfactorily.

Remain the questions:
(i) is there already a mechanism that would achieve this?
(ii) if not, do we want something like this in the kernel?

There is already a vaguely similar (and much uglier) wart,
namely that of "altroot". It is really ugly - requires a path
set at kernel compile time. And the scope is different.
Instead of all processes and a single filesystem and symlinks only,
altroot affects a single process and all filesystems and all paths.

I do not immediately see a common generalization of these two.

Andries

