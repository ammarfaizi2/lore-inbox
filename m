Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbVKFPDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbVKFPDo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 10:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbVKFPDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 10:03:43 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:9110 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750947AbVKFPDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 10:03:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:content-type:mime-version:content-transfer-encoding:message-id:user-agent;
        b=lj3FOp511foIF29R9CnZMZEMj3edVzEI3k2EaHRCIInDL2mC+2c08DKuNFhgI2y1TKXRHyVqxOFXrhcISURrLOm33fqMQ7ag2ztA79yx5qyx8HLsTBabCu36gokW9zxKx46yangFMhHlkzSCD+i4LHS4dEU7XT94FXtihq+r+wg=
Date: Sun, 06 Nov 2005 18:05:03 +0300
From: unDEFER <undefer@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: FileSystem, "." and "..", rmdir
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <op.sztqupcjty9wl4@undecomp>
User-Agent: Opera M2/8.50 (Linux, build 1358)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm newbie in kernel programming and try to write filesystem, and have two problems.

1) There are not "<mount-point>/.", "<mount-point>/..", and "<mount-point>/<any_dir>/.." entries,
for example:
# ls -a
dir  link  text_file
# ls -a dir/
.  level_2
# ls -a dir/level_2/
.  ..

I make
      filldir(dirent, ".", 1, i, ino, DT_DIR) and
      filldir(dirent, "..", 2, i, parent_ino(filp->f_dentry))
in readdir() for all directories.

2) Problem with removing not empty directories:
# ls -l
total 135
drwxr-xr-x  3 root root      0 Nov  6 17:48 dir
lr-xr-xr-x  1 root root   1024 Nov  2 11:13 link -> /home/undefer
-r-xr-xr-x  1 root root 274944 Nov  2 11:13 text_file

# rmdir dir
rmdir: `dir': Directory not empty

# ls -l
total 135
?---------  0 root root      0 Jan  1  1970 dir
lr-xr-xr-x  1 root root   1024 Nov  2 11:13 link -> /home/undefer
-r-xr-xr-x  1 root root 274944 Nov  2 11:13 text_file

So anything call "delete_inode" for directory and it's entries but it is not empty! What is? Why? What I could made not so?

Thanks,
Sorry for bad english.

-- 
registered Linux user #360474
Don't worry, I can read OpenOffice.org
