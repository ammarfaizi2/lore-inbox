Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbTIWPyl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 11:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbTIWPyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 11:54:41 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:16790 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261537AbTIWPyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 11:54:40 -0400
Date: Tue, 23 Sep 2003 17:54:39 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Bind Mount Extensions (RO --bind mounts)
Message-ID: <20030923155439.GA7470@DUK2.13thfloor.at>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All!

just verified that the patches still apply on  
linux-2.6.0-test5-bk9 and linux-2.4.23-pre5  
without any issues ...

FYI, this patch (hopefully) allows RO --bind mounts 
to 'behave' like other ro mounted filesystems ...

AFAIK, it handles the following cases as expected:

 - open (read/write/trunc), create
 - link, symlink, unlink
 - mknod (reg/block/char/fifo), mkfifo
 - mkdir, rmdir
 - (f)chown, (f)chmod, utimes
 - ioctl (gen/ext2/ext3/reiser)
 - access, truncate

it doesn't handle update_atime() yet (Al Viro is still
busy ;) and it doesn't change current intermezzo code 
(but this would be easy to add, because it's almost the 
same as the vfs_*()s at least regarding ro --bind mounts)

you can get them at:

http://vserver.13thfloor.at/Experimental/patch-2.4.22-rc2-bme0.03.diff
http://vserver.13thfloor.at/Experimental/patch-2.4.22-rc2-bme0.03.diff.bz2
http://vserver.13thfloor.at/Experimental/patch-2.6.0-test3-bme0.03.diff
http://vserver.13thfloor.at/Experimental/patch-2.6.0-test3-bme0.03.diff.bz2

enjoy,
Herbert


