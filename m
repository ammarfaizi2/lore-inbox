Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286712AbSBOEMB>; Thu, 14 Feb 2002 23:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286825AbSBOELw>; Thu, 14 Feb 2002 23:11:52 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:18147 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S286712AbSBOELj>;
	Thu, 14 Feb 2002 23:11:39 -0500
Date: Thu, 14 Feb 2002 23:11:38 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] new VFS documentation
Message-ID: <Pine.GSO.4.21.0202142246020.23441-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	First of all, since 2.5.5-pre1 there is an up-to-date guide for
porting filesystems from 2.4 to 2.5.<latest>.  Location:

	Documentation/filesystems/porting

It WILL be kept up-to-date.  IOW, submit an API change that may require
filesystem changes without a corresponding patch to that file and I will
hunt you down and hurt you.  Badly.

The same document covers "what do I need to change to keep my out-of-tree
filesystem uptodate".  So watch for changes there.

Normally when API change happens, the person doing it is responsible for
updating all in-tree filesystems or, at least, warning people about the
breakage.  Applying the list of broken filesystems.

Right now that list consists of umsdos and intermezzo.  The former will
be fixed after the next series of file_system_type cleanups.  The latter
is a victim of current changes in locking scheme.  Help from intermezzo
folks would be a good idea - preferably in the form that would reduce
the dependency on the VFS guts.

New locking scheme is described in Documentation/filesystems/directory-locking.
In details and with proof of correctness.

It doesn't change the exclusion warranties for filesystems, so unless they
mess with locking in non-trivial ways (intermezzo was the only in-tree
example) they shouldn't need any changes.  Some things might become simpler,
actually (i.e. in some cases private locking became redundant and can be
dropped).  Again, see Documentation/filesystems/porting for details of
changes.

Documentation/filesystems/Locking is slowly getting up-to-date.  Descriptions
of several superblock methods are still missing and I would really appreciate
it if folks who had introduced them would document them.

