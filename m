Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272062AbRH2URc>; Wed, 29 Aug 2001 16:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272061AbRH2URW>; Wed, 29 Aug 2001 16:17:22 -0400
Received: from [208.48.139.185] ([208.48.139.185]:30595 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S272060AbRH2URI>; Wed, 29 Aug 2001 16:17:08 -0400
Date: Wed, 29 Aug 2001 13:17:20 -0700
From: David Rees <dbr@greenhydrant.com>
To: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        ext3-users@redhat.com
Subject: kupdated, bdflush and kjournald stuck in D state on RAID1 device (deadlock?)
Message-ID: <20010829131720.A20537@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
	ext3-users@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sent to linux-raid, linux-kernel and ext3-users since I'm not sure what type of issue
this is)

I've got a test system here running Redhat 7.1 + stock 2.4.9 with these
patches:

http://www.fys.uio.no/~trondmy/src/2.4.9/linux-2.4.9-NFS_ALL.dif
http://www.zip.com.au/~akpm/ext3-2.4-0.9.6-249.gz
http://domsch.com/linux/aacraid/linux-2.4.9-aacraid-20010816.patch

All three patches applied without any problems.

I've got a RAID1 device running over two IDE drives on a Promise controller. 
ext3 is the filesystem on the partition.  In this machine, the aacraid
driver isn't enabled.

The machine is to be used as a development database server running Sybase
11.9.2.  Shortly after installing Sybase and loading some data, I noticed
this:

[sybase@zorro ~]$ uptime
  1:01pm  up 1 day, 18:29,  3 users,  load average: 3.00, 3.00, 2.91
[sybase@zorro ~]$ ps aux | head -15
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  1368   72 ?        S    Aug27   0:05 init [3] 
root         2  0.0  0.0     0    0 ?        SW   Aug27   0:00 [keventd]
root         3  0.0  0.0     0    0 ?        SWN  Aug27   0:00 [ksoftirqd_CPU0]
root         4  0.0  0.0     0    0 ?        SW   Aug27   0:03 [kswapd]
root         5  0.0  0.0     0    0 ?        SW   Aug27   0:00 [kreclaimd]
root         6  0.0  0.0     0    0 ?        DW   Aug27   0:00 [bdflush]
root         7  0.0  0.0     0    0 ?        DW   Aug27   0:00 [kupdated]
root         9  0.0  0.0     0    0 ?        SW<  Aug27   0:00 [mdrecoveryd]
root        10  0.0  0.0     0    0 ?        SW<  Aug27   0:00 [raid1d]
root        11  0.0  0.0     0    0 ?        SW   Aug27   0:02 [kjournald]
root       130  0.0  0.0     0    0 ?        SW   Aug27   0:00 [kjournald]
root       131  0.0  0.0     0    0 ?        DW   Aug27   0:01 [kjournald]
root       374  0.0  0.0  1428  176 ?        S    Aug27   0:00 syslogd -m 0
root       379  0.0  0.0  1984  396 ?        S    Aug27   0:00 klogd -2
[sybase@zorro ~]$ 

As you can see, bdflush, kupdated and kjournald appear to be deadlocked.

How can I debug this problem and find out who's the problem?  I will try
rebooting and to see if the problem returns.  If it does, it's back to ext2
for me on this partition, I guess.  It seems like it could be a ext3
issue to me...

If there's any more information I can get, let me know.  I'll leave the
machine like this for a while before I reboot it.

Thanks,
-Dave
