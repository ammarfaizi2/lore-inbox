Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbUK3JaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUK3JaS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 04:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbUK3JaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 04:30:18 -0500
Received: from dwdmx2.dwd.de ([141.38.3.197]:39193 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id S261764AbUK3JaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 04:30:11 -0500
Date: Tue, 30 Nov 2004 09:30:09 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@diagnostix.dwd.de
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problems with 2.6.10-rc2-bk12 and directory entries
Message-ID: <Pine.LNX.4.58.0411300905240.15173@diagnostix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Using 2.6.10-rc2-bk12 on a dual Xeon which serves files at a high rate
(>200 files/second), I noticed that when doing:

    ptr = dirname + strlen(dirname);
    dp = opendir(dirname);
    while ((dirp = readdir(dp)) != NULL)
    {
       if ((dirp->d_name[0] == '.') && ((dirp->d_name[1] == '\0') ||
           ((dirp->d_name[1] == '.') && (dirp->d_name[2] == '\0'))))
       {
          continue;
       }
       strcpy(ptr, dirp->d_name);
       if (unlink(dirname) == -1)
       {
          if (errno == ENOENT)
          {
             print some error
          }
       }
    }

That under higher load it happens that the unlink fails with ENOENT. And
this is true because the file was unlinked by a previous call. So it seems
that readdir() returns some file name that has already been removed.
This is not the only place, I have other code pathes where this also happens,
for example where I move the files away instead of unlinking.

This did not happen with 2.6.7 or any kernels before that. Filesystem is
ext3 without any extensions.

Is this a known problem? What can I do to resolve this?

Thanks,
Holger

PS: Please CC me since I am not on the list.
