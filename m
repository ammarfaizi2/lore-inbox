Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264655AbSJOP26>; Tue, 15 Oct 2002 11:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264656AbSJOP26>; Tue, 15 Oct 2002 11:28:58 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:23745 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S264655AbSJOP2z>; Tue, 15 Oct 2002 11:28:55 -0400
Subject: Problem with jfs and dbench 80 (ext3, reiserfs, xfs are OK)
From: Steven Cole <elenstev@mesatop.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 15 Oct 2002 09:29:54 -0600
Message-Id: <1034695794.13083.27.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have run into problems running dbench with 80 clients
on a jfs partition.

Using 2.5.41-bk2 over the weekend, I ran dbench with up
to 128 clients on a single PIII, IDE machine running X.

Dbench runs on ext3, reiserfs, and xfs partitions were
completely successful.  I was able to run dbench with
1,2,3,4,6,10,12,16,20,24,28,32,36,40,44,48,52,56,64,80,96,112
and 128 clients.

However on the jfs partition, the maxiumum dbench run was 64 clients.
At 80 clients, the dbench output stopped for many hours. This was
repeatable. Twice, the increasing client dbench script stopped at 80.

Here is a snippet from running ps with these options:

ps -ewo user,pid,priority,%cpu,stat,command,wchan

root     11058  15  0.0 DW   [pdflush]        lmGroupCommit
steven   11060  16  0.0 S    time -v ./dbench wait4
steven   11061  15  0.0 S    ./dbench 80      wait4
steven   11062  15  0.0 D    ./dbench 80      TXN_SLEEP_DROP_LOCK
steven   11065  15  0.0 D    ./dbench 80      TXN_SLEEP_DROP_LOCK
steven   11068  15  0.0 D    ./dbench 80      lmGroupCommit

This was with dbench running on a jfs partition (/dev/hda11).

Filesystem    Type    Size  Used Avail Use% Mounted on
/dev/hda1     ext3    236M   56M  168M  25% /
/dev/hda9     ext3     20G  7.3G   13G  38% /home
/dev/hda11     jfs    3.9G  478M  3.5G  13% /share_jfs
/dev/hda10
          reiserfs    4.0G   37M  3.9G   1% /share_reiser
/dev/hda12     xfs    4.8G  253M  4.6G   6% /share_xfs
/dev/hda8     ext3    236M  4.7M  219M   3% /tmp
/dev/hda6     ext3    2.9G  1.3G  1.5G  47% /usr
/dev/hda7     ext3    479M   60M  395M  14% /var

I now find that if I try to ls the dbench directory on
/share_jfs, the ls command hangs.  I was able to ls directories
above /share_jfs/steven/dbench earlier but now any ls command
on /share_jfs hangs.  If I know the filename, I can cat the file,
for example my log of the dbench run, so reading of individual files
is still working.

Steven




