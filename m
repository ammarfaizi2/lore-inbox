Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWFUFCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWFUFCM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 01:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWFUFCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 01:02:12 -0400
Received: from mail.bmlv.gv.at ([193.171.152.37]:25497 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id S1750737AbWFUFCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 01:02:11 -0400
From: "Ph. Marek" <philipp.marek@bmlv.gv.at>
To: linux-kernel@vger.kernel.org
Subject: Problem with lstat64 and ctime
Date: Wed, 21 Jun 2006 07:02:26 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606210702.27473.philipp.marek@bmlv.gv.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

I have a problem with lstat64() reporting a wrong (?) ctime.

Please take a look at this strace snippet:

06:44:45.003059 open("/dev/null", O_RDONLY) = 4
06:44:45.003094 open("./4/8/10.txt.up.tmp", 
	O_WRONLY|O_CREAT|O_TRUNC, 0600) = 5
06:44:45.003145 open("/tmp/ram/fsvs-test-1000/tmp-repos-path/db/revs/4", 
	O_RDONLY) = 6
06:44:45.003187 lseek(6, 2630937, SEEK_SET) = 2630937
06:44:45.003217 read(6, "id: 13j.0.r4/2630937\ntype: file\n"..., 
	4096) = 4096
06:44:45.003273 close(6)                = 0
06:44:45.003316 open("/tmp/ram/fsvs-test-1000/tmp-repos-path/db/revs/4", 
	O_RDONLY) = 6
06:44:45.003357 lseek(6, 40515, SEEK_SET) = 40515
06:44:45.003386 read(6, "DELTA\nSVN\0\0\0\7\1\7\2074-8-10\nENDREP\nDE"..., 
	4096) = 4096
06:44:45.003435 write(5, "4-8-10\n", 7) = 7
06:44:45.003481 open("/tmp/ram/fsvs-test-1000/tmp-repos-path/db/revs/4", 
	O_RDONLY) = 7
06:44:45.003524 lseek(7, 2630937, SEEK_SET) = 2630937
06:44:45.003554 read(7, "id: 13j.0.r4/2630937\ntype: file\n"..., 
	4096) = 4096
06:44:45.003610 close(7)                = 0
06:44:45.003650 close(5)                = 0
06:44:45.003679 close(4)                = 0
06:44:45.003707 chown32("./4/8/10.txt.up.tmp", 1000, 1000) = 0
06:44:45.003741 chmod("./4/8/10.txt.up.tmp", 0644) = 0
06:44:45.003778 utimes("./4/8/10.txt.up.tmp", 
	{1150863412, 890049}) = 0
06:44:45.003813 lstat64("./4/8/10.txt.up.tmp", 
	{st_dev=makedev(0, 14), st_ino=4139057, st_mode=S_IFREG|0644, 
	 st_nlink=1, st_uid=1000, st_gid=1000, st_blksize=4096, 
	 st_blocks=8, st_size=7, st_atime=2006/06/21-06:16:52, 
	 st_mtime=2006/06/21-06:16:52, 
	 st_ctime=2006/06/21-06:44:44}) = 0			<<<=======HERE
06:44:45.003896 rename("./4/8/10.txt.up.tmp", "./4/8/10.txt") = 0
06:44:45.003935 close(6)                = 0

If you take a look at the marked line, you see that the reported ctime is a 
second lower than expected.
An "ls -lac --full-time" of this file shows the expected value 
06:44:45.003875.

This is on 2.6.16.14, compiled with debian gcc 4.1.2 20060604 prerelease, on 
an Pentium M 1.73GHz; the filesystem is tmpfs.


Is that the correct behaviour, or a known failure of the kernel?
How can I work around that?


Thank you for your help!


Regards,

Phil
