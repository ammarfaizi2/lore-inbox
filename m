Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263485AbRF3U3Q>; Sat, 30 Jun 2001 16:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263918AbRF3U3G>; Sat, 30 Jun 2001 16:29:06 -0400
Received: from MORGOTH.MIT.EDU ([18.238.2.157]:34058 "EHLO MORGOTH.MIT.EDU")
	by vger.kernel.org with ESMTP id <S263485AbRF3U3A>;
	Sat, 30 Jun 2001 16:29:00 -0400
Message-Id: <200106301041.f5UAfCVM012803@morgoth.mit.edu>
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: Soft updates for 2.5?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 30 Jun 2001 05:41:11 -0500
From: Alex Khripin <akhripin@morgoth.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
There was a discussion in October, 2000, about the Granger and McKusick paper 
on soft updates for the BSD FFS. Reading the thread, nothing conclusive seemed
to come out of it.
The paper is available at  http://www.pdos.lcs.mit.edu/~ganger/papers/CSE-TR-25
4-95/
The code for the BSD implementation is available there as well.
The general idea of the paper is to prevent filesystem corruption due to
interrupted writes of circular dependencies. The general principle is, that if
there is a circular metadata dependency between two blocks A, and B, caused
by operations C and D, where C requires A to be changed before B, and D,
which comes after C, requires B to be changed after A. This occurs in many
metadata operations. To do this, soft updates undo the operation D in-memory,
making block A' and B', which only have operation C applied to them. Then
A' is written to disk, and then B' is written do disk. The operation is then
redone in memory. Thus, the disk is still consistent, and the in-memory image
is still the same. If the system is interrupted before B is written, there are
minor inconsistencies, like allocated data blocks not belonging to a file, and
an incorrect file size, but no inconsistencies that can cause further 
corruption
if untreated. These problems can be fixed quickly without a long fsck.
Soft updates offer a viable alternative to journaling, and require no changes
to the physical filesystem layout.
A soft-update ext2 filesystem can keep more metadata in memory without having
to sync for fear of errors.
This is not intended to replace journaling filesystems, like reiserfs, because
those have optimizations like B-trees, which cannot be implemented on ext2.
However, this would significantly improve the reliability and speed of ext2.
-Alex Khripin


