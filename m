Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbTHTRUL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 13:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbTHTRUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 13:20:11 -0400
Received: from chaos.analogic.com ([204.178.40.224]:50048 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262093AbTHTRRm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 13:17:42 -0400
Date: Wed, 20 Aug 2003 13:19:41 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: linuxmodule@altern.org
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3 module compilation
In-Reply-To: <S261663AbTHTQkp/20030820164045Z+1122@vger.kernel.org>
Message-ID: <Pine.LNX.4.53.0308201315030.11317@chaos>
References: <S261663AbTHTQkp/20030820164045Z+1122@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Aug 2003 linuxmodule@altern.org wrote:

> I am trying to compile a module on 2.6.0-test3 kernel. The makefile i
> am using is a pretty normal one :
>
> CFLAGS = -D__KERNEL__ -DMODULE -I/usr/src/linux-2.6.0-test3/include -O
> dummy.o: dummy.c
>
> The module i am trying to compile is taken from the kernel itself
> (dummy network device driver). The
> compilation works flawlessly but when i try to insert the module i get
> : invalid module format.
> What am i doing wrong because i have modutils and module-init and both
> work, since the same module (dummy)
> compiled with the kernel itself can be inserted and removed
> without the previous error message.
> Is there something i should know about the compilation process ?
> The kernel-compiled module (dummy.ko) has
> about 10 Kbytes and dummy.ko compiled by me has only 2 Kbytes :(
>
> Thank you in advance
> Snowdog

I can't tell how CFLAGS is being used (with the colon???).
Anyway, the correct way to build the module (for 2.4.20) is:

Script started on Wed Aug 20 13:09:15 2003
# gcc -c -o dummy.o -DMODULE -D__KERNEL__ -O2 \
  -I/usr/src/linux-2.4.20/include dummy.c
You have new mail in /var/spool/mail/root

# insmod dummy.o
# lsmod
Module                  Size  Used by
dummy                   1052   0  (unused)
vximsg                  3784   0  (autoclean)
vxidrvr                 1548   0  (autoclean)
st                     29592   0  (autoclean) (unused)
nfs                    47848   0  (autoclean)
lockd                  37244   0  (autoclean) [nfs]
sunrpc                 63228   0  (autoclean) [nfs lockd]
ipchains               41400   7
3c59x                  28224   1  (autoclean)
nls_cp437               4376   4  (autoclean)
isofs                  17232   0  (unused)
loop                    8632   0
sr_mod                 11964   0  (unused)
cdrom                  27936   0  [sr_mod]
BusLogic               35768   7
sd_mod                 10184  14
scsi_mod               54572   4  [st sr_mod BusLogic sd_mod]
# ifconfig dummy0 1.2.3.4
# ifconfig
dummy0    Link encap:Ethernet  HWaddr 00:00:00:00:00:00
          inet addr:1.2.3.4  Bcast:1.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING NOARP  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0

eth0      Link encap:Ethernet  HWaddr 00:50:DA:19:7A:7D
          inet addr:10.100.2.224  Bcast:10.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:3959973 errors:0 dropped:0 overruns:0 frame:0
          TX packets:442389 errors:0 dropped:0 overruns:0 carrier:0
          collisions:22249 txqueuelen:100
          Interrupt:10 Base address:0xb800

eth0:1    Link encap:Ethernet  HWaddr 00:50:DA:19:7A:7D
          inet addr:10.106.100.167  Bcast:10.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:10 Base address:0xb800

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:7722 errors:0 dropped:0 overruns:0 frame:0
          TX packets:7722 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0

You have new mail in /var/spool/mail/root
# rmmod dummy
# exit
exit

Script done on Wed Aug 20 13:11:53 2003


...and it works.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


