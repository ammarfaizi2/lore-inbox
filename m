Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266705AbUIAQ5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266705AbUIAQ5p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267438AbUIAQy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 12:54:28 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:29137 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S267408AbUIAQuq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 12:50:46 -0400
Date: Wed, 1 Sep 2004 18:50:43 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: lookup() on non-directories.
Message-ID: <20040901165043.GA31757@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The reiserfs4 and openat() discussion made me thinking. This is different:

* /dev/hda1 -> /dev/hda/1
  => /dev/hda/1 causes a lookup in the partition table of /dev/hda

* /dev/hda/1/. is a "root inode lookup" in the superblock inside /dev/hda/1: no
  explicit mount/umount but just the usual refcounting. File system type? the
  kernel already knows about this stuff: needed for mounting the root-fs.
  /dev/hda/1 need not be a special file.

* /usr/X11R6/bin/xterm/... ?
  Kernel has some knowledge about ELF (fs/binfmt_*) so this could mean
  something.

So what's the concept?

lookup() on files are just _interpretations_ of the file based on
knowledge the kernel already has. Interpretations might require
access( , X_OK) == 0 for sanity (in addition to R_OK and/or W_OK).

This way, user mounts/automounter would no longer be a requirement for
the user in order to get access to the usual things like USB storage,
CDROM, DVD, or images of those.

yes I know, this does not address the samba or reiserfs4 issues: openat()
name space now becomes orthogonal.

-- 
Frank
