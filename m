Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132606AbREHOnF>; Tue, 8 May 2001 10:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132636AbREHOmz>; Tue, 8 May 2001 10:42:55 -0400
Received: from lilly.ping.de ([62.72.90.2]:62983 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S132606AbREHOmp>;
	Tue, 8 May 2001 10:42:45 -0400
Date: Tue, 8 May 2001 16:42:43 +0200
From: Michael Stiller <michael@ping.de>
To: linux-kernel@vger.kernel.org
Cc: nfs@lists.sourceforge.net
Subject: 2.2.19 + reiserfs 3.5.32 nfsd wait_on_buffer/down_failed
Message-ID: <20010508164243.A23213@ping.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we run a nfs server utilizing 2.2.19 + ReiserFS version 3.5.32 on a
P 3 550 machine. Disk subsystem is a GDT7518RN using 4 UW disks as raid 5
device. After upgrading from 2.2.17 + reiserfs to 2.2.19 we experience
many (very much more than with 2.2.17) problems with our nfs clients
about 12 (linux). Network ist 100Mbit full duplex / switched. 
I do not think this is network related, cause ping -f doesnt show any
packet loss. 

During not so heavy IO on the exported fs
one nfsd thread seems to be waiting for the disk:

  621 root       1   0     0    0 wait_on_b DW    6.2  0.0   1:49 nfsd

and the other threads are waiting in down_fail:

  610 root       0   0     0    0 down_fail DW    0.0  0.0   1:52 nfsd
  611 root       0   0     0    0 down_fail DW    0.0  0.0   1:40 nfsd
  612 root       0   0     0    0 down_fail DW    0.0  0.0   1:41 nfsd
  613 root       0   0     0    0 down_fail DW    0.0  0.0   1:48 nfsd
  614 root       0   0     0    0 down_fail DW    0.0  0.0   1:45 nfsd
  615 root       0   0     0    0 down_fail DW    0.0  0.0   1:43 nfsd
  616 root       0   0     0    0 down_fail DW    0.0  0.0   1:50 nfsd
  617 root       0   0     0    0 down_fail DW    0.0  0.0   1:42 nfsd
  618 root       0   0     0    0 down_fail DW    0.0  0.0   1:44 nfsd
  619 root       0   0     0    0 down_fail DW    0.0  0.0   1:42 nfsd
  620 root       0   0     0    0 down_fail DW    0.0  0.0   1:47 nfsd
  622 root       0   0     0    0 down_fail DW    0.0  0.0   1:47 nfsd
  623 root       0   0     0    0 down_fail DW    0.0  0.0   1:43 nfsd
  624 root       0   0     0    0 down_fail DW    0.0  0.0   1:48 nfsd
  609 root       0   0     0    0 down_fail DW    0.0  0.0   1:50 nfsd

During this event:

- If i check the disk io with e.g. vmstat 1 the machine is doing about 200 bi
  per second, which is not so much i guess. 
- the client machines hang, should be clear:

nfs: server foo is not responding
nfs: server foo still not responding
nfs: server foo OK

Our idea is to revert back to 2.2.17 cause the behaviour was much better.

How can i debug this ? Can i do some tuning ? 
Should i revert to some older kernel. 
Are there any patches for this problem ? Does anyone has the same or
related problem ?

Any pointer would be useful.

TIA and cheers,

-Michael

-- 
In a world where an admin is rendered useless when the ball in his mouse
has been taken out, its good to know that I know UNIX. 
