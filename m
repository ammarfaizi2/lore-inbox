Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWCMWE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWCMWE4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWCMWE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:04:56 -0500
Received: from smtp-out.google.com ([216.239.45.12]:37400 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932488AbWCMWEz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:04:55 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:mime-version:
	content-type:content-transfer-encoding:content-disposition;
	b=gqwzyuKT8/vWbMyB5nzjKXaNKj6CEzt9Gf2txZULLjZj0rdjSEqHjHxaj3/xdJ5SI
	LooX/9T0QBwl+J2jW7YyA==
Message-ID: <4517d1380603131404n21617a67lbf9553a01dd3570f@mail.google.com>
Date: Mon, 13 Mar 2006 14:04:43 -0800
From: "Masoud Sharbiani" <masouds@google.com>
To: akpm@osdl.org
Subject: ext2_readdir failure
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While using 2.6.15.6, I've seen ext2_readdir() fail from time to time
with the 'zero length directory entry' error, when there are several
processes are actively creat(2)ing and unlink(2)ing files from a
directory.

The test program tarball is available from
http://masoud.ir/ext2test.tgz (opened tarball at
http://masoud.ir/ext2test/) and consists of a creator (which creates
files with random names and random lengths in a tight loop as fast as
it can) and an eraser (which tries to remove all of the files in that
directory) and the usual /bin/rm, which tries to remove the directory
(and all files within) where eraser and creator are playing in.
It also happens with 2.6.12, 2.6.16-rc5 and 2.6.15-rc6-gc33d4568. This
problem does *not* happen in 2.4.32 kernel.
----
rm: cannot remove directory `data': Directory not empty
rm: cannot remove directory `data': Directory not empty
rm: cannot remove directory `data': Directory not empty
rm: cannot remove directory `data': Directory not empty
rm: cannot remove directory `data': Directory not empty
rm: cannot remove directory `data': Directory not empty
rm: cannot remove directory `data': Directory not empty
rm: cannot remove directory `data': Directory not empty
rm: cannot remove directory `data': Directory not empty
EXT2-fs error (device hdc1): ext2_readdir: zero-length directory entry
Something bad happened.: Input/output error
----
  The machine in question is a dual p3 machine  (866MHz) with 384 megs
of ram and IDE harddrives. I've tried the same test programs over ext3
and reiserfs for comparison, and it doesn't happen. I have tried the
test program on several other harddrives (different size, cable,
controller) and on different machines (Dual Opteron) and architectures
(amd64), and I am still seeing the bug, which means that ext2fs is
buggy.
on next reboot, e2fsck checks the filesystem and finds no errors, even
though it has been marked 'contains errors'.

To test, go into an area and untar the test tarball, make and run ./cmd.sh.
cheers,
Masoud Sharbiani
PS: Please CC me, as I am not on the list.
