Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132117AbRAIXEr>; Tue, 9 Jan 2001 18:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129859AbRAIXEh>; Tue, 9 Jan 2001 18:04:37 -0500
Received: from hera.cwi.nl ([192.16.191.1]:5051 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S132117AbRAIXD7>;
	Tue, 9 Jan 2001 18:03:59 -0500
Date: Wed, 10 Jan 2001 00:03:13 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200101092303.AAA149310.aeb@texel.cwi.nl>
To: mchouque@e-steel.com, viro@math.psu.edu
Subject: Re: Floppy disk strange behavior
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> dd: advancing past 1 blocks in output file `/dev/fd0': Permission denied

> dd bug. It tries to ftruncate() the output file and gets all upset when
> kernel refuses to truncate a block device (surprise, surprise).

Yes. But EPERM means that something is wrong with privileges.
One would expect EINVAL or so when something is wrong with the
way the routine was called.

Let me find my docs :-)

===== austin - d5 ============================================
...
If fildes refers to a regular file, the ftruncate( ) function shall cause
the size of the file to be truncated to length. If the size of the file
previously exceeded length, the extra data shall no longer be available
to reads on the file. If the file previously was smaller than this size,
ftruncate( ) shall either increase the size of the file or fail.
XSI-conformant systems shall increase the size of the file.
If the file size is increased, the extended area shall appear as if it
were zero-filled. The value of the seek pointer shall not be modified
by a call to ftruncate( ).
...
If fildes refers to a directory, ftruncate( ) shall fail.
...
If fildes refers to any other file type, except a shared memory object,
the result is unspecified.
=============================================================

No info on errors here.

===== Digital Unix man ======================================
...
The path parameter must point to a pathname which names
a regular file for which the calling process has write permission.
...
[EINVAL] The file is not a regular file
=============================================================

So, as was to be expected, other systems use EINVAL in this
situation, and so should we.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
