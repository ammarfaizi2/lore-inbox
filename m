Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbVFJOOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbVFJOOs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 10:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbVFJOOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 10:14:47 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:25023 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262565AbVFJOOp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 10:14:45 -0400
Subject: Re: [Jfs-discussion] fsck.jfs segfaults on x86_64
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: jfs-discussion@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ag@m-cam.com
In-Reply-To: <a728f9f90506100700107976f0@mail.gmail.com>
References: <a728f9f90506100700107976f0@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 09:14:42 -0500
Message-Id: <1118412882.7944.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-10 at 10:00 -0400, Alex Deucher wrote:
> We have a large lvm2 logical volume (6.91T) which contains a JFS
> filesystem. The volumes accessed via emulex FC HBAs connected to a
> nexsan SAN.  There was a bug in the SAN firmware that caused the
> primary controller to lose sync with the other controller and go down.
>  Normally when this happens we are able to reboot the SAN and the
> server and then run fsck on the volume, and everything is fine (on a
> side note, we have updated the SAN firmware to fix the sync problem). 
> however, fsck now segfaults and the volume is dirty so it can't be
> mounted. lvdisplay and vgdisplay seem to work fine displaying the
> correct info.  Does anyone know what may be causing the problem or how
> we can fix it?  If possible I'd like to save the data on the volumes.
> 
> #> time fsck.jfs /dev/vg00/lvol0 
> fsck.jfs version 1.1.4, 30-Oct-2003

1.1.4 is quite old.  Can you try a recent version of jfsutils?
http://jfs.sourceforge.net/project/pub/jfsutils-1.1.8.tar.gz

If that doesn't work, you can try running "fsck.jfs
--omit_journal_replay", since it is trapping while replaying the
journal.  If all else fails, you should be able to mount it read-only
(mount -oro) to recover the data.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

