Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263022AbREWJSH>; Wed, 23 May 2001 05:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263025AbREWJRs>; Wed, 23 May 2001 05:17:48 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:41743 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S263022AbREWJRi>; Wed, 23 May 2001 05:17:38 -0400
Message-ID: <3B0B8001.88E98412@idb.hist.no>
Date: Wed, 23 May 2001 11:16:49 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre2 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Manas Garg <mls@chakpak.net>
CC: linux-kernel@vger.kernel.org
Subject: OT: O_TRUNC problem on a full filesystem
In-Reply-To: <20010523114318.A8336@cygsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manas Garg wrote:
> 
> I am not sure if it should be classified as a bug, that's why I am calling it a
> problem. Here is the description:
Not a bug.

> If the filesystem is full, obviously, I can't write anything to that any
> longer. But if I open a file with O_TRUNC flag set, the file will be truncated.
> Any program that opens a file with O_TRUNC flag set, wishes to write something
> there later on. But because the filesystem is full, it can't write. It would
> definitely happen if the file is not huge (TESTED). But I am not sure what
> happens if the file _is_ huge (NOT TESTED).

Truncating the file frees up the space it took, and will allow writing.
but someone else may grab the space before you - there is no guarantee
on a multi-process system.  

Note that the last few % of the disk is reserved for root.  So it will
be
"full" for users even if there is a few % left.  Root may have filled
the disk
well into the reserved part (logfiles etc.)  A user deleting a small
file
will free up some space, but the fs may still be overfull, i.e. less
than those few % in free space.  This is probably what happened to you.

> I lost configuration files of a few programs this way. While exiting, they
> opened their conf files with O_TRUNC flag but couldn't write anything there.

Ill-written programs - complain to the maintainers.
write a new config file with a different name first, 
then rename it onto the old name.  This fails gracefully
on a full fs, you get to keep the old file.

Or have a fixed-size config file and update the
contents in place.
