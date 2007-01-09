Return-Path: <linux-kernel-owner+w=401wt.eu-S932487AbXAIWxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbXAIWxB (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbXAIWxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:53:01 -0500
Received: from dsl.amelek.gda.pl ([80.53.220.6]:58808 "EHLO alf.amelek.gda.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932487AbXAIWxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:53:00 -0500
X-Greylist: delayed 2597 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jan 2007 17:53:00 EST
Date: Tue, 9 Jan 2007 23:09:40 +0100
To: linux-kernel@vger.kernel.org
Cc: staubach@redhat.com
Subject: mmap / mtime updates
Message-ID: <20070109220940.GA16978@amelek.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

What is the current status of the bug where modifications to file
contents made via mmap fail to update mtime of the file?

This was discussed a few months ago in this thread:

http://lkml.org/lkml/2006/5/17/138

where patches have been posted, but it seems that no final solution
has been agreed on and applied to the kernel tree.  Updating ctime
and mtime appears to be required by the standard:

  http://www.opengroup.org/onlinepubs/009695399/functions/mmap.html

  The st_ctime and st_mtime fields of a file that is mapped with
  MAP_SHARED and PROT_WRITE shall be marked for update at some point
  in the interval between a write reference to the mapped region and
  the next call to msync() with MS_ASYNC or MS_SYNC for that portion
  of the file by any process.

and failing to do it can lead to potential data loss as well, if
modified files are not backed up (I'm seeing the problem with Samba
tdb files not being backed up by rsnapshot, for example).

Thanks,
Marek
