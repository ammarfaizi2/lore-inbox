Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTEVNN3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 09:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbTEVNN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 09:13:29 -0400
Received: from codeblau.walledcity.de ([212.84.209.34]:40204 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S261840AbTEVNN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 09:13:28 -0400
Date: Thu, 22 May 2003 15:26:46 +0200
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: corrupt ext3 that even debugfs refuses to repair
Message-ID: <20030522132646.GB1506@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just found out that my CVS ext3 file system is corrupted.
The symptom is that du complains about "file not found", i.e. getdents64
returns the files but stat says they aren't there.

e2fsck finds nothing wrong with the filesystem.

I isolated the files into one directory which I moved to /broken.  This
is what debugfs says:

# debugfs -w /dev/discs/disc0/part5
debugfs 1.33 (21-Apr-2003)
debugfs:  cd /broken
debugfs:  ls
 6243596  (12) .    2  (4084) ..    0  (4096) nsISO88592ToUnicode.cpp
 0  (4096) nsKOI8UToUnicode.o    0  (4096) nsUnicodeToMacDevanagari.h
 0  (4096) nsUnicodeToZapfDingbat.h    0  (620) nsCP1258ToUnicode.h
 6243907  (3476) .cvsignore    0  (4096) nsMacUkrainianToUnicode.cpp
debugfs:  rm foo
rm: File not found by ext2_lookup while trying to resolve filename
debugfs:  ls
ls: invalid option -- o
zsh: 5846 segmentation fault  debugfs -w /dev/discs/disc0/part5


Huh?  debugfs does not appear to be a very stable tool ;)
Once again, with nsCP1258ToUnicode.h this time:

debugfs:  rm nsCP1258ToUnicode.h
rm: File not found by ext2_lookup while trying to resolve filename
debugfs:  unlink nsCP1258ToUnicode.h
unlink_file_by_name: No free space in the directory

What can I do now (besides backup and restore, obviously)
