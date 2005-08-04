Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbVHDLAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbVHDLAA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 07:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbVHDLAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 07:00:00 -0400
Received: from piraten.student.lu.se ([130.235.208.46]:65181 "EHLO
	piraten.student.lu.se") by vger.kernel.org with ESMTP
	id S262470AbVHDK77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 06:59:59 -0400
Date: Thu, 04 Aug 2005 12:59:56 +0200
From: Johan Veenhuizen <veenhuizen@users.sf.net>
Subject: Re: [PATCH 2.6.12.3] Deny chmod in /proc/<pid>/
In-reply-to: <Pine.LNX.4.61.0508040804540.22272@yvahk01.tjqt.qr>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <42f1f52c.i789DItxDhDreK/t%veenhuizen@users.sf.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
User-Agent: nail 11.24 7/14/05
References: <42efd43d.ijkrXtpGJUM7deW2%veenhuizen@users.sf.net>
 <Pine.LNX.4.61.0508030816150.2263@yvahk01.tjqt.qr>
 <42f096e7.9SOTOrosbBYB6uCh%veenhuizen@users.sf.net>
 <Pine.LNX.4.61.0508040804540.22272@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> >Did you mean "chmod"?
>
> No, I really meant chown - which just turned up another should-not-be:
> no warning is generated when trying to chown;
> chmod is even _persistent_ - for the moment.
>

Did you even bother to read my first mail?  Quoting myself:

    "The patch does also trigger an EPERM when someone tries
    to chown/chgrp an entry (which is currently silently ignored)."
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

and

    "... it is currently possible for the owner of a process to
    temporarily chmod the entries."

Those are the problems that my patch fixes!  And NO, chmod is NOT
persistent.  It just appears to be.  The permissions are dropped
when the dentry for a file is released (and with it, the reference
to the temporary inode).  (You might have understood this.
I don't know what you mean by "for the moment".)

It's a very Bad Thing that the chmod succeeds for a while, because
it gives users the impression that the files can be protected
(e.g. /proc/<pid>/cmdline).  As it is now, you'll have to look
at the kernel source to figure out which files will preserve
their permissions...

> >And I don't even have "smaps".
>
> Just take any file.

Not any file exists under /proc, so I'll rather take a file that
is there for my examples.

	Johan
