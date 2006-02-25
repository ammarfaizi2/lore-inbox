Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWBYWBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWBYWBd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 17:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWBYWBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 17:01:33 -0500
Received: from ns2.suse.de ([195.135.220.15]:45212 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750728AbWBYWBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 17:01:32 -0500
Date: Sat, 25 Feb 2006 23:01:30 +0100
From: Olaf Hering <olh@suse.de>
To: Dave Johnson <djohnson+linux-kernel@sw.starentnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cramfs mounts provide corrupted content since 2.6.15
Message-ID: <20060225220130.GA2748@suse.de>
References: <20060225110844.GA18221@suse.de> <20060225125551.GA21203@suse.de> <17408.34808.422077.518881@zeus.sw.starentnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17408.34808.422077.518881@zeus.sw.starentnetworks.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Feb 25, Dave Johnson wrote:

> Looking at your output it's definitely getting inodes confused with
> each other so the checks in cramfs_iget5_test() aren't working.
> 
> Can you stat the files in question to make sure they are actually
> inode #1 on a working as well as non-working kernel?  If your mkcramfs
> isn't using #1 for empty files/links/dirs that'd be the problem.

Another try, and different results again:

./etc/nsswitch.conf: FAILED
./usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/Data/Dumper/Dumper.so: FAILED
./usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/Fcntl/Fcntl.so: FAILED
./usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/IO/IO.so: FAILED
./usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/POSIX/POSIX.so: FAILED
./usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/Sys/Hostname/Hostname.so: FAILED
./usr/lib/perl5/vendor_perl/5.8.8/ppc-linux-thread-multi-64int/auto/Compress/Zlib/Zlib.so: FAILED
./usr/lib/perl5/vendor_perl/5.8.8/ppc-linux-thread-multi-64int/auto/Locale/gettext/gettext.so: FAILED

inode numbers match in both cases, just the filesize is zero and they have only one block.


  File: `./usr/lib/perl5/vendor_perl/5.8.8/ppc-linux-thread-multi-64int/auto/Locale/gettext/gettext.so'
  Size: 0               Blocks: 1          IO Block: 4096   regular empty file
Device: 701h/1793d      Inode: 53053956    Links: 1
Access: (0444/-r--r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 1970-01-01 01:00:00.000000000 +0100
Modify: 1970-01-01 01:00:00.000000000 +0100
Change: 1970-01-01 01:00:00.000000000 +0100

  File: `./usr/lib/perl5/vendor_perl/5.8.8/ppc-linux-thread-multi-64int/auto/Locale/gettext/gettext.so'
  Size: 24004           Blocks: 47         IO Block: 4096   regular file
Device: 702h/1794d      Inode: 53053956    Links: 1
Access: (0555/-r-xr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 1970-01-01 01:00:00.000000000 +0100
Modify: 1970-01-01 01:00:00.000000000 +0100
Change: 1970-01-01 01:00:00.000000000 +0100


./var/spool/locks turned into a file:

  File: `./var/spool/locks'
  Size: 0               Blocks: 1          IO Block: 4096   regular empty file
Device: 701h/1793d      Inode: 85741484    Links: 1
Access: (0600/-rw-------)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 1970-01-01 01:00:00.000000000 +0100
Modify: 1970-01-01 01:00:00.000000000 +0100
Change: 1970-01-01 01:00:00.000000000 +0100

  File: `./var/spool/locks' -> `../lock'
  Size: 7               Blocks: 1          IO Block: 4096   symbolic link
Device: 702h/1794d      Inode: 85741484    Links: 1
Access: (0777/lrwxrwxrwx)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 1970-01-01 01:00:00.000000000 +0100
Modify: 1970-01-01 01:00:00.000000000 +0100
Change: 1970-01-01 01:00:00.000000000 +0100

