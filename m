Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264802AbTE1RKm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 13:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264807AbTE1RKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 13:10:41 -0400
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:23914 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S264802AbTE1RKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 13:10:38 -0400
Date: Wed, 28 May 2003 19:23:32 +0200 (CEST)
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
cc: Bartlomiej Solarz <solarz@wsisiz.edu.pl>
Subject: Slocate/backup, big load on 2.4.X
Message-ID: <Pine.LNX.4.53.0305281852220.2970@lt.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I'm sorry for little off-topic, but I sure that's problem with kernel. :(
I have machine with two psyhical Intel(R) Xeon(TM) CPU 2.66GHz (four 
logical CPU Hyperthreading, 4GB RAM + 4GB SWAP eth PRO/1000, 5x SEAGATE 
discs ST373453LW, Adaptec AIC79XX scsi controler).
System is RH 8.0, 7129 users authenticated by LDAP-PAM)
After 12 hours of reboot, when updatedb is running or backup via amanda,
system "get" very high load, it's look like this:


 07:11:56  up 11:25,  5 users,  load average: 30.64, 23.32, 12.51
168 processes: 167 sleeping, 1 running, 0 zombie, 0 stopped
CPU0 states:   0.0% user  66.0% system    0.0% nice   0.0% iowait  33.1% idle
CPU1 states:   0.1% user  56.0% system    0.0% nice   0.0% iowait  42.0% idle
CPU2 states:   0.0% user  40.0% system    0.0% nice   0.0% iowait  59.0% idle
CPU3 states:   0.0% user  84.0% system    0.1% nice   0.0% iowait  14.0% idle
Mem:  4138956k av, 4054580k used,   84376k free,       0k shrd,  569536k buff
       700592k active,            3061800k inactive
Swap: 4096360k av,   12520k used, 4083840k free                 2841640k cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
 6189 root      19  19   632  632   416 D N  73.6  0.0  38:38   0 updatedb
    7 root      11   0     0    0     0 SW   66.8  0.0  50:40   3 kswapd


Load can be more than 100-150! One method to come back to normal situation
is killing updatedb process.
I have tried lot of latest kernels:

from 2.4.21-pre6 to 2.4.21-pre4, 2.4.21-rc4-ac1, 2.4.21-rc2-ac3
I have tried to switch off HIGHMEM64G and HIGHMEM options in 
configuration of kernel, too, but problem still exists.
I have tried aic79xx drivers from 
http://people.freebsd.org/~gibbs/linux/SRC/, but problem still exists :(

When updatedb run  on non /homeX  area, load is normall...

My home are looks like:
(ext3 with 1024 block size and fragment size)

oceanic:~$ mount |grep home |grep -v nfs
/dev/sdb2 on /home1 type ext3 (rw,nosuid,nodev,usrquota)
/dev/sdb3 on /home2 type ext3 (rw,nosuid,nodev,usrquota)
/dev/sdb4 on /home3 type ext3 (rw,nosuid,nodev,usrquota)
/dev/sdc2 on /home4 type ext3 (rw,nosuid,nodev,usrquota)
/dev/sdc3 on /home5 type ext3 (rw,nosuid,nodev,usrquota)
/dev/sdc4 on /home6 type ext3 (rw,nosuid,nodev,usrquota)
/dev/sdd2 on /home7 type ext3 (rw,nosuid,nodev,usrquota)
/dev/sdd3 on /home8 type ext3 (rw,nosuid,nodev,usrquota)
/dev/sdd4 on /home9 type ext3 (rw,nosuid,nodev,usrquota)
/dev/sde2 on /homea type ext3 (rw,nosuid,nodev,usrquota)
/dev/sde3 on /homeb type ext3 (rw,nosuid,nodev,usrquota)
/dev/sde4 on /homec type ext3 (rw,nosuid,nodev,usrquota)

df -h |grep home |grep -v ftp
/dev/sdb2              22G   14G  8.8G  61% /home1
/dev/sdb3              22G   17G  5.3G  76% /home2
/dev/sdb4              22G  9.6G   12G  43% /home3
/dev/sdc2              22G  9.0G   13G  41% /home4
/dev/sdc3              22G  7.3G   15G  33% /home5
/dev/sdc4              22G   14G  8.4G  63% /home6
/dev/sdd2              22G  7.0G   15G  32% /home7
/dev/sdd3              22G   18G  5.0G  78% /home8
/dev/sdd4              22G   16G  7.1G  69% /home9
/dev/sde2              22G   14G  9.0G  60% /homea
/dev/sde3              22G  9.0G   13G  41% /homeb
/dev/sde4              22G   19G  4.2G  81% /homec

Any idea? Bug on drivers scsi drivers, bug on ext3?

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
