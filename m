Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWCJF16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWCJF16 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 00:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWCJF16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 00:27:58 -0500
Received: from smtpauth07.mail.atl.earthlink.net ([209.86.89.67]:26002 "EHLO
	smtpauth07.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S1750701AbWCJF15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 00:27:57 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc5: process with huge vsize but no swap used
X-Mailer: MH-E 7.91; nmh 1.1; GNU Emacs 21.4.1
Date: Fri, 10 Mar 2006 00:25:16 -0500
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FHa7o-00015W-8g@approximate.corpus.cam.ac.uk>
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d478bbc7acd6dc94bc6b74265d5900179d7c32a4dba58047a976350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.6.91
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System is a Thinkpad 600X (Pentium III) w/ 576MB of RAM, 1GB of swap.

While testing 2.6.16-rc5 for ACPI issues, I ran across a vm behavior
that I've never seen before.  I had just booted and logged in via xdm,
and had opened a few small files in emacs.  All of a sudden
sudden emacs complained that:

  Memory exhausted--use M-x save-some-buffers RET

I didn't have any large files opened, but:

$ ps u3817
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
sanjoy    3817  0.1  2.0 1246160 11992 ?       S    Mar09   0:11 emacs -iconic

No swap is being used despite emacs allegedly consuming 1.2GB of VM:

$ free
             total       used       free     shared    buffers     cached
Mem:        580924     219964     360960          0      29124     128956
-/+ buffers/cache:      61884     519040
Swap:      1068280          0    1068280

Is that possible (maybe it's all zero-filled memory)?  If so, it's an
emacs bug that I've never seen before and I'll report it on the emacs
lists.  If it's not possible, then maybe it's a kernel issue.  I saved
/proc/3817/{maps,smaps,status,exe} just in case.

-Sanjoy

`A society of sheep must in time beget a government of wolves.'
   - Bertrand de Jouvenal
