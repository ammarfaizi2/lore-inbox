Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273255AbRKHPIB>; Thu, 8 Nov 2001 10:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273261AbRKHPHt>; Thu, 8 Nov 2001 10:07:49 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:33748 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S273255AbRKHPHi>; Thu, 8 Nov 2001 10:07:38 -0500
Message-ID: <3BEA9F5F.3050204@antefacto.com>
Date: Thu, 08 Nov 2001 15:06:07 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ramfs isn't releasing deleted file blocks?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I remove files from a ramfs the space is not reclaimed?
What am I doing wrong? Details below.

thanks,
Padraig.
------------
host:/root# uname -a
Linux host 2.4.12-ac3 #5 Fri Oct 19 12:52:10 IST 2001 i686 unknown

host:/root# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/root                58997     47112      8839  84% /
ramfs                    63524      3360     60164   5% /var

host:/root# dd if=/dev/zero count=20000 bs=1024 of=/tmp/leak
20000+0 records in
20000+0 records out

host:/root# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/root                58997     47112      8839  84% /
ramfs                    63524     23360     40164  37% /var

host:/root# rm /tmp/leak

host:/root# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/root                58997     47112      8839  84% /
ramfs                    63524     23360     40164  37% /var

host:/root# mount
/dev/root on / type ext2 (ro)
proc on /proc type proc (rw)
ramfs on /var type ramfs (rw,noexec)

host:/root# cat /proc/meminfo
         total:    used:    free:  shared: buffers:  cached:
Mem:  130097152 48156672 81940480    49152  2990080 16277504
Swap:        0        0        0
MemTotal:       127048 kB
MemFree:         80020 kB
MemShared:          48 kB
Buffers:          2920 kB
Cached:          15896 kB
SwapCached:          0 kB
Active:           1760 kB
Inact_dirty:     17104 kB
Inact_clean:         0 kB
Inact_target:    26200 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       127048 kB
LowFree:         80020 kB
SwapTotal:           0 kB
SwapFree:            0 kB

